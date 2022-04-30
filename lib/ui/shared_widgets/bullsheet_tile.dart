import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';

class BullsheetTile extends StatelessWidget {
  BullsheetTile({
    Key? key,
    required this.child,
    this.isSelected = false,
    this.border,
  }) : super(key: key);

  final Widget child;
  final bool isSelected;
  final RoundedRectangleBorder? border;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 0 : 2,
      color: isSelected ? context.colors.background : Colors.white,
      shape: border ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}
