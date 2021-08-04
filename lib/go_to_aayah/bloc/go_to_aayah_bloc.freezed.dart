// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'go_to_aayah_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GoToAayahEventTearOff {
  const _$GoToAayahEventTearOff();

  _SlidedTo slidedTo(Offset position, BuildContext context) {
    return _SlidedTo(
      position,
      context,
    );
  }

  _Ended ended() {
    return const _Ended();
  }

  _Goto goto(int number) {
    return _Goto(
      number,
    );
  }
}

/// @nodoc
const $GoToAayahEvent = _$GoToAayahEventTearOff();

/// @nodoc
mixin _$GoToAayahEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Offset position, BuildContext context) slidedTo,
    required TResult Function() ended,
    required TResult Function(int number) goto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Offset position, BuildContext context)? slidedTo,
    TResult Function()? ended,
    TResult Function(int number)? goto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SlidedTo value) slidedTo,
    required TResult Function(_Ended value) ended,
    required TResult Function(_Goto value) goto,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SlidedTo value)? slidedTo,
    TResult Function(_Ended value)? ended,
    TResult Function(_Goto value)? goto,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoToAayahEventCopyWith<$Res> {
  factory $GoToAayahEventCopyWith(
          GoToAayahEvent value, $Res Function(GoToAayahEvent) then) =
      _$GoToAayahEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$GoToAayahEventCopyWithImpl<$Res>
    implements $GoToAayahEventCopyWith<$Res> {
  _$GoToAayahEventCopyWithImpl(this._value, this._then);

  final GoToAayahEvent _value;
  // ignore: unused_field
  final $Res Function(GoToAayahEvent) _then;
}

/// @nodoc
abstract class _$SlidedToCopyWith<$Res> {
  factory _$SlidedToCopyWith(_SlidedTo value, $Res Function(_SlidedTo) then) =
      __$SlidedToCopyWithImpl<$Res>;
  $Res call({Offset position, BuildContext context});
}

/// @nodoc
class __$SlidedToCopyWithImpl<$Res> extends _$GoToAayahEventCopyWithImpl<$Res>
    implements _$SlidedToCopyWith<$Res> {
  __$SlidedToCopyWithImpl(_SlidedTo _value, $Res Function(_SlidedTo) _then)
      : super(_value, (v) => _then(v as _SlidedTo));

  @override
  _SlidedTo get _value => super._value as _SlidedTo;

  @override
  $Res call({
    Object? position = freezed,
    Object? context = freezed,
  }) {
    return _then(_SlidedTo(
      position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      context == freezed
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$_SlidedTo implements _SlidedTo {
  const _$_SlidedTo(this.position, this.context);

  @override
  final Offset position;
  @override
  final BuildContext context;

  @override
  String toString() {
    return 'GoToAayahEvent.slidedTo(position: $position, context: $context)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SlidedTo &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.context, context) ||
                const DeepCollectionEquality().equals(other.context, context)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(context);

  @JsonKey(ignore: true)
  @override
  _$SlidedToCopyWith<_SlidedTo> get copyWith =>
      __$SlidedToCopyWithImpl<_SlidedTo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Offset position, BuildContext context) slidedTo,
    required TResult Function() ended,
    required TResult Function(int number) goto,
  }) {
    return slidedTo(position, context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Offset position, BuildContext context)? slidedTo,
    TResult Function()? ended,
    TResult Function(int number)? goto,
    required TResult orElse(),
  }) {
    if (slidedTo != null) {
      return slidedTo(position, context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SlidedTo value) slidedTo,
    required TResult Function(_Ended value) ended,
    required TResult Function(_Goto value) goto,
  }) {
    return slidedTo(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SlidedTo value)? slidedTo,
    TResult Function(_Ended value)? ended,
    TResult Function(_Goto value)? goto,
    required TResult orElse(),
  }) {
    if (slidedTo != null) {
      return slidedTo(this);
    }
    return orElse();
  }
}

abstract class _SlidedTo implements GoToAayahEvent {
  const factory _SlidedTo(Offset position, BuildContext context) = _$_SlidedTo;

  Offset get position => throw _privateConstructorUsedError;
  BuildContext get context => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$SlidedToCopyWith<_SlidedTo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$EndedCopyWith<$Res> {
  factory _$EndedCopyWith(_Ended value, $Res Function(_Ended) then) =
      __$EndedCopyWithImpl<$Res>;
}

/// @nodoc
class __$EndedCopyWithImpl<$Res> extends _$GoToAayahEventCopyWithImpl<$Res>
    implements _$EndedCopyWith<$Res> {
  __$EndedCopyWithImpl(_Ended _value, $Res Function(_Ended) _then)
      : super(_value, (v) => _then(v as _Ended));

  @override
  _Ended get _value => super._value as _Ended;
}

/// @nodoc

class _$_Ended implements _Ended {
  const _$_Ended();

  @override
  String toString() {
    return 'GoToAayahEvent.ended()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Ended);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Offset position, BuildContext context) slidedTo,
    required TResult Function() ended,
    required TResult Function(int number) goto,
  }) {
    return ended();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Offset position, BuildContext context)? slidedTo,
    TResult Function()? ended,
    TResult Function(int number)? goto,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SlidedTo value) slidedTo,
    required TResult Function(_Ended value) ended,
    required TResult Function(_Goto value) goto,
  }) {
    return ended(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SlidedTo value)? slidedTo,
    TResult Function(_Ended value)? ended,
    TResult Function(_Goto value)? goto,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(this);
    }
    return orElse();
  }
}

