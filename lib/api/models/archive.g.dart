// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Archive> _$archiveSerializer = new _$ArchiveSerializer();

class _$ArchiveSerializer implements StructuredSerializer<Archive> {
  @override
  final Iterable<Type> types = const [Archive, _$Archive];
  @override
  final String wireName = 'Archive';

  @override
  Iterable<Object?> serialize(Serializers serializers, Archive object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdDate;
    if (value != null) {
      result
        ..add('createdDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.updatedDate;
    if (value != null) {
      result
        ..add('updatedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.jobList;
    if (value != null) {
      result
        ..add('jobList')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Job)])));
    }
    return result;
  }

  @override
  Archive deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ArchiveBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdDate':
          result.createdDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'updatedDate':
          result.updatedDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'jobList':
          result.jobList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Job)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$Archive extends Archive {
  @override
  final String? id;
  @override
  final DateTime? createdDate;
  @override
  final DateTime? updatedDate;
  @override
  final String? name;
  @override
  final int? color;
  @override
  final BuiltList<Job>? jobList;

  factory _$Archive([void Function(ArchiveBuilder)? updates]) =>
      (new ArchiveBuilder()..update(updates)).build();

  _$Archive._(
      {this.id,
      this.createdDate,
      this.updatedDate,
      this.name,
      this.color,
      this.jobList})
      : super._();

  @override
  Archive rebuild(void Function(ArchiveBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArchiveBuilder toBuilder() => new ArchiveBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Archive &&
        id == other.id &&
        createdDate == other.createdDate &&
        updatedDate == other.updatedDate &&
        name == other.name &&
        color == other.color &&
        jobList == other.jobList;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, id.hashCode), createdDate.hashCode),
                    updatedDate.hashCode),
                name.hashCode),
            color.hashCode),
        jobList.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Archive')
          ..add('id', id)
          ..add('createdDate', createdDate)
          ..add('updatedDate', updatedDate)
          ..add('name', name)
          ..add('color', color)
          ..add('jobList', jobList))
        .toString();
  }
}

class ArchiveBuilder implements Builder<Archive, ArchiveBuilder> {
  _$Archive? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  DateTime? _createdDate;
  DateTime? get createdDate => _$this._createdDate;
  set createdDate(DateTime? createdDate) => _$this._createdDate = createdDate;

  DateTime? _updatedDate;
  DateTime? get updatedDate => _$this._updatedDate;
  set updatedDate(DateTime? updatedDate) => _$this._updatedDate = updatedDate;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _color;
  int? get color => _$this._color;
  set color(int? color) => _$this._color = color;

  ListBuilder<Job>? _jobList;
  ListBuilder<Job> get jobList => _$this._jobList ??= new ListBuilder<Job>();
  set jobList(ListBuilder<Job>? jobList) => _$this._jobList = jobList;

  ArchiveBuilder();

  ArchiveBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _createdDate = $v.createdDate;
      _updatedDate = $v.updatedDate;
      _name = $v.name;
      _color = $v.color;
      _jobList = $v.jobList?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Archive other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Archive;
  }

  @override
  void update(void Function(ArchiveBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Archive build() {
    _$Archive _$result;
    try {
      _$result = _$v ??
          new _$Archive._(
              id: id,
              createdDate: createdDate,
              updatedDate: updatedDate,
              name: name,
              color: color,
              jobList: _jobList?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'jobList';
        _jobList?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Archive', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArchiveAdapter extends TypeAdapter<Archive> {
  @override
  final int typeId = 0;

  @override
  Archive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (ArchiveBuilder()
          ..id = fields[0] as String?
          ..createdDate = fields[1] as DateTime?
          ..updatedDate = fields[2] as DateTime?
          ..name = fields[3] as String?
          ..color = fields[4] as int?
          ..jobList = fields[5] == null
              ? null
              : ListBuilder<Job>(fields[5] as Iterable))
        .build();
  }

  @override
  void write(BinaryWriter writer, Archive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.updatedDate)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.jobList?.toList());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArchiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
