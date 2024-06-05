// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PortalState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserModel? user) loaded,
    required TResult Function(String errorMessage) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserModel? user)? loaded,
    TResult? Function(String errorMessage)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserModel? user)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PortalInitial value) initial,
    required TResult Function(PortalLoading value) loading,
    required TResult Function(PortalLoaded value) loaded,
    required TResult Function(PortalError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PortalInitial value)? initial,
    TResult? Function(PortalLoading value)? loading,
    TResult? Function(PortalLoaded value)? loaded,
    TResult? Function(PortalError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PortalInitial value)? initial,
    TResult Function(PortalLoading value)? loading,
    TResult Function(PortalLoaded value)? loaded,
    TResult Function(PortalError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PortalStateCopyWith<$Res> {
  factory $PortalStateCopyWith(
          PortalState value, $Res Function(PortalState) then) =
      _$PortalStateCopyWithImpl<$Res, PortalState>;
}

/// @nodoc
class _$PortalStateCopyWithImpl<$Res, $Val extends PortalState>
    implements $PortalStateCopyWith<$Res> {
  _$PortalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PortalInitialCopyWith<$Res> {
  factory _$$PortalInitialCopyWith(
          _$PortalInitial value, $Res Function(_$PortalInitial) then) =
      __$$PortalInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PortalInitialCopyWithImpl<$Res>
    extends _$PortalStateCopyWithImpl<$Res, _$PortalInitial>
    implements _$$PortalInitialCopyWith<$Res> {
  __$$PortalInitialCopyWithImpl(
      _$PortalInitial _value, $Res Function(_$PortalInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PortalInitial implements PortalInitial {
  const _$PortalInitial();

  @override
  String toString() {
    return 'PortalState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PortalInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserModel? user) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserModel? user)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserModel? user)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PortalInitial value) initial,
    required TResult Function(PortalLoading value) loading,
    required TResult Function(PortalLoaded value) loaded,
    required TResult Function(PortalError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PortalInitial value)? initial,
    TResult? Function(PortalLoading value)? loading,
    TResult? Function(PortalLoaded value)? loaded,
    TResult? Function(PortalError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PortalInitial value)? initial,
    TResult Function(PortalLoading value)? loading,
    TResult Function(PortalLoaded value)? loaded,
    TResult Function(PortalError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PortalInitial implements PortalState {
  const factory PortalInitial() = _$PortalInitial;
}

/// @nodoc
abstract class _$$PortalLoadingCopyWith<$Res> {
  factory _$$PortalLoadingCopyWith(
          _$PortalLoading value, $Res Function(_$PortalLoading) then) =
      __$$PortalLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PortalLoadingCopyWithImpl<$Res>
    extends _$PortalStateCopyWithImpl<$Res, _$PortalLoading>
    implements _$$PortalLoadingCopyWith<$Res> {
  __$$PortalLoadingCopyWithImpl(
      _$PortalLoading _value, $Res Function(_$PortalLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PortalLoading implements PortalLoading {
  const _$PortalLoading();

  @override
  String toString() {
    return 'PortalState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PortalLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserModel? user) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserModel? user)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserModel? user)? loaded,
    TResult Function(String errorMessage)? error,
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
    required TResult Function(PortalInitial value) initial,
    required TResult Function(PortalLoading value) loading,
    required TResult Function(PortalLoaded value) loaded,
    required TResult Function(PortalError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PortalInitial value)? initial,
    TResult? Function(PortalLoading value)? loading,
    TResult? Function(PortalLoaded value)? loaded,
    TResult? Function(PortalError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PortalInitial value)? initial,
    TResult Function(PortalLoading value)? loading,
    TResult Function(PortalLoaded value)? loaded,
    TResult Function(PortalError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PortalLoading implements PortalState {
  const factory PortalLoading() = _$PortalLoading;
}

/// @nodoc
abstract class _$$PortalLoadedCopyWith<$Res> {
  factory _$$PortalLoadedCopyWith(
          _$PortalLoaded value, $Res Function(_$PortalLoaded) then) =
      __$$PortalLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({UserModel? user});
}

/// @nodoc
class __$$PortalLoadedCopyWithImpl<$Res>
    extends _$PortalStateCopyWithImpl<$Res, _$PortalLoaded>
    implements _$$PortalLoadedCopyWith<$Res> {
  __$$PortalLoadedCopyWithImpl(
      _$PortalLoaded _value, $Res Function(_$PortalLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = freezed,
  }) {
    return _then(_$PortalLoaded(
      freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc

class _$PortalLoaded implements PortalLoaded {
  const _$PortalLoaded(this.user);

  @override
  final UserModel? user;

  @override
  String toString() {
    return 'PortalState.loaded(user: $user)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortalLoaded &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PortalLoadedCopyWith<_$PortalLoaded> get copyWith =>
      __$$PortalLoadedCopyWithImpl<_$PortalLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserModel? user) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loaded(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserModel? user)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return loaded?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserModel? user)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PortalInitial value) initial,
    required TResult Function(PortalLoading value) loading,
    required TResult Function(PortalLoaded value) loaded,
    required TResult Function(PortalError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PortalInitial value)? initial,
    TResult? Function(PortalLoading value)? loading,
    TResult? Function(PortalLoaded value)? loaded,
    TResult? Function(PortalError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PortalInitial value)? initial,
    TResult Function(PortalLoading value)? loading,
    TResult Function(PortalLoaded value)? loaded,
    TResult Function(PortalError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PortalLoaded implements PortalState {
  const factory PortalLoaded(final UserModel? user) = _$PortalLoaded;

  UserModel? get user;
  @JsonKey(ignore: true)
  _$$PortalLoadedCopyWith<_$PortalLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PortalErrorCopyWith<$Res> {
  factory _$$PortalErrorCopyWith(
          _$PortalError value, $Res Function(_$PortalError) then) =
      __$$PortalErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$PortalErrorCopyWithImpl<$Res>
    extends _$PortalStateCopyWithImpl<$Res, _$PortalError>
    implements _$$PortalErrorCopyWith<$Res> {
  __$$PortalErrorCopyWithImpl(
      _$PortalError _value, $Res Function(_$PortalError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$PortalError(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PortalError implements PortalError {
  const _$PortalError(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'PortalState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PortalError &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PortalErrorCopyWith<_$PortalError> get copyWith =>
      __$$PortalErrorCopyWithImpl<_$PortalError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(UserModel? user) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(UserModel? user)? loaded,
    TResult? Function(String errorMessage)? error,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(UserModel? user)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PortalInitial value) initial,
    required TResult Function(PortalLoading value) loading,
    required TResult Function(PortalLoaded value) loaded,
    required TResult Function(PortalError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PortalInitial value)? initial,
    TResult? Function(PortalLoading value)? loading,
    TResult? Function(PortalLoaded value)? loaded,
    TResult? Function(PortalError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PortalInitial value)? initial,
    TResult Function(PortalLoading value)? loading,
    TResult Function(PortalLoaded value)? loaded,
    TResult Function(PortalError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PortalError implements PortalState {
  const factory PortalError(final String errorMessage) = _$PortalError;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$PortalErrorCopyWith<_$PortalError> get copyWith =>
      throw _privateConstructorUsedError;
}
