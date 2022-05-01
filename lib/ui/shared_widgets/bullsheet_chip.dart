import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../../extensions/string_extension.dart';

typedef OnSelected = void Function(bool selected);

enum ChipType { filter, normal }

class BullsheetChip extends StatelessWidget {
  const BullsheetChip({
    required this.chipType,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.onDelete,
    this.icon,
  });

  final String label;
  final ChipType chipType;
  final bool isSelected;
  final OnSelected? onSelected;
  final VoidCallback? onDelete;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (chipType == ChipType.filter) {
      return SizedBox(
        height: 32,
        child: FilterChip(
          avatar: isSelected ? icon : null,
          label: Text(label.capitalize()),
          padding: EdgeInsets.zero,
          backgroundColor: context.colors.background,
          labelStyle: context.text.bodyMedium?.copyWith(
            color: context.colors.onPrimary,
          ),
          side: BorderSide(
            width: 1,
            color: context.colors.primary,
          ),
          onSelected: onSelected,
          selected: isSelected,
          showCheckmark: icon == null,
          selectedColor: context.colors.primary,
          checkmarkColor: context.colors.onPrimary,
        ),
      );
    } else {
      return SizedBox(
        height: 32,
        child: Chip(
          label: Text(label),
          side: BorderSide(
            width: 1,
            color: context.colors.primary,
          ),
          padding: EdgeInsets.zero,
          backgroundColor: context.colors.background,
          labelStyle: context.text.bodyMedium?.copyWith(
            color: context.colors.onPrimary,
          ),
          useDeleteButtonTooltip: isSelected,
          deleteIconColor: context.colors.onPrimary,
          onDeleted: isSelected ? onDelete : null,
          deleteIcon: Icon(
            Icons.close,
            color: context.colors.onPrimary,
          ),
        ),
      );
    }
  }
}
