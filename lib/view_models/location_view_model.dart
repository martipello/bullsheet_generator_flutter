import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';

import '../api/models/api_response.dart';

class LocationViewModel {
  final hasPermissionStream = BehaviorSubject<bool>();
  final isLocationServiceEnabledStream = BehaviorSubject<bool>();
  final postCodeStream = BehaviorSubject<ApiResponse<String?>>();

  void getPostCode() async {
    try {
      postCodeStream.add(ApiResponse.loading(null));
      await Future.delayed(const Duration(seconds: 1));
      final location = await _getLastKnownPosition();
      final address = await placemarkFromCoordinates(location.latitude, location.longitude, localeIdentifier: 'en_UK');
      postCodeStream.add(ApiResponse.completed(address.first.postalCode));
    } catch (e) {
      postCodeStream.addError(e);
    }
  }

  Future<Position> _getCurrentPosition() {
    return Geolocator.getCurrentPosition();
  }

  Future<Position> _getLastKnownPosition() async {
    final lastKnownPosition = await Geolocator.getLastKnownPosition();
    if (lastKnownPosition != null) {
      return lastKnownPosition;
    }
    return _getCurrentPosition();
  }

  Future<void> enableService() async {
    return AppSettings.openLocationSettings();
  }

  void isLocationServiceEnabled() {
    //TODO using GeoLocator to ask for permissions due to location plugin bug
    //TODO https://github.com/Lyokone/flutterlocation/issues/172
    Geolocator.isLocationServiceEnabled().then(isLocationServiceEnabledStream.add);
  }

  Future<void> hasPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      hasPermissionStream.add(false);
    } else {
      hasPermissionStream.add(true);
    }
  }

  void requestPermission() async {
    final permissionStatus = await Geolocator.requestPermission();
    if (permissionStatus == LocationPermission.denied || permissionStatus == LocationPermission.deniedForever) {
      hasPermissionStream.add(false);
    } else {
      hasPermissionStream.add(true);
    }
  }

  void dispose() {
    hasPermissionStream.close();
    isLocationServiceEnabledStream.close();
    postCodeStream.close();
  }
}
