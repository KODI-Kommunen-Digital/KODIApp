import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model_trolley_maker_add_card_request.dart';
import 'package:heidi/src/data/model/model_trolley_maker_card_balance_transaction_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_login_request.dart';
import 'package:heidi/src/data/model/model_trolley_maker_login_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_partner_details.dart';
import 'package:heidi/src/data/model/model_trolley_maker_partners.dart';
import 'package:heidi/src/data/model/model_trolley_maker_register_request.dart';
import 'package:heidi/src/data/model/model_trolley_maker_register_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_sign_up_values.dart';
import 'package:heidi/src/data/model/model_trolley_news.dart';
import 'package:retrofit/retrofit.dart';

part 'trolley_maker_client_api.g.dart';

@RestApi()
abstract class TrolleyMakerClientApi {
  factory TrolleyMakerClientApi(Dio dio) => _TrolleyMakerClientApi(dio);

  @POST('/api/v1/customers/login')
  Future<TrolleyMakerLoginResponse> login(
      @Body() TrolleyMakerLoginRequest request);

  @POST('/api/v1/customers')
  Future<TrolleyMakerRegisterResponse> register(
      @Body() TrolleyMakerRegisterRequest request);

  @GET('/customer-registration-form-values')
  Future<TrolleyMakerSignUpValues> getRegistrationFormValues();

  @GET('/api/v1/customers/transactions-balances')
  Future<CardBalanceAndTransactionResponse> getCardBalanceAndTransactions();

  @GET('/api/v1/partners')
  Future<List<TrolleyMakerPartners>> getPartnersList();

  @GET('/api/v1/partners/{gguid}')
  Future<TrolleyMakerPartnerDetailsInfo> getPartnerDetails(
      @Path("gguid") String gguid);

  @GET('/api/v1/news')
  Future<List<TrolleyNews>> getNews();

  @GET('/api/v1/news/{newsId}')
  Future<TrolleyNews> getNewsDetails(@Path("newsId") int newsId);

  @POST('/api/v2/add-card')
  Future<dynamic> addCard(@Body() TrolleyMakerAddCardRequest request);
}