abstract class _Ended implements GoToAayahEvent {
  const factory _Ended() = _$_Ended;
}

/// @nodoc
abstract class _$GotoCopyWith<$Res> {
  factory _$GotoCopyWith(_Goto value, $Res Function(_Goto) then) =
      __$GotoCopyWithImpl<$Res>;
  $Res call({int number});
}

/// @nodoc
class __$GotoCopyWithImpl<$Res> extends _$GoToAayahEventCopyWithImpl<$Res>
    implements _$GotoCopyWith<$Res> {
  __$GotoCopyWithImpl(_Goto _value, $Res Function(_Goto) _then)
      : super(_value, (v) => _then(v as _Goto));

  @override
  _Goto get _value => super._value as _Goto;

  @override
  $Res call({
    Object? number = freezed,
  }) {
    return _then(_Goto(
      number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Goto implements _Goto {
  const _$_Goto(this.number);

  @override
  final int number;

  @override
  String toString() {
    return 'GoToAayahEvent.goto(number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Goto &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$GotoCopyWith<_Goto> get copyWith =>
      __$GotoCopyWithImpl<_Goto>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Offset position, BuildContext context) slidedTo,
    required TResult Function() ended,
    required TResult Function(int number) goto,
  }) {
    return goto(number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Offset position, BuildContext context)? slidedTo,
    TResult Function()? ended,
    TResult Function(int number)? goto,
    required TResult orElse(),
  }) {
    if (goto != null) {
      return goto(number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SlidedTo value) slidedTo,
    required TResult Function(_Ended value) ended,
    required TResult Function(_Goto value) goto,
  }) {
    return goto(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SlidedTo value)? slidedTo,
    TResult Function(_Ended value)? ended,
    TResult Function(_Goto value)? goto,
    required TResult orElse(),
  }) {
    if (goto != null) {
      return goto(this);
    }
    return orElse();
  }
}

abstract class _Goto implements GoToAayahEvent {
  const factory _Goto(int number) = _$_Goto;

  int get number => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$GotoCopyWith<_Goto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$GoToAayahStateTearOff {
  const _$GoToAayahStateTearOff();

  _Inactive inactive(int number) {
    return _Inactive(
      number,
    );
  }

  _Active active(double position, int number) {
    return _Active(
      position,
      number,
    );
  }

  _SemiActive semiActive(double position, int number) {
    return _SemiActive(
      position,
      number,
    );
  }

  _GoTo goTo(int number) {
    return _GoTo(
      number,
    );
  }
}

/// @nodoc
const $GoToAayahState = _$GoToAayahStateTearOff();

/// @nodoc
mixin _$GoToAayahState {
  int get number => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int number) inactive,
    required TResult Function(double position, int number) active,
    required TResult Function(double position, int number) semiActive,
    required TResult Function(int number) goTo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int number)? inactive,
    TResult Function(double position, int number)? active,
    TResult Function(double position, int number)? semiActive,
    TResult Function(int number)? goTo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Active value) active,
    required TResult Function(_SemiActive value) semiActive,
    required TResult Function(_GoTo value) goTo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Active value)? active,
    TResult Function(_SemiActive value)? semiActive,
    TResult Function(_GoTo value)? goTo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GoToAayahStateCopyWith<GoToAayahState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoToAayahStateCopyWith<$Res> {
  factory $GoToAayahStateCopyWith(
          GoToAayahState value, $Res Function(GoToAayahState) then) =
      _$GoToAayahStateCopyWithImpl<$Res>;
  $Res call({int number});
}

