import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  DateTime removeTime() {
    final thisDate = this ?? DateTime.now();
    return DateTime.utc(thisDate.year, thisDate.month, thisDate.day);
  }

  DateFormat dateAndTimeFormat() {
    if (this != null) {
      final dayOfMonthSuffix = getDayOfMonthSuffix(this!.day);
      return DateFormat("EEEE d'$dayOfMonthSuffix' MMMM yyyy 'at' HH:mm aaa");
    }
    return DateFormat("EEEE d MMMM yyyy 'at' HH:mm aaa");
  }

  DateFormat dateFormat() {
    if (this != null) {
      final dayOfMonthSuffix = getDayOfMonthSuffix(this!.day);
      return DateFormat("EEEE d'$dayOfMonthSuffix' MMMM yy");
    }
    return DateFormat('EEEE d MMMM yy');
  }

  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  DateTime firstDayOfMonth() {
    if (this != null) {
      return DateTime.utc(this!.year, this!.month, 1);
    }
    final today = DateTime.now();
    return DateTime.utc(today.year, today.month, 1);
  }

  DateTime lastDayOfMonth() {
    if (this != null) {
      return DateTime.utc(
        this!.year,
        this!.month + 1,
        0,
        23,
        59,
      );
    }
    final today = DateTime.now();
    return DateTime.utc(today.year, today.month + 1, 0, 23, 59);
  }

  DateTime firstDayOfWeek() {
    if (this != null) {
      //TODO swap this for material localization
      final weekDay = this!.weekday == 7 ? 0 : this!.weekday;
      final firstDay = this!.subtract(Duration(days: weekDay));
      return DateTime.utc(firstDay.year, firstDay.month, firstDay.day);
    }
    final today = DateTime.now();
    final weekDay = today.weekday == 7 ? 0 : today.weekday;
    final firstDay = today.subtract(Duration(days: weekDay));
    return DateTime.utc(firstDay.year, firstDay.month, firstDay.day);
  }

  DateTime lastDayOfWeek() {
    if (this != null) {
      final weekDay = this!.weekday == 7 ? 0 : this!.weekday;
      final lastDay = this!.add(
        Duration(
          days: DateTime.daysPerWeek - weekDay - 1,
        ),
      );
      return DateTime.utc(
        lastDay.year,
        lastDay.month,
        lastDay.day,
        23,
        59,
      );
    }
    final today = DateTime.now();
    final weekDay = today.weekday == 7 ? 0 : today.weekday;
    final lastDay = today.add(
      Duration(
        days: DateTime.daysPerWeek - weekDay - 1,
      ),
    );
    return DateTime.utc(
      lastDay.year,
      lastDay.month,
      lastDay.day,
      23,
      59,
    );
  }

  DateTime endOfDay() {
    final date = this ?? DateTime.now();
    return DateTime.utc(
      date.year,
      date.month,
      date.day + 1,
      0,
      -1,
    );
  }

  String id() {
    final date = this ?? DateTime.now();
    return '${date.year}${date.month}${date.day}${date.hour}${date.minute}${date.second}';
  }

  DateTime startOfDay() {
    final date = this ?? DateTime.now();
    return DateTime.utc(
      date.year,
      date.month,
      date.day,
    );
  }

  DateTime addTwentyFourWorkingHours() {
    final today = this ?? DateTime.now();
    switch (today.weekday) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        return today.add(const Duration(days: 3));
      case 6:
        return today.add(const Duration(days: 2));
      case 7:
        return today.add(const Duration(days: 1));
      default:
        return today.add(const Duration(days: 1));
    }
  }

  String formatISOTime() {
    final date = this;
    if (date != null) {
      return date.toUtc().toIso8601String();
    }
    return '';
  }

  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(
    DateTime? fromDateTime,
    DateTime? toDateTime,
  ) {
    final date = this;
    if (date != null && fromDateTime != null && toDateTime != null) {
      final isBefore = date.isBeforeOrEqualTo(fromDateTime) ?? false;
      final isAfter = date.isAfterOrEqualTo(toDateTime) ?? false;
      return isBefore && isAfter;
    }
    return null;
  }

  List<DateTime> getDaysBetween(DateTime endDate) {
    final startDate = this ?? DateTime.now();
    final days = <DateTime>[];
    final daysCount = endDate.subtract(const Duration(seconds: 1)).difference(startDate).inDays;
    for (var i = 0; i <= daysCount; i++) {
      days.add(DateTime(startDate.year, startDate.month, startDate.day + i));
    }
    days.add(DateTime(endDate.year, endDate.month, endDate.day));
    return days.toSet().toList();
  }

  List<DateTime> getDaysBetweenFilled(DateTime endDate, int filledCount) {
    final startDate = this ?? DateTime.now();
    final days = <DateTime>[];
    final daysCount = endDate.subtract(const Duration(seconds: 1)).difference(startDate).inDays;
    for (var i = 0; i <= daysCount; i++) {
      days.add(DateTime(startDate.year, startDate.month, startDate.day + i));
    }
    days.add(DateTime(endDate.year, endDate.month, endDate.day));

    final _daysList = days.toSet().toList();

    if (_daysList.length > filledCount) {
      return _daysList.sublist(0, filledCount);
    }
    if (_daysList.length == filledCount) {
      return _daysList;
    }

    final _dateList = <DateTime>[];

    final repetition = filledCount / _daysList.length;
    for (var date in _daysList) {
      for (var i = 0; i <= repetition; ++i) {
        _dateList.add(date);
      }
    }
    return _dateList;
  }
}
