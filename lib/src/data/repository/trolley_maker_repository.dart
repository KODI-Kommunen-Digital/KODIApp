import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:heidi/src/data/model/model_trolley_maker_card_balance_transaction_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_error_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_login_request.dart';
import 'package:heidi/src/data/model/model_trolley_maker_login_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_partners.dart';
import 'package:heidi/src/data/model/model_trolley_maker_register_request.dart';
import 'package:heidi/src/data/model/model_trolley_maker_register_response.dart';
import 'package:heidi/src/data/model/model_trolley_maker_country.dart';
import 'package:heidi/src/data/model/model_trolley_maker_sign_up_values.dart';
import 'package:heidi/src/data/remote/trolley_maker_api/trolley_maker_client_api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';

class TrolleyMakerRepository {
  final Preferences prefs;
  final TrolleyMakerClientApi api;
  TrolleyMakerRepository(this.prefs, this.api);

  Future<Either<TrolleyMakerErrorResponse, TrolleyMakerLoginResponse>> login(
      String email, String password) async {
    var loginRequest =
        TrolleyMakerLoginRequest(cardID: email, password: password);
    try {
      final result = await api.login(loginRequest);
      await _saveLoginResult(result);
      return Right(result);
    } on DioException catch (exception) {
      try {
        final responseMap =
            jsonDecode(exception.response.toString()) as Map<String, dynamic>;
        final errorResponse = TrolleyMakerErrorResponse.fromJson(responseMap);
        return Left(errorResponse);
      } catch (e) {
        return Left(TrolleyMakerErrorResponse.unknownError());
      }
    } catch (e) {
      return Left(TrolleyMakerErrorResponse.unknownError());
    }
  }

  Future<bool> hasValidTrolleyMakerAuthToken() async {
    return (await prefs.getKeyValue(Preferences.trolleyMakerApiToken, ""))
        .isNotEmpty;
  }

  Future<Either<TrolleyMakerErrorResponse, TrolleyMakerRegisterResponse>>
      register(
          final String cardID,
          final String email,
          final String password,
          final String gender,
          final String firstName,
          final String lastName,
          final String street,
          final String zip,
          final String city,
          final String country,
          final String phone,
          final String birthdate,
          final bool conditionsConsent,
          final bool marketingAdsConsent,
          final bool newsletterConsent) async {
    var registerRequest = TrolleyMakerRegisterRequest(
        cardID: cardID,
        email: email,
        emailRepeated: email,
        password: password,
        passwordRepeated: password,
        gender: gender,
        firstName: firstName,
        lastName: lastName,
        street: street,
        zip: zip,
        city: city,
        country: country,
        phone: phone,
        birthdate: birthdate,
        conditionsConsent: conditionsConsent,
        marketingAdsConsent: marketingAdsConsent,
        newsletterConsent: newsletterConsent);
    try {
      final result = await api.register(registerRequest);
      return Right(result);
    } on DioException catch (exception) {
      try {
        final responseMap =
            jsonDecode(exception.response.toString()) as Map<String, dynamic>;
        final errorResponse = TrolleyMakerErrorResponse.fromJson(responseMap);
        return Left(errorResponse);
      } catch (e) {
        return Left(TrolleyMakerErrorResponse.unknownError());
      }
    } catch (e) {
      return Left(TrolleyMakerErrorResponse.unknownError());
    }
  }

  Future<List<TrolleyMakerCountry>> getCountryList(
      String countryFileName) async {
    String configPath = 'assets/data/$countryFileName';
    String jsonString = await rootBundle.loadString(configPath);
    List<dynamic> jsonData = jsonDecode(jsonString);
    List<TrolleyMakerCountry> countryList =
        jsonData.map((item) => TrolleyMakerCountry.fromJson(item)).toList();

    return countryList;
  }

  Future<Either<TrolleyMakerErrorResponse, TrolleyMakerSignUpValues>>
      getRegistrationValues() async {
    try {
      final result = await api.getRegistrationFormValues();
      return Right(result);
    } on DioException catch (exception) {
      try {
        final responseMap =
            jsonDecode(exception.response.toString()) as Map<String, dynamic>;
        final errorResponse = TrolleyMakerErrorResponse.fromJson(responseMap);
        return Left(errorResponse);
      } catch (e) {
        return Left(TrolleyMakerErrorResponse.unknownError());
      }
    } catch (e) {
      return Left(TrolleyMakerErrorResponse.unknownError());
    }
  }

  Future<Either<TrolleyMakerErrorResponse, CardBalanceAndTransactionResponse>>
      getCardBalanceAndTransactions() async {
    try {
      final result = await api.getCardBalanceAndTransactions();
      return Right(result);
    } on DioException catch (exception) {
      try {
        final responseMap =
            jsonDecode(exception.response.toString()) as Map<String, dynamic>;
        final errorResponse = TrolleyMakerErrorResponse.fromJson(responseMap);
        return Left(errorResponse);
      } catch (e) {
        return Left(TrolleyMakerErrorResponse.unknownError());
      }
    } catch (e) {
      return Left(TrolleyMakerErrorResponse.unknownError());
    }
  }

  Future<void> _saveLoginResult(TrolleyMakerLoginResponse result) async {
    await prefs.setKeyValue(Preferences.trolleyMakerApiToken, result.xApiToken);
    await prefs.setKeyValue(Preferences.trolleyMakerCardName, result.cardName);
    await prefs.setKeyValue(Preferences.trolleyMakerCardList, result.cardIDs);
  }

  Future<String?> getCachedCardName() async {
    try {
      return await prefs.getKeyValue(Preferences.trolleyMakerCardName, "");
    } catch (e) {
      return null;
    }
  }

  Future<List<int>?> getCachedCards() async {
    try {
      return await prefs.getKeyValue(Preferences.trolleyMakerCardList, []);
    } catch (e) {
      return null;
    }
  }

  Future<Either<TrolleyMakerErrorResponse, List<TrolleyMakerPartners>>>
      getPartnersList() async {
    try {
      final result = await api.getPartnersList();
      return Right(result);
    } on DioException catch (exception) {
      try {
        final responseMap =
            jsonDecode(exception.response.toString()) as Map<String, dynamic>;
        final errorResponse = TrolleyMakerErrorResponse.fromJson(responseMap);
        return Left(errorResponse);
      } catch (e) {
        return Left(TrolleyMakerErrorResponse.unknownError());
      }
    } catch (e) {
      return Left(TrolleyMakerErrorResponse.unknownError());
    }
  }
}
