import 'package:flutter/material.dart';

import '../../api/models/archive_model.dart';
import '../../extensions/build_context_extension.dart';
import '../../extensions/date_time_extension.dart';
import '../shared_widgets/bullsheet_tile.dart';

class ArchiveTile extends StatelessWidget {
  const ArchiveTile({
    required Key key,
    required this.archive,
    this.onTap,
  }) : super(key: key);

  final ArchiveModel? archive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: BullsheetTile(
          isSelected: false,
          border: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(archive?.color ?? Colors.white.value),
              width: 2,
            ),
          ),
          child: _buildArchiveContent(context),
        ),
      ),
    );
  }

  Widget _buildArchiveContent(
    BuildContext context,
  ) {
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Title : ${archive?.name}',
          style: context.text.titleMedium,
        ),
        Text(
          'Date : ${now.dateAndTimeFormat().format(archive?.createdDate ?? now)}',
          style: context.text.bodySmall,
        ),
      ],
    );
  }
}
