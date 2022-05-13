import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import 'bullsheet_loading_widget.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.onPressed,
    this.fillColor,
    this.isLoading = false,
    this.isFilled = true,
    this.disableShadow = false,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.outlineColor,
    this.textStyle,
    this.elevation,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Color? fillColor;
  final Color? outlineColor;
  final bool isLoading;
  final bool isFilled;
  final bool disableShadow;
  final double? elevation;
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            _getTextStyle(context),
          ),
          elevation: MaterialStateProperty.all(
            onPressed != null && !disableShadow ? elevation ?? 2 : 0,
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 16,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            _getFillColor(context),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: _getOutlineColor(context),
            ),
          ),
          overlayColor: MaterialStateProperty.all(Colors.black12),
        ),
        onPressed: _handleOnPressed(),
        child: Builder(
          builder: (context) {
            if (isLoading) return _buildLoading(context);
            return _buildButtonContent(context);
          },
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    var textStyle = _getTextStyle(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              leadingIcon,
              color: textStyle?.color,
              size: textStyle?.fontSize ?? 14 + 2,
            ),
          ),
        Flexible(
          child: Text(
            label,
            style: textStyle,
          ),
        ),
        if (trailingIcon != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              trailingIcon,
              color: textStyle?.color,
              size: textStyle?.fontSize ?? 14 + 2,
            ),
          ),
      ],
    );
  }

  Color _getFillColor(BuildContext context) {
    if (isFilled && onPressed != null) {
      return fillColor ?? context.colors.secondary;
    } else if (!isFilled && onPressed != null) {
      return context.colors.onSecondary;
    } else if (!isFilled && onPressed == null) {
      return context.colors.onSecondary;
    } else {
      return context.colors.background;
    }
  }

  Color _getOutlineColor(BuildContext context) {
    if (onPressed != null) {
      return outlineColor ?? fillColor ?? context.colors.secondary;
    } else {
      return context.colors.background;
    }
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (isFilled && onPressed != null) {
      return textStyle?.copyWith(color: context.colors.onSecondary) ??
          context.text.bodyMedium?.copyWith(color: context.colors.onSecondary);
    } else if (!isFilled && onPressed != null) {
      return context.text.bodyMedium?.copyWith(color: context.colors.secondary);
    } else if (isFilled && onPressed == null) {
      return context.text.bodyMedium?.copyWith(color: context.colors.onBackground);
    } else {
      return context.text.bodyMedium?.copyWith(color: context.colors.background);
    }
  }

  Color _getLoadingColor(BuildContext context) {
    if (isFilled && onPressed != null) {
      return context.colors.onSecondary;
    } else if (!isFilled && onPressed != null) {
      return context.colors.secondary;
    } else if (isFilled && onPressed == null) {
      return context.colors.onBackground;
    } else {
      return context.colors.background;
    }
  }

  Widget _buildLoading(BuildContext context) {
    return SizedBox(
      height: 16,
      width: 16,
      child: BullsheetLoadingWidget(
        width: 2,
        valueColor: _getLoadingColor(context),
      ),
    );
  }

  VoidCallback? _handleOnPressed() {
    if (!isLoading) {
      return onPressed;
    } else {
      return null;
    }
  }
}
