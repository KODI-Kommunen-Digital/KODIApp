import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_qr_code.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/qr_code/cubit/qr_code_state.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(const QrCodeState.loading());

  Future<void> onLoad() async {
    emit(const QrCodeState.loading());
    UserModel? user = await AppBloc.userCubit.onLoadUser();
    if (user != null) {
      final QRCode? qr = await ContainerRepository.getUserQrCode(user.id);
      if (qr != null) {
        emit(QrCodeState.loaded(qr.data, qr.validUntil, qr.accountId, '${user.firstname} ${user.lastname}'));
      } else {
        //Change back, using dummy data
        //emit(const QrCodeState.error("error"));
        emit(const QrCodeState.loaded("123456789", "23.10.1999", 0, "Peter Müller"));
      }
    } else {
      emit(const QrCodeState.error("login"));
    }
  }
}
