import 'package:flutter/material.dart';

import 'shared_widgets/bullsheet_app_bar.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BullsheetAppBar(
        label: 'Bullsheet',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16,),
            const Text('BULLSHEET'),
            const SizedBox(height: 16,)

          ],
        ),
      ),
    );
  }
}
