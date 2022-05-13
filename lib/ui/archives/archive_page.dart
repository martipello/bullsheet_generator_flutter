import 'package:flutter/material.dart';

import '../../extensions/build_context_extension.dart';
import '../shared_widgets/bullsheet_app_bar.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({Key? key}) : super(key: key);

  static const route = 'ArchivePage';

  @override
  Widget build(BuildContext context) {
    //TODO search by name filter by date, color and maybe count
    //TODO should be selectable, draggable like google keep
    //TODO cards need options for edit add and merge
    return Scaffold(
      appBar: BullsheetAppBar(
        label: 'Bullsheet',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.screenWidth * 0.9,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('ARCHIVES'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
