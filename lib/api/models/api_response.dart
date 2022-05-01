import '../models/error_response.dart';

extension ApiResponseExtension on ApiResponse {
  bool hasCompletedWithData() {
    return status == Status.COMPLETED && data != null;
  }
}

class ApiResponse<T> {
  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(
    this.message, {
    this.error,
    this.data,
  }) : status = Status.ERROR;

  Status status;
  T? data;
  String? message;
  ErrorResponse? error;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

// ignore: constant_identifier_names
enum Status { LOADING, COMPLETED, ERROR }
