// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ListDetailsState {
  ListDetailsStatus get status => throw _privateConstructorUsedError;
  ShoppingList? get shoppingList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ListDetailsStateCopyWith<ListDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListDetailsStateCopyWith<$Res> {
  factory $ListDetailsStateCopyWith(
          ListDetailsState value, $Res Function(ListDetailsState) then) =
      _$ListDetailsStateCopyWithImpl<$Res, ListDetailsState>;
  @useResult
  $Res call({ListDetailsStatus status, ShoppingList? shoppingList});
}

/// @nodoc
class _$ListDetailsStateCopyWithImpl<$Res, $Val extends ListDetailsState>
    implements $ListDetailsStateCopyWith<$Res> {
  _$ListDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? shoppingList = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ListDetailsStatus,
      shoppingList: freezed == shoppingList
          ? _value.shoppingList
          : shoppingList // ignore: cast_nullable_to_non_nullable
              as ShoppingList?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListDetailsStateImplCopyWith<$Res>
    implements $ListDetailsStateCopyWith<$Res> {
  factory _$$ListDetailsStateImplCopyWith(_$ListDetailsStateImpl value,
          $Res Function(_$ListDetailsStateImpl) then) =
      __$$ListDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ListDetailsStatus status, ShoppingList? shoppingList});
}

/// @nodoc
class __$$ListDetailsStateImplCopyWithImpl<$Res>
    extends _$ListDetailsStateCopyWithImpl<$Res, _$ListDetailsStateImpl>
    implements _$$ListDetailsStateImplCopyWith<$Res> {
  __$$ListDetailsStateImplCopyWithImpl(_$ListDetailsStateImpl _value,
      $Res Function(_$ListDetailsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? shoppingList = freezed,
  }) {
    return _then(_$ListDetailsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ListDetailsStatus,
      shoppingList: freezed == shoppingList
          ? _value.shoppingList
          : shoppingList // ignore: cast_nullable_to_non_nullable
              as ShoppingList?,
    ));
  }
}

/// @nodoc

class _$ListDetailsStateImpl implements _ListDetailsState {
  const _$ListDetailsStateImpl(
      {required this.status, required this.shoppingList});

  @override
  final ListDetailsStatus status;
  @override
  final ShoppingList? shoppingList;

  @override
  String toString() {
    return 'ListDetailsState(status: $status, shoppingList: $shoppingList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListDetailsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.shoppingList, shoppingList) ||
                other.shoppingList == shoppingList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, shoppingList);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListDetailsStateImplCopyWith<_$ListDetailsStateImpl> get copyWith =>
      __$$ListDetailsStateImplCopyWithImpl<_$ListDetailsStateImpl>(
          this, _$identity);
}

abstract class _ListDetailsState implements ListDetailsState {
  const factory _ListDetailsState(
      {required final ListDetailsStatus status,
      required final ShoppingList? shoppingList}) = _$ListDetailsStateImpl;

  @override
  ListDetailsStatus get status;
  @override
  ShoppingList? get shoppingList;
  @override
  @JsonKey(ignore: true)
  _$$ListDetailsStateImplCopyWith<_$ListDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
