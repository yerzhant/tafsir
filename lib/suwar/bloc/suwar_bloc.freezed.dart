// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'suwar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SuwarEventTearOff {
  const _$SuwarEventTearOff();

  _Load load() {
    return const _Load();
  }
}

/// @nodoc
const $SuwarEvent = _$SuwarEventTearOff();

/// @nodoc
mixin _$SuwarEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuwarEventCopyWith<$Res> {
  factory $SuwarEventCopyWith(
          SuwarEvent value, $Res Function(SuwarEvent) then) =
      _$SuwarEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SuwarEventCopyWithImpl<$Res> implements $SuwarEventCopyWith<$Res> {
  _$SuwarEventCopyWithImpl(this._value, this._then);

  final SuwarEvent _value;
  // ignore: unused_field
  final $Res Function(SuwarEvent) _then;
}

/// @nodoc
abstract class _$LoadCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) then) =
      __$LoadCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadCopyWithImpl<$Res> extends _$SuwarEventCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(_Load _value, $Res Function(_Load) _then)
      : super(_value, (v) => _then(v as _Load));

  @override
  _Load get _value => super._value as _Load;
}

/// @nodoc

class _$_Load implements _Load {
  const _$_Load();

  @override
  String toString() {
    return 'SuwarEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Load);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements SuwarEvent {
  const factory _Load() = _$_Load;
}

/// @nodoc
class _$SuwarStateTearOff {
  const _$SuwarStateTearOff();

  _State call(List<Surah> suwar) {
    return _State(
      suwar,
    );
  }

  _InProgress inProgress() {
    return const _InProgress();
  }

  _Error error(Rejection rejection) {
    return _Error(
      rejection,
    );
  }
}

/// @nodoc
const $SuwarState = _$SuwarStateTearOff();

/// @nodoc
mixin _$SuwarState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Surah> suwar) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Surah> suwar)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuwarStateCopyWith<$Res> {
  factory $SuwarStateCopyWith(
          SuwarState value, $Res Function(SuwarState) then) =
      _$SuwarStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SuwarStateCopyWithImpl<$Res> implements $SuwarStateCopyWith<$Res> {
  _$SuwarStateCopyWithImpl(this._value, this._then);

  final SuwarState _value;
  // ignore: unused_field
  final $Res Function(SuwarState) _then;
}

/// @nodoc
abstract class _$StateCopyWith<$Res> {
  factory _$StateCopyWith(_State value, $Res Function(_State) then) =
      __$StateCopyWithImpl<$Res>;
  $Res call({List<Surah> suwar});
}

/// @nodoc
class __$StateCopyWithImpl<$Res> extends _$SuwarStateCopyWithImpl<$Res>
    implements _$StateCopyWith<$Res> {
  __$StateCopyWithImpl(_State _value, $Res Function(_State) _then)
      : super(_value, (v) => _then(v as _State));

  @override
  _State get _value => super._value as _State;

  @override
  $Res call({
    Object? suwar = freezed,
  }) {
    return _then(_State(
      suwar == freezed
          ? _value.suwar
          : suwar // ignore: cast_nullable_to_non_nullable
              as List<Surah>,
    ));
  }
}

/// @nodoc

class _$_State implements _State {
  const _$_State(this.suwar);

  @override
  final List<Surah> suwar;

  @override
  String toString() {
    return 'SuwarState(suwar: $suwar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _State &&
            (identical(other.suwar, suwar) ||
                const DeepCollectionEquality().equals(other.suwar, suwar)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(suwar);

  @JsonKey(ignore: true)
  @override
  _$StateCopyWith<_State> get copyWith =>
      __$StateCopyWithImpl<_State>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Surah> suwar) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return $default(suwar);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Surah> suwar)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(suwar);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _State implements SuwarState {
  const factory _State(List<Surah> suwar) = _$_State;

  List<Surah> get suwar => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$StateCopyWith<_State> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$InProgressCopyWith<$Res> {
  factory _$InProgressCopyWith(
          _InProgress value, $Res Function(_InProgress) then) =
      __$InProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$InProgressCopyWithImpl<$Res> extends _$SuwarStateCopyWithImpl<$Res>
    implements _$InProgressCopyWith<$Res> {
  __$InProgressCopyWithImpl(
      _InProgress _value, $Res Function(_InProgress) _then)
      : super(_value, (v) => _then(v as _InProgress));

  @override
  _InProgress get _value => super._value as _InProgress;
}

/// @nodoc

class _$_InProgress implements _InProgress {
  const _$_InProgress();

  @override
  String toString() {
    return 'SuwarState.inProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _InProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Surah> suwar) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Surah> suwar)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements SuwarState {
  const factory _InProgress() = _$_InProgress;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({Rejection rejection});

  $RejectionCopyWith<$Res> get rejection;
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$SuwarStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? rejection = freezed,
  }) {
    return _then(_Error(
      rejection == freezed
          ? _value.rejection
          : rejection // ignore: cast_nullable_to_non_nullable
              as Rejection,
    ));
  }

  @override
  $RejectionCopyWith<$Res> get rejection {
    return $RejectionCopyWith<$Res>(_value.rejection, (value) {
      return _then(_value.copyWith(rejection: value));
    });
  }
}

/// @nodoc

class _$_Error implements _Error {
  const _$_Error(this.rejection);

  @override
  final Rejection rejection;

  @override
  String toString() {
    return 'SuwarState.error(rejection: $rejection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error &&
            (identical(other.rejection, rejection) ||
                const DeepCollectionEquality()
                    .equals(other.rejection, rejection)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(rejection);

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Surah> suwar) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return error(rejection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Surah> suwar)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(rejection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SuwarState {
  const factory _Error(Rejection rejection) = _$_Error;

  Rejection get rejection => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}
