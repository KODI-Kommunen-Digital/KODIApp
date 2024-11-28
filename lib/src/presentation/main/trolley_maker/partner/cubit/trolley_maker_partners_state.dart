import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_trolley_maker_partners.dart';

part 'trolley_maker_partners_state.freezed.dart';

@freezed
class TrolleyMakerPartnersState with _$TrolleyMakerPartnersState {
  const factory TrolleyMakerPartnersState.initial() = Initial;
  const factory TrolleyMakerPartnersState.loading() = Loading;
  const factory TrolleyMakerPartnersState.success(List<TrolleyMakerPartners> partners) = PartnerListSuccess;
  const factory TrolleyMakerPartnersState.error(String message) = LoadFailure;
}