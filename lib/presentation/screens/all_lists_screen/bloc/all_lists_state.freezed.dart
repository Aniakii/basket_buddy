// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_lists_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllListsState {
  AllListsStatus get status => throw _privateConstructorUsedError;
  List<ShoppingList> get allLists => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AllListsStateCopyWith<AllListsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllListsStateCopyWith<$Res> {
  factory $AllListsStateCopyWith(
          AllListsState value, $Res Function(AllListsState) then) =
      _$AllListsStateCopyWithImpl<$Res, AllListsState>;
  @useResult
  $Res call({AllListsStatus status, List<ShoppingList> allLists});
}

/// @nodoc
class _$AllListsStateCopyWithImpl<$Res, $Val extends AllListsState>
    implements $AllListsStateCopyWith<$Res> {
  _$AllListsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? allLists = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AllListsStatus,
      allLists: null == allLists
          ? _value.allLists
          : allLists // ignore: cast_nullable_to_non_nullable
              as List<ShoppingList>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllListsStateImplCopyWith<$Res>
    implements $AllListsStateCopyWith<$Res> {
  factory _$$AllListsStateImplCopyWith(
          _$AllListsStateImpl value, $Res Function(_$AllListsStateImpl) then) =
      __$$AllListsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AllListsStatus status, List<ShoppingList> allLists});
}

/// @nodoc
class __$$AllListsStateImplCopyWithImpl<$Res>
    extends _$AllListsStateCopyWithImpl<$Res, _$AllListsStateImpl>
    implements _$$AllListsStateImplCopyWith<$Res> {
  __$$AllListsStateImplCopyWithImpl(
      _$AllListsStateImpl _value, $Res Function(_$AllListsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? allLists = null,
  }) {
    return _then(_$AllListsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AllListsStatus,
      allLists: null == allLists
          ? _value._allLists
          : allLists // ignore: cast_nullable_to_non_nullable
              as List<ShoppingList>,
    ));
  }
}

/// @nodoc

class _$AllListsStateImpl implements _AllListsState {
  const _$AllListsStateImpl(
      {required this.status, required final List<ShoppingList> allLists})
      : _allLists = allLists;

  @override
  final AllListsStatus status;
  final List<ShoppingList> _allLists;
  @override
  List<ShoppingList> get allLists {
    if (_allLists is EqualUnmodifiableListView) return _allLists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allLists);
  }

  @override
  String toString() {
    return 'AllListsState(status: $status, allLists: $allLists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllListsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._allLists, _allLists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_allLists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllListsStateImplCopyWith<_$AllListsStateImpl> get copyWith =>
      __$$AllListsStateImplCopyWithImpl<_$AllListsStateImpl>(this, _$identity);
}

abstract class _AllListsState implements AllListsState {
  const factory _AllListsState(
      {required final AllListsStatus status,
      required final List<ShoppingList> allLists}) = _$AllListsStateImpl;

  @override
  AllListsStatus get status;
  @override
  List<ShoppingList> get allLists;
  @override
  @JsonKey(ignore: true)
  _$$AllListsStateImplCopyWith<_$AllListsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
