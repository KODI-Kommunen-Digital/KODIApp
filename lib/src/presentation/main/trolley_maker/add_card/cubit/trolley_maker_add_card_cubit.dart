import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/add_card/cubit/trolley_maker_add_card_state.dart';

class TrolleyMakerAddCardCubit extends Cubit<TrolleyMakerAddCardState> {
  final TrolleyMakerRepository trolleyMakerRepository;

  TrolleyMakerAddCardCubit(this.trolleyMakerRepository)
      : super(const Initial());

  Future<void> addCard(
      String cardNumber, String productionNumber, int cardIDToLock) async {
    emit(const Loading());
    try {
      var result = await trolleyMakerRepository.addCard(
          cardNumber, productionNumber, cardIDToLock);
      result.fold((error) => {emit(Error(error.errorMessage))},
          (responseModel) {
        emit(AddCardSuccess(cardNumber));
      });
    } catch (error) {
      emit(const Error(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }
}
