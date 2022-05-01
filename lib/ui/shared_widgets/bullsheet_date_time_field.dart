import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../dependency_injection_container.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/date_time_extension.dart';

typedef DateCallback = void Function(DateTime);

class BullsheetDateTimeField extends StatefulWidget {
  BullsheetDateTimeField({
    Key? key,
    required this.dateCallback,
    required this.initialDateTime,
    this.style,
    this.textAlign = TextAlign.center,
    this.dateFormat,
    this.showResetIcon = false,
    this.limitStart,
    this.limitEnd,
    this.showTimePicker = true,
    this.isExpanded = true,
  }) : super(key: key);

  final DateCallback dateCallback;
  final DateTime initialDateTime;
  final TextStyle? style;
  final TextAlign? textAlign;
  final DateFormat? dateFormat;
  final bool? showResetIcon;
  final DateTime? limitStart;
  final DateTime? limitEnd;
  final bool? showTimePicker;
  final bool? isExpanded;

  @override
  _BullsheetDateTimeFieldState createState() => _BullsheetDateTimeFieldState();
}

class _BullsheetDateTimeFieldState extends State<BullsheetDateTimeField> {
  final _wordskiiDateTimeFieldViewModel = getIt.get<BullsheetDateTimeFieldViewModel>();

  @override
  void initState() {
    super.initState();
    setDateTime(_clampDateTime(widget.initialDateTime));
  }

  @override
  void dispose() {
    _wordskiiDateTimeFieldViewModel.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BullsheetDateTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialDateTime != widget.initialDateTime) {
      setDateTime(_clampDateTime(widget.initialDateTime));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime?>(
      stream: _wordskiiDateTimeFieldViewModel.initialDate,
      builder: (context, snapshot) {
        final _initialDateTime = _clampDateTime(snapshot.data ?? widget.initialDateTime);
        return GestureDetector(
          onTap: () async {
            if (Platform.isAndroid) {
              await _buildWordskiiAndroidDatePicker(context, _initialDateTime);
            } else {
              await _buildIosDatePicker(context, _initialDateTime);
            }
          },
          child: Material(
            type: MaterialType.transparency,
            child: Row(
              children: [
                _buildDateTextExpandedState(snapshot.data, _initialDateTime),
                if (widget.showResetIcon == true)
                  IconButton(
                      splashRadius: 24,
                      icon: Icon(
                        Icons.close,
                        color: context.colors.onPrimary,
                        size: 20,
                      ),
                      onPressed: _wordskiiDateTimeFieldViewModel.clear)
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _buildWordskiiAndroidDatePicker(
    BuildContext context,
    DateTime _initialDateTime,
  ) async {
    final date = await _buildAndroidDatePicker(
      context,
      _clampDateTime(
        _initialDateTime,
      ),
    );
    if (date != null) {
      if (widget.showTimePicker == true) {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
            _clampDateTime(
              _initialDateTime,
            ),
          ),
        );
        if (time != null) {
          setDateTime(DateTimeField.combine(date, time));
        } else {
          final timeOfDay = TimeOfDay.fromDateTime(_initialDateTime);
          setDateTime(DateTimeField.combine(date, timeOfDay));
        }
      } else {
        setDateTime(date);
      }
    }
  }

  Widget _buildDateTextExpandedState(
    DateTime? dateTime,
    DateTime _initialDateTime,
  ) {
    if (widget.isExpanded == true) {
      return Expanded(
        child: _buildDateText(dateTime, _initialDateTime),
      );
    }
    return _buildDateText(dateTime, _initialDateTime);
  }

  Widget _buildDateText(
    DateTime? dateTime,
    DateTime _initialDateTime,
  ) {
    return Text(
      dateTime != null ? tryFormat(_initialDateTime) : 'Select a date.',
      style: widget.style ?? context.text.bodyMedium,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: 3,
    );
  }

  String tryFormat(DateTime? date) {
    if (date != null) {
      try {
        if (widget.dateFormat != null) {
          return widget.dateFormat!.format(date);
        } else {
          return date.bookingDateTime();
        }
      } catch (e) {
        // print('Error formatting date: $e');
      }
    }
    return '';
  }

  DateTime _clampDateTime(DateTime initialDateTime) {
    if (widget.limitStart != null && widget.limitEnd != null) {
      return initialDateTime.isAfter(widget.limitEnd!)
          ? widget.limitEnd!
          : initialDateTime.isBefore(widget.limitStart!)
              ? widget.limitStart!
              : initialDateTime;
    } else {
      return initialDateTime;
    }
  }

  Future<DateTime?> _buildIosDatePicker(
    BuildContext context,
    DateTime currentValue,
  ) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          color: context.colors.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 200),
                child: CupertinoDatePicker(
                  initialDateTime: currentValue,
                  mode: widget.showTimePicker == true
                      ? CupertinoDatePickerMode.dateAndTime
                      : CupertinoDatePickerMode.date,
                  minimumDate: widget.limitStart ??
                      currentValue.subtract(
                        const Duration(days: 180),
                      ),
                  maximumDate: widget.limitEnd ??
                      DateTime.now().add(
                        const Duration(days: 180),
                      ),
                  onDateTimeChanged: setDateTime,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Ok'),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        );
      },
    );
  }

  Future<DateTime?> _buildAndroidDatePicker(
    BuildContext context,
    DateTime? currentValue,
  ) {
    return showDatePicker(
      context: context,
      firstDate: widget.limitStart ??
          currentValue?.subtract(const Duration(days: 180)) ??
          DateTime.now().subtract(
            const Duration(days: 180),
          ),
      initialDate: currentValue ?? widget.limitStart ?? DateTime.now(),
      lastDate: widget.limitEnd ??
          DateTime.now().add(
            const Duration(days: 180),
          ),
    );
  }

  void setDateTime(DateTime dateTime) {
    _wordskiiDateTimeFieldViewModel.setDateTime(dateTime);
    widget.dateCallback.call(_clampDateTime(dateTime));
  }
}

class BullsheetDateTimeFieldViewModel {
  final initialDate = BehaviorSubject<DateTime?>();

  void setDateTime(DateTime dateTime) {
    initialDate.add(dateTime);
  }

  void clear() {
    initialDate.add(null);
  }

  void dispose() {
    initialDate.close();
  }
}
