import '../api/models/job.dart';

extension JobExtension on Job? {
  String createJobId() {
    return DateTime.now().toIso8601String();
  }
}
