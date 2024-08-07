// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_card_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomerCardState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)
        loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomerCardStateLoading value) loading,
    required TResult Function(CustomerCardStateLoaded value) loaded,
    required TResult Function(CustomerCardStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerCardStateLoading value)? loading,
    TResult? Function(CustomerCardStateLoaded value)? loaded,
    TResult? Function(CustomerCardStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerCardStateLoading value)? loading,
    TResult Function(CustomerCardStateLoaded value)? loaded,
    TResult Function(CustomerCardStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCardStateCopyWith<$Res> {
  factory $CustomerCardStateCopyWith(
          CustomerCardState value, $Res Function(CustomerCardState) then) =
      _$CustomerCardStateCopyWithImpl<$Res, CustomerCardState>;
}

/// @nodoc
class _$CustomerCardStateCopyWithImpl<$Res, $Val extends CustomerCardState>
    implements $CustomerCardStateCopyWith<$Res> {
  _$CustomerCardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CustomerCardStateLoadingImplCopyWith<$Res> {
  factory _$$CustomerCardStateLoadingImplCopyWith(
          _$CustomerCardStateLoadingImpl value,
          $Res Function(_$CustomerCardStateLoadingImpl) then) =
      __$$CustomerCardStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CustomerCardStateLoadingImplCopyWithImpl<$Res>
    extends _$CustomerCardStateCopyWithImpl<$Res,
        _$CustomerCardStateLoadingImpl>
    implements _$$CustomerCardStateLoadingImplCopyWith<$Res> {
  __$$CustomerCardStateLoadingImplCopyWithImpl(
      _$CustomerCardStateLoadingImpl _value,
      $Res Function(_$CustomerCardStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CustomerCardStateLoadingImpl implements CustomerCardStateLoading {
  const _$CustomerCardStateLoadingImpl();

  @override
  String toString() {
    return 'CustomerCardState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerCardStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)
        loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomerCardStateLoading value) loading,
    required TResult Function(CustomerCardStateLoaded value) loaded,
    required TResult Function(CustomerCardStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerCardStateLoading value)? loading,
    TResult? Function(CustomerCardStateLoaded value)? loaded,
    TResult? Function(CustomerCardStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerCardStateLoading value)? loading,
    TResult Function(CustomerCardStateLoaded value)? loaded,
    TResult Function(CustomerCardStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CustomerCardStateLoading implements CustomerCardState {
  const factory CustomerCardStateLoading() = _$CustomerCardStateLoadingImpl;
}

/// @nodoc
abstract class _$$CustomerCardStateLoadedImplCopyWith<$Res> {
  factory _$$CustomerCardStateLoadedImplCopyWith(
          _$CustomerCardStateLoadedImpl value,
          $Res Function(_$CustomerCardStateLoadedImpl) then) =
      __$$CustomerCardStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<ContainerCardModel> cards,
      List<ContainerTransactionModel>? transactions});
}

/// @nodoc
class __$$CustomerCardStateLoadedImplCopyWithImpl<$Res>
    extends _$CustomerCardStateCopyWithImpl<$Res, _$CustomerCardStateLoadedImpl>
    implements _$$CustomerCardStateLoadedImplCopyWith<$Res> {
  __$$CustomerCardStateLoadedImplCopyWithImpl(
      _$CustomerCardStateLoadedImpl _value,
      $Res Function(_$CustomerCardStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
    Object? transactions = freezed,
  }) {
    return _then(_$CustomerCardStateLoadedImpl(
      null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<ContainerCardModel>,
      freezed == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<ContainerTransactionModel>?,
    ));
  }
}

/// @nodoc

class _$CustomerCardStateLoadedImpl implements CustomerCardStateLoaded {
  const _$CustomerCardStateLoadedImpl(final List<ContainerCardModel> cards,
      final List<ContainerTransactionModel>? transactions)
      : _cards = cards,
        _transactions = transactions;

  final List<ContainerCardModel> _cards;
  @override
  List<ContainerCardModel> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  final List<ContainerTransactionModel>? _transactions;
  @override
  List<ContainerTransactionModel>? get transactions {
    final value = _transactions;
    if (value == null) return null;
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CustomerCardState.loaded(cards: $cards, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerCardStateLoadedImpl &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_cards),
      const DeepCollectionEquality().hash(_transactions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerCardStateLoadedImplCopyWith<_$CustomerCardStateLoadedImpl>
      get copyWith => __$$CustomerCardStateLoadedImplCopyWithImpl<
          _$CustomerCardStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)
        loaded,
    required TResult Function() error,
  }) {
    return loaded(cards, transactions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(cards, transactions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cards, transactions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomerCardStateLoading value) loading,
    required TResult Function(CustomerCardStateLoaded value) loaded,
    required TResult Function(CustomerCardStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerCardStateLoading value)? loading,
    TResult? Function(CustomerCardStateLoaded value)? loaded,
    TResult? Function(CustomerCardStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerCardStateLoading value)? loading,
    TResult Function(CustomerCardStateLoaded value)? loaded,
    TResult Function(CustomerCardStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CustomerCardStateLoaded implements CustomerCardState {
  const factory CustomerCardStateLoaded(final List<ContainerCardModel> cards,
          final List<ContainerTransactionModel>? transactions) =
      _$CustomerCardStateLoadedImpl;

  List<ContainerCardModel> get cards;
  List<ContainerTransactionModel>? get transactions;
  @JsonKey(ignore: true)
  _$$CustomerCardStateLoadedImplCopyWith<_$CustomerCardStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomerCardStateErrorImplCopyWith<$Res> {
  factory _$$CustomerCardStateErrorImplCopyWith(
          _$CustomerCardStateErrorImpl value,
          $Res Function(_$CustomerCardStateErrorImpl) then) =
      __$$CustomerCardStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CustomerCardStateErrorImplCopyWithImpl<$Res>
    extends _$CustomerCardStateCopyWithImpl<$Res, _$CustomerCardStateErrorImpl>
    implements _$$CustomerCardStateErrorImplCopyWith<$Res> {
  __$$CustomerCardStateErrorImplCopyWithImpl(
      _$CustomerCardStateErrorImpl _value,
      $Res Function(_$CustomerCardStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CustomerCardStateErrorImpl implements CustomerCardStateError {
  const _$CustomerCardStateErrorImpl();

  @override
  String toString() {
    return 'CustomerCardState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerCardStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)
        loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ContainerCardModel> cards,
            List<ContainerTransactionModel>? transactions)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CustomerCardStateLoading value) loading,
    required TResult Function(CustomerCardStateLoaded value) loaded,
    required TResult Function(CustomerCardStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CustomerCardStateLoading value)? loading,
    TResult? Function(CustomerCardStateLoaded value)? loaded,
    TResult? Function(CustomerCardStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CustomerCardStateLoading value)? loading,
    TResult Function(CustomerCardStateLoaded value)? loaded,
    TResult Function(CustomerCardStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CustomerCardStateError implements CustomerCardState {
  const factory CustomerCardStateError() = _$CustomerCardStateErrorImpl;
}
