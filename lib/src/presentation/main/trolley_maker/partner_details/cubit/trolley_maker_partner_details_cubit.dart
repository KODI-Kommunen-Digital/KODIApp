import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner_details/cubit/trolley_maker_partner_details_state.dart';

class TrolleyMakerPartnerDetailsCubit
    extends Cubit<TrolleyMakerPartnerDetailsState> {
  final TrolleyMakerRepository trolleyMakerRepository;

  TrolleyMakerPartnerDetailsCubit(this.trolleyMakerRepository)
      : super(const Initial());

  Future<void> getPartnerDetails(String gguid) async {
    emit(const Loading());
    try {
      var result = await trolleyMakerRepository.getPartnerDetails(gguid);
      result.fold((error) => {emit(LoadFailure(error.errorMessage))},
          (responseModel) {
        emit(PartnerDetailsSuccess(responseModel));
      });
    } catch (error) {
      emit(const LoadFailure(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }
}
