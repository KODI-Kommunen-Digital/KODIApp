import 'package:freezed_annotation/freezed_annotation.dart';

part 'trolley_maker_signin_state.freezed.dart';

@freezed
class TrolleyMakerSigninState with _$TrolleyMakerSigninState {
  const factory TrolleyMakerSigninState.initial() = Initial;
  const factory TrolleyMakerSigninState.loading() = Loading;
  const factory TrolleyMakerSigninState.success() = Success;
  const factory TrolleyMakerSigninState.error(String message) = Error;
}
