import 'package:hive/hive.dart';

import '../api/models/archive_model.dart';
import '../utils/constants.dart';

class ArchiveRepository {
  ArchiveRepository();

  Future<Box<ArchiveModel>?> _openArchiveBox() async {
    return Hive.openBox<ArchiveModel>(
      Constants.jobBoxKey,
    );
  }

  Future<void> saveArchive(
    ArchiveModel archiveModel,
  ) async {
    final box = await _openArchiveBox();
    if (box != null) {
      box.put(archiveModel.id, archiveModel);
    }
  }

  Future<void> deleteArchive(
    ArchiveModel archiveModel,
  ) async {
    final box = await _openArchiveBox();
    if (box != null) {
      box.delete(archiveModel.id);
    }
  }

  Future<int> getArchiveModelCount({
    String? search,
  }) async {
    final box = await _openArchiveBox();
    if (box != null) {
      final _values = box.values.toList();
      final _valuesWithoutNulls = _values
          .whereType<ArchiveModel>()
          .where(
            (archive) =>
                archive.name?.contains(
                  search ?? '',
                ) ??
                true,
          )
          .toList();
      _valuesWithoutNulls.sort(
        (item1, item2) =>
            item1.createdDate?.compareTo(
              item2.createdDate ?? DateTime.now(),
            ) ??
            0,
      );
      return _valuesWithoutNulls.length;
    }
    return Future.value(0);
  }

  Future<List<ArchiveModel>> getArchiveModels({
    String? search,
  }) async {
    final box = await _openArchiveBox();
    if (box != null) {
      final _values = box.values.toList();
      final _valuesWithoutNulls = _values
          .whereType<ArchiveModel>()
          .where(
            (archive) =>
                archive.name?.contains(
                  search ?? '',
                ) ??
                true,
          )
          .toList();
      _valuesWithoutNulls.sort(
        (item1, item2) =>
            item1.createdDate?.compareTo(
              item2.createdDate ?? DateTime.now(),
            ) ??
            0,
      );
      return _valuesWithoutNulls;
    }
    return Future.value(<ArchiveModel>[]);
  }

  Future<ArchiveModel?> getTimesheet(
    String id,
  ) async {
    final box = await _openArchiveBox();
    if (box != null) {
      return Future.value(
        box.get(id),
      );
    }
    return Future.value(null);
  }

  Future<void> dispose() async {
    final box = await _openArchiveBox();
    box?.close();
  }
}
