import 'package:flutter/material.dart';
import 'package:reorderableitemsview/reorderableitemsview.dart';

import '../../api/models/api_response.dart';
import '../../api/models/archive_model.dart';
import '../../dependency_injection_container.dart';
import '../../extensions/iterable_extension.dart';
import '../../view_models/archives_view_model.dart';
import '../dashboard.dart';
import '../shared_widgets/bullsheet_app_bar.dart';
import '../shared_widgets/bullsheet_loading_widget.dart';
import 'archive_page.dart';
import 'archive_tile.dart';

class ArchivesPage extends StatefulWidget {
  static const route = 'ArchivesPage';

  @override
  State<ArchivesPage> createState() => _ArchivesPageState();
}

class _ArchivesPageState extends State<ArchivesPage> {
  final _archivesViewModel = getIt.get<ArchivesViewModel>();

  @override
  void initState() {
    super.initState();
    _archivesViewModel.getArchives();
  }

  @override
  Widget build(BuildContext context) {
    //TODO search by name filter by date, color and maybe count
    //TODO should be selectable, draggable like google keep
    //TODO cards need options for edit add and merge
    return Scaffold(
      appBar: BullsheetAppBar(
        label: 'Bullsheet',
      ),
      body: StreamBuilder<ApiResponse<List<ArchiveModel>>>(
        stream: _archivesViewModel.archivesStream,
        builder: (context, snapshot) {
          final _status = snapshot.data?.status;
          final _archiveList = snapshot.data?.data ?? [];
          if (_status == Status.LOADING) {
            return const Center(
              child: BullsheetLoadingWidget(),
            );
          }
          if (_status == Status.ERROR) {
            return const Center(
              child: Text('That\'s an error'),
            );
          }
          if (_status == Status.COMPLETED && _archiveList.isEmpty) {
            return const Center(
              child: Text('No Results'),
            );
          }

          return ReorderableItemsView(
            crossAxisCount: 4,
            isGrid: true,
            longPressToDrag: true,
            onReorder: (oldIndex, newIndex) {
              _archivesViewModel.removeArchiveModel(
                _archiveList[oldIndex],
              );
              _archivesViewModel.insertArchiveModel(
                _archiveList[oldIndex],
                newIndex,
              );
            },
            feedBackWidgetBuilder: (context, index, child) {
              return Center(child: child);
            },
            staggeredTiles: _archiveList
                .mapIndexed<StaggeredTileExtended>(
                  (e, i) => StaggeredTileExtended.count(
                    2,
                    2,
                  ),
                )
                .toList(),
            children: _archiveList
                .mapIndexed<Widget>(
                  (e, i) => _buildArchiveTextTile(_archiveList, i),
                )
                .toList(),
          );
        },
      ),
    );
  }

  ArchiveTile _buildArchiveTile(
    ArchiveModel _archive,
  ) {
    return ArchiveTile(
      key: ValueKey(
        _archive.hashCode,
      ),
      archive: _archive,
      onTap: () {
        Navigator.of(context).pushNamed(
          ArchivePage.route,
          arguments: ArchivePageArguments(_archive.id),
        );
      },
    );
  }

  Widget _buildArchiveTextTile(
    List<ArchiveModel> _archiveList,
    int i,
  ) {
    return Text(
      _archiveList[i].name ?? '',
      key: ValueKey(
        _archiveList[i].hashCode,
      ),
    );
  }
}
