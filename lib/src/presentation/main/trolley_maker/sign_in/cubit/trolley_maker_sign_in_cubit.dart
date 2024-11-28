import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'trolley_maker_signin_state.dart';

class TrolleyMakerSigninCubit extends Cubit<TrolleyMakerSigninState> {
  final TrolleyMakerRepository repository;
  TrolleyMakerSigninCubit(this.repository)
      : super(const TrolleyMakerSigninState.initial());

  Future<void> signIn(String email, String password) async {
    emit(const TrolleyMakerSigninState.loading());
    try {
      var result = await repository.login(email, password);
      result.fold(
          (error) => {emit(TrolleyMakerSigninState.error(error.errorMessage))},
          (responseModel) {
        emit(const TrolleyMakerSigninState.success());
      });
    } catch (error) {
      emit(const TrolleyMakerSigninState.error(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }

  Future<void> checkAuthState() async {
    var hasValidAuthToken = await repository.hasValidTrolleyMakerAuthToken();
    if (hasValidAuthToken) {
      emit(const TrolleyMakerSigninState.success());
    }
  }
}
