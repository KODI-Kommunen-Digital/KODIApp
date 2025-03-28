import 'package:freezed_annotation/freezed_annotation.dart';

part 'qr_code_state.freezed.dart';

@freezed
class QrCodeState with _$QrCodeState {
  const factory QrCodeState.loading() = QrCodeStateLoading;

  const factory QrCodeState.loaded(String qrCodeData, String? validUntil,
      int? accountId, String name) = QrCodeStateLoadedProducts;

  const factory QrCodeState.error(String msg) = QrCodeStateError;
}
