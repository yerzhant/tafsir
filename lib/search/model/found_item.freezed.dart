// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'found_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$FoundItemTearOff {
  const _$FoundItemTearOff();

  _FoundItem call(Surah surah, TextItem textItem) {
    return _FoundItem(
      surah,
      textItem,
    );
  }
}

/// @nodoc
const $FoundItem = _$FoundItemTearOff();

/// @nodoc
mixin _$FoundItem {
  Surah get surah => throw _privateConstructorUsedError;
  TextItem get textItem => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FoundItemCopyWith<FoundItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoundItemCopyWith<$Res> {
  factory $FoundItemCopyWith(FoundItem value, $Res Function(FoundItem) then) =
      _$FoundItemCopyWithImpl<$Res>;
  $Res call({Surah surah, TextItem textItem});
}

/// @nodoc
class _$FoundItemCopyWithImpl<$Res> implements $FoundItemCopyWith<$Res> {
  _$FoundItemCopyWithImpl(this._value, this._then);

  final FoundItem _value;
  // ignore: unused_field
  final $Res Function(FoundItem) _then;

  @override
  $Res call({
    Object? surah = freezed,
    Object? textItem = freezed,
  }) {
    return _then(_value.copyWith(
      surah: surah == freezed
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as Surah,
      textItem: textItem == freezed
          ? _value.textItem
          : textItem // ignore: cast_nullable_to_non_nullable
              as TextItem,
    ));
  }
}

/// @nodoc
abstract class _$FoundItemCopyWith<$Res> implements $FoundItemCopyWith<$Res> {
  factory _$FoundItemCopyWith(
          _FoundItem value, $Res Function(_FoundItem) then) =
      __$FoundItemCopyWithImpl<$Res>;
  @override
  $Res call({Surah surah, TextItem textItem});
}

/// @nodoc
class __$FoundItemCopyWithImpl<$Res> extends _$FoundItemCopyWithImpl<$Res>
    implements _$FoundItemCopyWith<$Res> {
  __$FoundItemCopyWithImpl(_FoundItem _value, $Res Function(_FoundItem) _then)
      : super(_value, (v) => _then(v as _FoundItem));

  @override
  _FoundItem get _value => super._value as _FoundItem;

  @override
  $Res call({
    Object? surah = freezed,
    Object? textItem = freezed,
  }) {
    return _then(_FoundItem(
      surah == freezed
          ? _value.surah
          : surah // ignore: cast_nullable_to_non_nullable
              as Surah,
      textItem == freezed
          ? _value.textItem
          : textItem // ignore: cast_nullable_to_non_nullable
              as TextItem,
    ));
  }
}

/// @nodoc

class _$_FoundItem implements _FoundItem {
  _$_FoundItem(this.surah, this.textItem);

  @override
  final Surah surah;
  @override
  final TextItem textItem;

  @override
  String toString() {
    return 'FoundItem(surah: $surah, textItem: $textItem)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FoundItem &&
            (identical(other.surah, surah) ||
                const DeepCollectionEquality().equals(other.surah, surah)) &&
            (identical(other.textItem, textItem) ||
                const DeepCollectionEquality()
                    .equals(other.textItem, textItem)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(surah) ^
      const DeepCollectionEquality().hash(textItem);

  @JsonKey(ignore: true)
  @override
  _$FoundItemCopyWith<_FoundItem> get copyWith =>
      __$FoundItemCopyWithImpl<_FoundItem>(this, _$identity);
}

abstract class _FoundItem implements FoundItem {
  factory _FoundItem(Surah surah, TextItem textItem) = _$_FoundItem;

  @override
  Surah get surah => throw _privateConstructorUsedError;
  @override
  TextItem get textItem => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FoundItemCopyWith<_FoundItem> get copyWith =>
      throw _privateConstructorUsedError;
}
