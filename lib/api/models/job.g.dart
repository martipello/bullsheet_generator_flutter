// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Job> _$jobSerializer = new _$JobSerializer();

class _$JobSerializer implements StructuredSerializer<Job> {
  @override
  final Iterable<Type> types = const [Job, _$Job];
  @override
  final String wireName = 'Job';

  @override
  Iterable<Object?> serialize(Serializers serializers, Job object,
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
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.company;
    if (value != null) {
      result
        ..add('company')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.applicationType;
    if (value != null) {
      result
        ..add('applicationType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dateApplied;
    if (value != null) {
      result
        ..add('dateApplied')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.datePosted;
    if (value != null) {
      result
        ..add('datePosted')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Job deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new JobBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'company':
          result.company = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'applicationType':
          result.applicationType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'dateApplied':
          result.dateApplied = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'datePosted':
          result.datePosted = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Job extends Job {
  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? company;
  @override
  final String? description;
  @override
  final String? location;
  @override
  final String? applicationType;
  @override
  final String? url;
  @override
  final DateTime? dateApplied;
  @override
  final String? datePosted;

  factory _$Job([void Function(JobBuilder)? updates]) =>
      (new JobBuilder()..update(updates)).build();

  _$Job._(
      {this.id,
      this.title,
      this.company,
      this.description,
      this.location,
      this.applicationType,
      this.url,
      this.dateApplied,
      this.datePosted})
      : super._();

  @override
  Job rebuild(void Function(JobBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JobBuilder toBuilder() => new JobBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Job &&
        id == other.id &&
        title == other.title &&
        company == other.company &&
        description == other.description &&
        location == other.location &&
        applicationType == other.applicationType &&
        url == other.url &&
        dateApplied == other.dateApplied &&
        datePosted == other.datePosted;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, id.hashCode), title.hashCode),
                                company.hashCode),
                            description.hashCode),
                        location.hashCode),
                    applicationType.hashCode),
                url.hashCode),
            dateApplied.hashCode),
        datePosted.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Job')
          ..add('id', id)
          ..add('title', title)
          ..add('company', company)
          ..add('description', description)
          ..add('location', location)
          ..add('applicationType', applicationType)
          ..add('url', url)
          ..add('dateApplied', dateApplied)
          ..add('datePosted', datePosted))
        .toString();
  }
}

class JobBuilder implements Builder<Job, JobBuilder> {
  _$Job? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _company;
  String? get company => _$this._company;
  set company(String? company) => _$this._company = company;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _applicationType;
  String? get applicationType => _$this._applicationType;
  set applicationType(String? applicationType) =>
      _$this._applicationType = applicationType;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  DateTime? _dateApplied;
  DateTime? get dateApplied => _$this._dateApplied;
  set dateApplied(DateTime? dateApplied) => _$this._dateApplied = dateApplied;

  String? _datePosted;
  String? get datePosted => _$this._datePosted;
  set datePosted(String? datePosted) => _$this._datePosted = datePosted;

  JobBuilder();

  JobBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _company = $v.company;
      _description = $v.description;
      _location = $v.location;
      _applicationType = $v.applicationType;
      _url = $v.url;
      _dateApplied = $v.dateApplied;
      _datePosted = $v.datePosted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Job other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Job;
  }

  @override
  void update(void Function(JobBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Job build() {
    final _$result = _$v ??
        new _$Job._(
            id: id,
            title: title,
            company: company,
            description: description,
            location: location,
            applicationType: applicationType,
            url: url,
            dateApplied: dateApplied,
            datePosted: datePosted);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobAdapter extends TypeAdapter<Job> {
  @override
  final int typeId = 1;

  @override
  Job read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return (JobBuilder()
          ..id = fields[0] as String?
          ..title = fields[1] as String?
          ..company = fields[2] as String?
          ..description = fields[3] as String?
          ..location = fields[4] as String?
          ..applicationType = fields[5] as String?
          ..url = fields[6] as String?
          ..dateApplied = fields[7] as DateTime?
          ..datePosted = fields[8] as String?)
        .build();
  }

  @override
  void write(BinaryWriter writer, Job obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.company)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.applicationType)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(7)
      ..write(obj.dateApplied)
      ..writeByte(8)
      ..write(obj.datePosted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
