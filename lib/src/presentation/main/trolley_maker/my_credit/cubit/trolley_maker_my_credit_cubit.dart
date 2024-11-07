import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/my_credit/cubit/trolley_maker_my_credit_state.dart';

class TrolleyMakerMyCreditCubit extends Cubit<TrolleyMakerMyCreditState> {
  final TrolleyMakerRepository trolleyMakerRepository;

  TrolleyMakerMyCreditCubit(this.trolleyMakerRepository)
      : super(const Initial());

  Future<void> getCardBalanceAndTransactions() async {
    emit(const Loading());
    try {
      var result = await trolleyMakerRepository.getCardBalanceAndTransactions();
      result.fold((error) => {emit(ApiError(error.errorMessage))},
          (responseModel) {
        emit(MyCreditSuccess(responseModel));
      });
    } catch (error) {
      emit(const ApiError(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }
}
