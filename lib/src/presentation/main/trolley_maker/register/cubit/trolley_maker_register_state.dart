import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_trolley_maker_country.dart';

part 'trolley_maker_register_state.freezed.dart';

@freezed
class TrolleyMakerRegisterState with _$TrolleyMakerRegisterState {
  const factory TrolleyMakerRegisterState.initial() = RegistrationInitial;
  const factory TrolleyMakerRegisterState.loading() = Loading;
  const factory TrolleyMakerRegisterState.success() = RegistrationSuccess;
  const factory TrolleyMakerRegisterState.error(String message) = ApiError;
  const factory TrolleyMakerRegisterState.singUpValues(List<TrolleyMakerCountry> countryList, List<String> genderList, List<String> titleList) = SingUpValues;
}