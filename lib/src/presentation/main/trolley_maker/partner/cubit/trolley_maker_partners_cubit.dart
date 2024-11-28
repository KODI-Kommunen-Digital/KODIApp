import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner/cubit/trolley_maker_partners_state.dart';

class TrolleyMakerPartnersCubit extends Cubit<TrolleyMakerPartnersState> {
  final TrolleyMakerRepository trolleyMakerRepository;

  TrolleyMakerPartnersCubit(this.trolleyMakerRepository) : super(const Initial());

  Future<void> getPartnerList() async {
    emit(const Loading());
    try {
      var result = await trolleyMakerRepository.getPartnersList();
      result.fold((error) => {emit(LoadFailure(error.errorMessage))},
          (responseModel) {
        emit(PartnerListSuccess(responseModel));
      });
    } catch (error) {
      emit(const LoadFailure(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }
}
