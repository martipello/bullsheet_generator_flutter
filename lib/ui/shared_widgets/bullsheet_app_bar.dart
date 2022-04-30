import 'package:flutter/material.dart';


class BullsheetAppBar extends StatelessWidget implements PreferredSizeWidget {
  BullsheetAppBar({
    this.elevation,
    required this.label,
    this.bottom,
    this.leadingIcon,
  }) : preferredSize = Size.fromHeight(
          kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
        );

  final double? elevation;
  final String label;
  final PreferredSizeWidget? bottom;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        label.toUpperCase(),
      ),
      centerTitle: false,
      leading: leadingIcon,
      elevation: elevation,
    );
  }

  @override
  final Size preferredSize;
}
