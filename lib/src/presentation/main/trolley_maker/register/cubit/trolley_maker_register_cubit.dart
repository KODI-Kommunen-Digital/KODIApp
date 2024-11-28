import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/register/cubit/trolley_maker_register_state.dart';

class TrolleyMakerRegisterCubit extends Cubit<TrolleyMakerRegisterState> {
  final TrolleyMakerRepository trolleyMakerRepository;

  TrolleyMakerRegisterCubit(this.trolleyMakerRepository)
      : super(const RegistrationInitial());

  Future<void> register({
    required String cardID,
    required String email,
    required String password,
    required String gender,
    required String firstName,
    required String lastName,
    required String street,
    required String zip,
    required String city,
    required String country,
    required String phone,
    required String birthdate,
    required bool conditionsConsent,
    required bool marketingAdsConsent,
    required bool newsletterConsent,
  }) async {
    emit(const Loading());
    try {
      // Use the repository to register the user
      var result = await trolleyMakerRepository.register(
          cardID,
          email,
          password,
          gender,
          firstName,
          lastName,
          street,
          zip,
          city,
          country,
          phone,
          birthdate,
          conditionsConsent,
          marketingAdsConsent,
          newsletterConsent);
      result.fold((error) => {emit(ApiError(error.errorMessage))},
          (responseModel) {
        emit(const RegistrationSuccess());
      });
    } catch (error) {
      emit(const ApiError(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }

  Future<void> fetchSelectorData(String countryFileName) async {
    emit(const Loading());
    try {
      var countryList =
          await trolleyMakerRepository.getCountryList(countryFileName);
      var result = await trolleyMakerRepository.getRegistrationValues();
      result.fold((error) => {emit(ApiError(error.errorMessage))},
          (responseModel) {
        emit(SingUpValues(
            countryList, responseModel.genders, responseModel.titles));
      });
    } catch (error) {
      emit(const ApiError(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }
}
