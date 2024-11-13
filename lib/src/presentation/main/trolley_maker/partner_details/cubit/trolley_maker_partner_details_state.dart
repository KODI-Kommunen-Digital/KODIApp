import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_trolley_maker_partner_details.dart';

part 'trolley_maker_partner_details_state.freezed.dart';

@freezed
class TrolleyMakerPartnerDetailsState with _$TrolleyMakerPartnerDetailsState {
  const factory TrolleyMakerPartnerDetailsState.initial() = Initial;
  const factory TrolleyMakerPartnerDetailsState.loading() = Loading;
  const factory TrolleyMakerPartnerDetailsState.success(TrolleyMakerPartnerDetailsInfo companyInfo) = PartnerDetailsSuccess;
  const factory TrolleyMakerPartnerDetailsState.error(String message) = LoadFailure;
}