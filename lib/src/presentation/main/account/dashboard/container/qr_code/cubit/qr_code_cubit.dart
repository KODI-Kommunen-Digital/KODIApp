import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/qr_code/cubit/qr_code_state.dart';

class QrCodeCubit extends Cubit<QrCodeState> {
  QrCodeCubit() : super(const QrCodeState.loading());

  Future<void> onLoad() async {
    emit(const QrCodeState.loading());
    UserModel? user = await AppBloc.userCubit.onLoadUser();
    if(user != null) {
      emit(const QrCodeState.loaded("1234567890", "null", 0));
    } else {
      emit(const QrCodeState.error("login"));
    }
  }
}
