import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/cards/cubit/trolley_maker_cards_state.dart';

class TrolleyMakerCardsCubit extends Cubit<TrolleyMakerCardsState> {
  final TrolleyMakerRepository trolleyMakerRepository;

  TrolleyMakerCardsCubit(this.trolleyMakerRepository) : super(const Initial());

  Future<void> getCardDetails() async {
    emit(const Loading());
    try {
      var name = await trolleyMakerRepository.getCachedCardName();
      var cardList = await trolleyMakerRepository.getCachedCards();
      if (name != null && cardList != null) {
        emit(CardDataSuccess(name, cardList));
      } else {
        emit(const LoadFailure(
            "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
      }
    } catch (error) {
      emit(const LoadFailure(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }
}
