// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'owner_category_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OwnerCategoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> categories, bool isSubCategory)
        loaded,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> categories, bool isSubCategory)?
        loaded,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> categories, bool isSubCategory)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerCategoryStateLoading value) loading,
    required TResult Function(OwnerCategoryStateLoaded value) loaded,
    required TResult Function(OwnerCategoryStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerCategoryStateLoading value)? loading,
    TResult? Function(OwnerCategoryStateLoaded value)? loaded,
    TResult? Function(OwnerCategoryStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerCategoryStateLoading value)? loading,
    TResult Function(OwnerCategoryStateLoaded value)? loaded,
    TResult Function(OwnerCategoryStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerCategoryStateCopyWith<$Res> {
  factory $OwnerCategoryStateCopyWith(
          OwnerCategoryState value, $Res Function(OwnerCategoryState) then) =
      _$OwnerCategoryStateCopyWithImpl<$Res, OwnerCategoryState>;
}

/// @nodoc
class _$OwnerCategoryStateCopyWithImpl<$Res, $Val extends OwnerCategoryState>
    implements $OwnerCategoryStateCopyWith<$Res> {
  _$OwnerCategoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OwnerCategoryStateLoadingImplCopyWith<$Res> {
  factory _$$OwnerCategoryStateLoadingImplCopyWith(
          _$OwnerCategoryStateLoadingImpl value,
          $Res Function(_$OwnerCategoryStateLoadingImpl) then) =
      __$$OwnerCategoryStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerCategoryStateLoadingImplCopyWithImpl<$Res>
    extends _$OwnerCategoryStateCopyWithImpl<$Res,
        _$OwnerCategoryStateLoadingImpl>
    implements _$$OwnerCategoryStateLoadingImplCopyWith<$Res> {
  __$$OwnerCategoryStateLoadingImplCopyWithImpl(
      _$OwnerCategoryStateLoadingImpl _value,
      $Res Function(_$OwnerCategoryStateLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerCategoryStateLoadingImpl implements OwnerCategoryStateLoading {
  const _$OwnerCategoryStateLoadingImpl();

  @override
  String toString() {
    return 'OwnerCategoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerCategoryStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> categories, bool isSubCategory)
        loaded,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> categories, bool isSubCategory)?
        loaded,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> categories, bool isSubCategory)?
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
    required TResult Function(OwnerCategoryStateLoading value) loading,
    required TResult Function(OwnerCategoryStateLoaded value) loaded,
    required TResult Function(OwnerCategoryStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerCategoryStateLoading value)? loading,
    TResult? Function(OwnerCategoryStateLoaded value)? loaded,
    TResult? Function(OwnerCategoryStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerCategoryStateLoading value)? loading,
    TResult Function(OwnerCategoryStateLoaded value)? loaded,
    TResult Function(OwnerCategoryStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OwnerCategoryStateLoading implements OwnerCategoryState {
  const factory OwnerCategoryStateLoading() = _$OwnerCategoryStateLoadingImpl;
}

/// @nodoc
abstract class _$$OwnerCategoryStateLoadedImplCopyWith<$Res> {
  factory _$$OwnerCategoryStateLoadedImplCopyWith(
          _$OwnerCategoryStateLoadedImpl value,
          $Res Function(_$OwnerCategoryStateLoadedImpl) then) =
      __$$OwnerCategoryStateLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CategoryModel> categories, bool isSubCategory});
}

/// @nodoc
class __$$OwnerCategoryStateLoadedImplCopyWithImpl<$Res>
    extends _$OwnerCategoryStateCopyWithImpl<$Res,
        _$OwnerCategoryStateLoadedImpl>
    implements _$$OwnerCategoryStateLoadedImplCopyWith<$Res> {
  __$$OwnerCategoryStateLoadedImplCopyWithImpl(
      _$OwnerCategoryStateLoadedImpl _value,
      $Res Function(_$OwnerCategoryStateLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? isSubCategory = null,
  }) {
    return _then(_$OwnerCategoryStateLoadedImpl(
      null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryModel>,
      null == isSubCategory
          ? _value.isSubCategory
          : isSubCategory // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OwnerCategoryStateLoadedImpl implements OwnerCategoryStateLoaded {
  const _$OwnerCategoryStateLoadedImpl(
      final List<CategoryModel> categories, this.isSubCategory)
      : _categories = categories;

  final List<CategoryModel> _categories;
  @override
  List<CategoryModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final bool isSubCategory;

  @override
  String toString() {
    return 'OwnerCategoryState.loaded(categories: $categories, isSubCategory: $isSubCategory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerCategoryStateLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.isSubCategory, isSubCategory) ||
                other.isSubCategory == isSubCategory));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_categories), isSubCategory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OwnerCategoryStateLoadedImplCopyWith<_$OwnerCategoryStateLoadedImpl>
      get copyWith => __$$OwnerCategoryStateLoadedImplCopyWithImpl<
          _$OwnerCategoryStateLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> categories, bool isSubCategory)
        loaded,
    required TResult Function() error,
  }) {
    return loaded(categories, isSubCategory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> categories, bool isSubCategory)?
        loaded,
    TResult? Function()? error,
  }) {
    return loaded?.call(categories, isSubCategory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> categories, bool isSubCategory)?
        loaded,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(categories, isSubCategory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OwnerCategoryStateLoading value) loading,
    required TResult Function(OwnerCategoryStateLoaded value) loaded,
    required TResult Function(OwnerCategoryStateError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerCategoryStateLoading value)? loading,
    TResult? Function(OwnerCategoryStateLoaded value)? loaded,
    TResult? Function(OwnerCategoryStateError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerCategoryStateLoading value)? loading,
    TResult Function(OwnerCategoryStateLoaded value)? loaded,
    TResult Function(OwnerCategoryStateError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OwnerCategoryStateLoaded implements OwnerCategoryState {
  const factory OwnerCategoryStateLoaded(
          final List<CategoryModel> categories, final bool isSubCategory) =
      _$OwnerCategoryStateLoadedImpl;

  List<CategoryModel> get categories;
  bool get isSubCategory;
  @JsonKey(ignore: true)
  _$$OwnerCategoryStateLoadedImplCopyWith<_$OwnerCategoryStateLoadedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OwnerCategoryStateErrorImplCopyWith<$Res> {
  factory _$$OwnerCategoryStateErrorImplCopyWith(
          _$OwnerCategoryStateErrorImpl value,
          $Res Function(_$OwnerCategoryStateErrorImpl) then) =
      __$$OwnerCategoryStateErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OwnerCategoryStateErrorImplCopyWithImpl<$Res>
    extends _$OwnerCategoryStateCopyWithImpl<$Res,
        _$OwnerCategoryStateErrorImpl>
    implements _$$OwnerCategoryStateErrorImplCopyWith<$Res> {
  __$$OwnerCategoryStateErrorImplCopyWithImpl(
      _$OwnerCategoryStateErrorImpl _value,
      $Res Function(_$OwnerCategoryStateErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OwnerCategoryStateErrorImpl implements OwnerCategoryStateError {
  const _$OwnerCategoryStateErrorImpl();

  @override
  String toString() {
    return 'OwnerCategoryState.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OwnerCategoryStateErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<CategoryModel> categories, bool isSubCategory)
        loaded,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<CategoryModel> categories, bool isSubCategory)?
        loaded,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<CategoryModel> categories, bool isSubCategory)?
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
    required TResult Function(OwnerCategoryStateLoading value) loading,
    required TResult Function(OwnerCategoryStateLoaded value) loaded,
    required TResult Function(OwnerCategoryStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OwnerCategoryStateLoading value)? loading,
    TResult? Function(OwnerCategoryStateLoaded value)? loaded,
    TResult? Function(OwnerCategoryStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OwnerCategoryStateLoading value)? loading,
    TResult Function(OwnerCategoryStateLoaded value)? loaded,
    TResult Function(OwnerCategoryStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OwnerCategoryStateError implements OwnerCategoryState {
  const factory OwnerCategoryStateError() = _$OwnerCategoryStateErrorImpl;
}
