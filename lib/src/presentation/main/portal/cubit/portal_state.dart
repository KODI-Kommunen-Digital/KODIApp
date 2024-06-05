import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_user.dart';

part 'portal_state.freezed.dart';

@freezed
class PortalState with _$PortalState {
  const factory PortalState.initial() = PortalInitial;

  const factory PortalState.loading() = PortalLoading;

  const factory PortalState.loaded(UserModel? user) =
      PortalLoaded;

  const factory PortalState.error(String errorMessage) = PortalError;
}
