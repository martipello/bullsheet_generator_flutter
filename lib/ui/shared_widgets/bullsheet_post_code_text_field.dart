import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/models/api_response.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/string_extension.dart';
import '../../view_models/location_view_model.dart';
import 'bullsheet_dialog.dart';
import 'bullsheet_loading_widget.dart';

typedef Validator = String? Function(dynamic value);

class BullsheetPostCodeTextField extends StatefulWidget {
  BullsheetPostCodeTextField({
    Key? key,
    required this.textController,
    this.validator,
  }) : super(key: key);

  final TextEditingController textController;
  final Validator? validator;

  @override
  State<BullsheetPostCodeTextField> createState() => _BullsheetPostCodeTextFieldState();
}

class _BullsheetPostCodeTextFieldState extends State<BullsheetPostCodeTextField> {
  final _locationViewModel = getIt.get<LocationViewModel>();

  @override
  void initState() {
    super.initState();
    _buildPostCodeListener();
    if (Platform.isAndroid) {
      _buildServiceStatusListener();
    } else {
      _buildPermissionStatusListener();
    }
  }

  void _buildServiceStatusListener() {
    _locationViewModel.isLocationServiceEnabledStream
        .exhaustMap(
      (isServiceEnabled) => isServiceEnabled == false
          ? BullsheetDialog(
              title: 'Service Unavailable',
              content: const Text(
                'Either the location is off '
                'or there is another issue '
                'preventing us getting your location.',
              ),
            ).show(context).asStream()
          : Stream.value(true),
    )
        .listen(
      (isServiceEnabled) {
        if (isServiceEnabled == true) {
          _buildPermissionStatusListener();
        }
      },
    );
  }

  void _buildPermissionStatusListener() async {
    _locationViewModel.hasPermissionStream
        .exhaustMap((hasPermission) => hasPermission == false
            ? BullsheetDialog(
                title: 'Permissions Error',
                content: const Text(
                  'Enable permissions in settings.',
                ),
              ).show(context).asStream()
            : Stream.value(true))
        .listen(
      (hasPermission) {
        if (hasPermission == true) {
          _locationViewModel.getPostCode();
        }
      },
    );
  }

  void _buildPostCodeListener() {
    _locationViewModel.postCodeStream.listen((postCode) {
      if (postCode.data.isNotNullOrEmpty()) {
        widget.textController.text = postCode.data!;
      }
    }, onError: (e) {
      return BullsheetDialog(
        title: 'Error',
        content: const Text(
          'Couldn\'t get your location.',
        ),
      ).show(context);
    });
  }

  @override
  void dispose() {
    _locationViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<String?>>(
      stream: _locationViewModel.postCodeStream,
      builder: (context, snapshot) {
        final isLoading = snapshot.data?.status == Status.LOADING;
        return TextFormField(
          controller: widget.textController,
          maxLines: 1,
          style: context.text.bodyMedium,
          decoration: _buildInputDecoration(
            context,
            isLoading: isLoading,
          ),
          onEditingComplete: () => context.nextEditableTextFocus(),
          validator: widget.validator,
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(
    BuildContext context, {
    bool isLoading = false,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      labelText: 'Post Code',
      labelStyle: context.text.bodyMedium,
      errorMaxLines: 3,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 48,
        maxWidth: 48,
      ),
      suffixIcon: isLoading
          ? const Center(
              child: SizedBox(
                height: 18,
                width: 18,
                child: BullsheetLoadingWidget(
                  width: 2,
                ),
              ),
            )
          : IconButton(
              icon: const Icon(Icons.location_searching_rounded),
              onPressed: () {
                _locationViewModel.hasPermission();
                _locationViewModel.isLocationServiceEnabled();
              },
            ),
    );
  }
}
