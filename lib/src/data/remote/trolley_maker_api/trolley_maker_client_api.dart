import 'package:dio/dio.dart';
import 'package:heidi/src/data/model/model_trolley_maker_card_balance_transaction_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_login_request.dart';
import 'package:heidi/src/data/model/model_trolley_maker_login_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_register_request.dart';
import 'package:heidi/src/data/model/model_trolley_maker_register_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_sign_up_values.dart';
import 'package:retrofit/retrofit.dart';

part 'trolley_maker_client_api.g.dart';

@RestApi()
abstract class TrolleyMakerClientApi {
  factory TrolleyMakerClientApi(Dio dio) => _TrolleyMakerClientApi(dio);

  @POST('/api/v1/customers/login')
  Future<TrolleyMakerLoginResponse> login(
      @Body() TrolleyMakerLoginRequest request);

  @POST('/api/v1/customers/login')
  Future<TrolleyMakerRegisterResponse> register(
      @Body() TrolleyMakerRegisterRequest request);

  @GET('/customer-registration-form-values')
  Future<TrolleyMakerSignUpValues> getRegistrationFormValues();

  @GET('/api/v1//customers/transactions-balances')
  Future<CardBalanceAndTransactionResponse> getCardBalanceAndTransactions();

}
