// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';

class AddCustomerCardScreen extends StatefulWidget {
  const AddCustomerCardScreen({super.key});

  @override
  State<AddCustomerCardScreen> createState() => _AddCustomerCardScreenState();
}

class _AddCustomerCardScreenState extends State<AddCustomerCardScreen> {
  final TextEditingController _textIDController = TextEditingController();
  final TextEditingController _textPinController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPin = FocusNode();
  String? _errorNumberId;
  String? _errorNumberPin;

  Future<void> addCard() async {
    int? cardId;
    int? pin;
    try {
      cardId = int.parse(_textIDController.text);
    } catch (e) {
      setState(() {
        _errorNumberId = Translate.of(context).translate('value_not_number');
      });
      return;
    }

    setState(() {
      _errorNumberId = null;
    });

    try {
      pin = int.parse(_textPinController.text);
    } catch (e) {
      setState(() {
        _errorNumberPin = Translate.of(context).translate('value_not_number');
      });
      return;
    }

    setState(() {
      _errorNumberPin = null;
    });

    if (_textPinController.text.length != 6) {
      _showMessage('pin_error_length');
      return;
    }

    final UserModel? user = await UserRepository.loadUser();
    if (user != null) {
      final result =
          await ContainerRepository.associateCard(user.id, cardId, pin);
      if (result != null && result.success) {
        _showMessage('add_card_success');
        Navigator.of(context).pop();
        return;
      } else if (result != null) {
        if(result.message.contains("You are already associated")) {
          _showMessage('container_card_already_associated');
        } else if(result.message.contains("Card not found")) {
          _showMessage('container_card_not_found');
        } else if(result.message.contains("Card is already associated")) {
          _showMessage('container_card_other_associated');
        } else if(result.message.contains("PIN code is incorrect")) {
          _showMessage('pin_wrong');
        }
      } else {
        _showMessage('error_message');
      }
    } else {
      _showMessage('login_required');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Translate.of(context).translate(message))));
  }

  @override
  void dispose() {
    _focusID.dispose();
    _focusPin.dispose();
    _textIDController.dispose();
    _textPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('add_card')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppTextInput(
              hintText: "ID",
              controller: _textIDController,
              errorText: _errorNumberId,
              focusNode: _focusID,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSubmitted: (text) {
                Utils.fieldFocusChange(context, _focusID, _focusPin);
              },
            ),
            const SizedBox(height: 8),
            AppTextInput(
              hintText: 'PIN',
              controller: _textPinController,
              errorText: _errorNumberPin,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              obscureText: true,
              onSubmitted: (text) {
                addCard();
              },
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 4),
            AppButton(
              Translate.of(context).translate('submit'),
              onPressed: () {
                addCard();
              },
              type: ButtonType.normal,
            ),
          ],
        ),
      ),
    );
  }
}
