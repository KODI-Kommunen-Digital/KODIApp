import 'package:bloc/bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/qr_code/cubit/qr_code_state.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(const QrCodeState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
  }
}
