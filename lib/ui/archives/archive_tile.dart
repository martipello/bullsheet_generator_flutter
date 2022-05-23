import 'package:flutter/material.dart';

import '../../api/models/archive_model.dart';
import '../../extensions/build_context_extension.dart';
import '../shared_widgets/bullsheet_tile.dart';

class ArchiveTile extends StatelessWidget {
  const ArchiveTile({
    required Key key,
    required this.archive,
  }) : super(key: key);

  final ArchiveModel? archive;

  @override
  Widget build(BuildContext context) {
    return BullsheetTile(
      isSelected: false,
      border: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(archive?.color ?? Colors.white.value),
          width: 2,
        ),
      ),
      child: _buildArchiveContent(context),
    );
  }

  Widget _buildArchiveContent(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Title : ${archive?.name}',
          style: context.text.titleMedium,
        ),
        Text(
          'Date : ${archive?.createdDate}',
          style: context.text.bodySmall,
        ),
      ],
    );
  }
}
