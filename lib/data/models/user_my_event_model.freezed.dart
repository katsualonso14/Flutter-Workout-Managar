// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_my_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserMyEventModel {
  @TimestampConverter()
  Timestamp get eventDate => throw _privateConstructorUsedError;
  String get eventId => throw _privateConstructorUsedError;

  /// Create a copy of UserMyEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserMyEventModelCopyWith<UserMyEventModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMyEventModelCopyWith<$Res> {
  factory $UserMyEventModelCopyWith(
          UserMyEventModel value, $Res Function(UserMyEventModel) then) =
      _$UserMyEventModelCopyWithImpl<$Res, UserMyEventModel>;
  @useResult
  $Res call({@TimestampConverter() Timestamp eventDate, String eventId});
}

/// @nodoc
class _$UserMyEventModelCopyWithImpl<$Res, $Val extends UserMyEventModel>
    implements $UserMyEventModelCopyWith<$Res> {
  _$UserMyEventModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserMyEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventDate = null,
    Object? eventId = null,
  }) {
    return _then(_value.copyWith(
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMyEventModelImplCopyWith<$Res>
    implements $UserMyEventModelCopyWith<$Res> {
  factory _$$UserMyEventModelImplCopyWith(_$UserMyEventModelImpl value,
          $Res Function(_$UserMyEventModelImpl) then) =
      __$$UserMyEventModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@TimestampConverter() Timestamp eventDate, String eventId});
}

/// @nodoc
class __$$UserMyEventModelImplCopyWithImpl<$Res>
    extends _$UserMyEventModelCopyWithImpl<$Res, _$UserMyEventModelImpl>
    implements _$$UserMyEventModelImplCopyWith<$Res> {
  __$$UserMyEventModelImplCopyWithImpl(_$UserMyEventModelImpl _value,
      $Res Function(_$UserMyEventModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserMyEventModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventDate = null,
    Object? eventId = null,
  }) {
    return _then(_$UserMyEventModelImpl(
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserMyEventModelImpl implements _UserMyEventModel {
  const _$UserMyEventModelImpl(
      {@TimestampConverter() required this.eventDate, required this.eventId});

  @override
  @TimestampConverter()
  final Timestamp eventDate;
  @override
  final String eventId;

  @override
  String toString() {
    return 'UserMyEventModel(eventDate: $eventDate, eventId: $eventId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMyEventModelImpl &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.eventId, eventId) || other.eventId == eventId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, eventDate, eventId);

  /// Create a copy of UserMyEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMyEventModelImplCopyWith<_$UserMyEventModelImpl> get copyWith =>
      __$$UserMyEventModelImplCopyWithImpl<_$UserMyEventModelImpl>(
          this, _$identity);
}

abstract class _UserMyEventModel implements UserMyEventModel {
  const factory _UserMyEventModel(
      {@TimestampConverter() required final Timestamp eventDate,
      required final String eventId}) = _$UserMyEventModelImpl;

  @override
  @TimestampConverter()
  Timestamp get eventDate;
  @override
  String get eventId;

  /// Create a copy of UserMyEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserMyEventModelImplCopyWith<_$UserMyEventModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
