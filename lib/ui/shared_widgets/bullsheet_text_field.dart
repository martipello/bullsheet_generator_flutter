import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import 'bullsheet_loading_widget.dart';

typedef Validator = String? Function(dynamic value);

class BullsheetTextField extends StatelessWidget {
  const BullsheetTextField({
    Key? key,
    required this.textController,
    required this.labelText,
    this.prefixIcon,
    this.validatorMessage,
    this.maxLines = 1,
    this.validator,
    this.textInputType,
    this.textInputAction,
    this.loading = false,
    this.isDense = true,
    this.isEnabled = true,
  }) : super(key: key);

  final TextEditingController textController;
  final Validator? validator;
  final String labelText;
  final String? validatorMessage;
  final IconData? prefixIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final bool loading;
  final bool isEnabled;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      maxLines: maxLines,
      style: context.text.bodyMedium,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: textInputType,
      decoration: _buildInputDecoration(context),
      onEditingComplete: textInputAction == TextInputAction.next ? () => context.nextEditableTextFocus() : null,
      validator: validator != null
          ? validator
          : validatorMessage != null
              ? _defaultValidator
              : null,
    );
  }

  String? _defaultValidator(value) {
    if (value == null || value.isEmpty) {
      return validatorMessage;
    }
    return null;
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      labelText: labelText,
      labelStyle: context.text.bodyMedium,
      enabled: isEnabled,
      isDense: isDense,
      errorMaxLines: 3,
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 48,
        maxWidth: 48,
      ),
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: context.colors.onBackground,
            )
          : null,
      suffixIcon: loading
          ? const Center(
              child: SizedBox(
                height: 18,
                width: 18,
                child: BullsheetLoadingWidget(
                  width: 2,
                ),
              ),
            )
          : textController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 20,
                    color: context.colors.onBackground,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    textController.clear();
                  },
                )
              : null,
    );
  }
}
