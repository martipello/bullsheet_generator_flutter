import 'package:flutter/cupertino.dart';

import '../../api/models/job_source.dart';
import '../../extensions/build_context_extension.dart';

class ChipGroupFormField extends FormField<List<JobSource>> {
  ChipGroupFormField({
    required this.chips,
    FormFieldSetter<List<JobSource>>? onSaved,
    FormFieldValidator<List<JobSource>>? validator,
    List<JobSource>? initialValue,
    AutovalidateMode autoValidateMode = AutovalidateMode.disabled,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autoValidateMode,
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: chips,
                ),
                state.hasError
                    ? Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Text(
                          state.errorText ?? 'Error',
                          style: state.context.text.caption?.copyWith(
                            color: state.context.colors.error,
                          ),
                        ),
                    )
                    : const SizedBox(),
              ],
            );
          },
        );

  final List<Widget> chips;
}
