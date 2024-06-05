import 'package:freezed_annotation/freezed_annotation.dart';

part 'portal_state.freezed.dart';

@freezed
class PortalState with _$PortalState {
  const factory PortalState.initial() = PortalInitial;

  const factory PortalState.loading() = PortalLoading;

  const factory PortalState.loaded() =
      PortalLoaded;

  const factory PortalState.error(String errorMessage) = PortalError;
}
