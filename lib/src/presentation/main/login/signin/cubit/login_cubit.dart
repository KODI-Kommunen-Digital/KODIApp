import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';
import 'package:heidi/src/utils/translate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  void onLogin({
    required String username,
    required String password,
  }) async {
    final response = await UserRepository.login(
      username: username,
      password: password,
    );
    if (response!.success) {
      final userDetailResponse =
          await UserRepository.requestUserDetails(response.data['userId']);
      if (userDetailResponse != null) {
        bool redirectContainerCard = false;
        await AppBloc.authenticateCubit.onSave(userDetailResponse);

        final List? containerCards =
            await ContainerRepository.getCustomerCards(userDetailResponse.id);

        if ((containerCards ?? []).isEmpty) {
          final prefs = await Preferences.openBox();
          redirectContainerCard =
              prefs.getKeyValue(Preferences.redirectContainerCard, true);
        }

        emit(LoginState.loaded(redirectContainerCard));
      } else {
        emit(const LoginState.initial());
        logError('Login Result Failed', userDetailResponse);
      }
    } else {
      emit(const LoginState.initial());
      emit(LoginState.error(response.message));
      logError('Request User Detail Error', response.message);
    }
  }

  String? getTranslationKey(String sentence) {
    switch (sentence) {
      case "Invalid username":
        return "login_invalid_username";
      case "Invalid password":
        return "login_invalid_password";
      case "Verification email sent to your email id. Please verify first before trying to login.":
        return "login_verification_mail";
    }
    return null;
  }

  void onLogout() async {
    emit(const LoginState.initial());
    final prefs = await Preferences.openBox();
    prefs.deleteKey(Preferences.userId);
    AppBloc.authenticateCubit.onClear();
    AppBloc.userCubit.onDeleteUser();
  }

  static void showRedirectContainerCard(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context).translate('associate_container_card'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  Translate.of(context)
                      .translate('associate_container_card_message'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "(${Translate.of(context).translate('associate_container_card_reminder')})",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context).translate('never'),
              onPressed: () {
                saveRemindContainerCard();
                Navigator.of(context).pop();
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context).translate('later'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context).translate('connect'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, Routes.addCustomerCardScreen);
              },
              type: ButtonType.text,
            ),
          ],
        );
      },
    );
  }

  static Future<void> saveRemindContainerCard() async {
    final prefs = await Preferences.openBox();
    prefs.setKeyValue(Preferences.redirectContainerCard, false);
  }
}