/// @nodoc
class _$GoToAayahStateCopyWithImpl<$Res>
    implements $GoToAayahStateCopyWith<$Res> {
  _$GoToAayahStateCopyWithImpl(this._value, this._then);

  final GoToAayahState _value;
  // ignore: unused_field
  final $Res Function(GoToAayahState) _then;

  @override
  $Res call({
    Object? number = freezed,
  }) {
    return _then(_value.copyWith(
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$InactiveCopyWith<$Res>
    implements $GoToAayahStateCopyWith<$Res> {
  factory _$InactiveCopyWith(_Inactive value, $Res Function(_Inactive) then) =
      __$InactiveCopyWithImpl<$Res>;
  @override
  $Res call({int number});
}

/// @nodoc
class __$InactiveCopyWithImpl<$Res> extends _$GoToAayahStateCopyWithImpl<$Res>
    implements _$InactiveCopyWith<$Res> {
  __$InactiveCopyWithImpl(_Inactive _value, $Res Function(_Inactive) _then)
      : super(_value, (v) => _then(v as _Inactive));

  @override
  _Inactive get _value => super._value as _Inactive;

  @override
  $Res call({
    Object? number = freezed,
  }) {
    return _then(_Inactive(
      number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Inactive implements _Inactive {
  const _$_Inactive(this.number);

  @override
  final int number;

  @override
  String toString() {
    return 'GoToAayahState.inactive(number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Inactive &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$InactiveCopyWith<_Inactive> get copyWith =>
      __$InactiveCopyWithImpl<_Inactive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int number) inactive,
    required TResult Function(double position, int number) active,
    required TResult Function(double position, int number) semiActive,
    required TResult Function(int number) goTo,
  }) {
    return inactive(number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int number)? inactive,
    TResult Function(double position, int number)? active,
    TResult Function(double position, int number)? semiActive,
    TResult Function(int number)? goTo,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Active value) active,
    required TResult Function(_SemiActive value) semiActive,
    required TResult Function(_GoTo value) goTo,
  }) {
    return inactive(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Active value)? active,
    TResult Function(_SemiActive value)? semiActive,
    TResult Function(_GoTo value)? goTo,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(this);
    }
    return orElse();
  }
}

abstract class _Inactive implements GoToAayahState {
  const factory _Inactive(int number) = _$_Inactive;

  @override
  int get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InactiveCopyWith<_Inactive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ActiveCopyWith<$Res> implements $GoToAayahStateCopyWith<$Res> {
  factory _$ActiveCopyWith(_Active value, $Res Function(_Active) then) =
      __$ActiveCopyWithImpl<$Res>;
  @override
  $Res call({double position, int number});
}

/// @nodoc
class __$ActiveCopyWithImpl<$Res> extends _$GoToAayahStateCopyWithImpl<$Res>
    implements _$ActiveCopyWith<$Res> {
  __$ActiveCopyWithImpl(_Active _value, $Res Function(_Active) _then)
      : super(_value, (v) => _then(v as _Active));

  @override
  _Active get _value => super._value as _Active;

  @override
  $Res call({
    Object? position = freezed,
    Object? number = freezed,
  }) {
    return _then(_Active(
      position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
      number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Active implements _Active {
  const _$_Active(this.position, this.number);

  @override
  final double position;
  @override
  final int number;

  @override
  String toString() {
    return 'GoToAayahState.active(position: $position, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Active &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$ActiveCopyWith<_Active> get copyWith =>
      __$ActiveCopyWithImpl<_Active>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int number) inactive,
    required TResult Function(double position, int number) active,
    required TResult Function(double position, int number) semiActive,
    required TResult Function(int number) goTo,
  }) {
    return active(position, number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int number)? inactive,
    TResult Function(double position, int number)? active,
    TResult Function(double position, int number)? semiActive,
    TResult Function(int number)? goTo,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(position, number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Active value) active,
    required TResult Function(_SemiActive value) semiActive,
    required TResult Function(_GoTo value) goTo,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Active value)? active,
    TResult Function(_SemiActive value)? semiActive,
    TResult Function(_GoTo value)? goTo,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class _Active implements GoToAayahState {
  const factory _Active(double position, int number) = _$_Active;

  double get position => throw _privateConstructorUsedError;
  @override
  int get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ActiveCopyWith<_Active> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SemiActiveCopyWith<$Res>
    implements $GoToAayahStateCopyWith<$Res> {
  factory _$SemiActiveCopyWith(
          _SemiActive value, $Res Function(_SemiActive) then) =
      __$SemiActiveCopyWithImpl<$Res>;
  @override
  $Res call({double position, int number});
}

/// @nodoc
class __$SemiActiveCopyWithImpl<$Res> extends _$GoToAayahStateCopyWithImpl<$Res>
    implements _$SemiActiveCopyWith<$Res> {
  __$SemiActiveCopyWithImpl(
      _SemiActive _value, $Res Function(_SemiActive) _then)
      : super(_value, (v) => _then(v as _SemiActive));

  @override
  _SemiActive get _value => super._value as _SemiActive;

  @override
  $Res call({
    Object? position = freezed,
    Object? number = freezed,
  }) {
    return _then(_SemiActive(
      position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as double,
      number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SemiActive implements _SemiActive {
  const _$_SemiActive(this.position, this.number);

  @override
  final double position;
  @override
  final int number;

  @override
  String toString() {
    return 'GoToAayahState.semiActive(position: $position, number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SemiActive &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$SemiActiveCopyWith<_SemiActive> get copyWith =>
      __$SemiActiveCopyWithImpl<_SemiActive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int number) inactive,
    required TResult Function(double position, int number) active,
    required TResult Function(double position, int number) semiActive,
    required TResult Function(int number) goTo,
  }) {
    return semiActive(position, number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int number)? inactive,
    TResult Function(double position, int number)? active,
    TResult Function(double position, int number)? semiActive,
    TResult Function(int number)? goTo,
    required TResult orElse(),
  }) {
    if (semiActive != null) {
      return semiActive(position, number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Active value) active,
    required TResult Function(_SemiActive value) semiActive,
    required TResult Function(_GoTo value) goTo,
  }) {
    return semiActive(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Active value)? active,
    TResult Function(_SemiActive value)? semiActive,
    TResult Function(_GoTo value)? goTo,
    required TResult orElse(),
  }) {
    if (semiActive != null) {
      return semiActive(this);
    }
    return orElse();
  }
}

abstract class _SemiActive implements GoToAayahState {
  const factory _SemiActive(double position, int number) = _$_SemiActive;

  double get position => throw _privateConstructorUsedError;
  @override
  int get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SemiActiveCopyWith<_SemiActive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$GoToCopyWith<$Res> implements $GoToAayahStateCopyWith<$Res> {
  factory _$GoToCopyWith(_GoTo value, $Res Function(_GoTo) then) =
      __$GoToCopyWithImpl<$Res>;
  @override
  $Res call({int number});
}

/// @nodoc
class __$GoToCopyWithImpl<$Res> extends _$GoToAayahStateCopyWithImpl<$Res>
    implements _$GoToCopyWith<$Res> {
  __$GoToCopyWithImpl(_GoTo _value, $Res Function(_GoTo) _then)
      : super(_value, (v) => _then(v as _GoTo));

  @override
  _GoTo get _value => super._value as _GoTo;

  @override
  $Res call({
    Object? number = freezed,
  }) {
    return _then(_GoTo(
      number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GoTo implements _GoTo {
  const _$_GoTo(this.number);

  @override
  final int number;

  @override
  String toString() {
    return 'GoToAayahState.goTo(number: $number)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GoTo &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$GoToCopyWith<_GoTo> get copyWith =>
      __$GoToCopyWithImpl<_GoTo>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int number) inactive,
    required TResult Function(double position, int number) active,
    required TResult Function(double position, int number) semiActive,
    required TResult Function(int number) goTo,
  }) {
    return goTo(number);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int number)? inactive,
    TResult Function(double position, int number)? active,
    TResult Function(double position, int number)? semiActive,
    TResult Function(int number)? goTo,
    required TResult orElse(),
  }) {
    if (goTo != null) {
      return goTo(number);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Active value) active,
    required TResult Function(_SemiActive value) semiActive,
    required TResult Function(_GoTo value) goTo,
  }) {
    return goTo(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Active value)? active,
    TResult Function(_SemiActive value)? semiActive,
    TResult Function(_GoTo value)? goTo,
    required TResult orElse(),
  }) {
    if (goTo != null) {
      return goTo(this);
    }
    return orElse();
  }
}

abstract class _GoTo implements GoToAayahState {
  const factory _GoTo(int number) = _$_GoTo;

  @override
  int get number => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GoToCopyWith<_GoTo> get copyWith => throw _privateConstructorUsedError;
}
