import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _textPassController = TextEditingController();
  final _textNewPassController = TextEditingController();
  final _textOldPassController = TextEditingController();
  final _focusPass = FocusNode();
  final _focusNewPass = FocusNode();
  final _focusOldPass = FocusNode();

  bool _showOldPassword = false;
  bool _showPassword = false;
  bool _showCPassword = false;
  bool _isPasswordFocused = false;
  String? _errorPass;
  String? _errorNewPass;
  String? _errorOldPass;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textPassController.dispose();
    _textNewPassController.dispose();
    _textOldPassController.dispose();
    _focusPass.dispose();
    _focusNewPass.dispose();
    _focusOldPass.dispose();
    super.dispose();
  }

  void _changePassword() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorPass =
          AppBloc.signupCubit.validatePassword(_textPassController.text);
      _errorNewPass = UtilValidator.validate(_textNewPassController.text,
          password: _textPassController.text, type: ValidateType.cpassword);
      _errorOldPass =
          AppBloc.signupCubit.validatePassword(_textOldPassController.text);
    });
    if (_errorPass != null) {
      _errorPass = Translate.of(context).translate(_errorPass);
    }
    if (_errorOldPass != null) {
      _errorOldPass = Translate.of(context).translate(_errorOldPass);
    }
    if (_errorPass == null && _errorNewPass == null && _errorOldPass == null) {
      final result = await AppBloc.changePasswordCubit.onChangePassword(
        _textOldPassController.text,
        _textNewPassController.text,
      );
      if (!mounted) return;
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(Translate.of(context)
                .translate('change_password_success'))));
        Navigator.pop(context);
      } else {
        if (result == 'Incorrect current password given') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(Translate.of(context)
                  .translate('current_password_incorrect'))));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(Translate.of(context).translate(
                  'New password should not be same as the old password'))));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setPasswordListener();
    String passwordHint = Translate.of(context).translate('Password hint');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('change_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('cur_password'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'cur_password',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  errorText: _errorOldPass,
                  onChanged: (text) {
                    setState(() {
                      _errorOldPass = UtilValidator.validate(
                        _textOldPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusOldPass,
                      _focusPass,
                    );
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        _showOldPassword = !_showOldPassword;
                      });
                    },
                    child: Icon(_showOldPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  obscureText: !_showOldPassword,
                  controller: _textOldPassController,
                  focusNode: _focusOldPass,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('newPass'),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'newPass',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  errorText: _errorPass,
                  onChanged: (text) {
                    setState(() {
                      _errorPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(
                      context,
                      _focusPass,
                      _focusNewPass,
                    );
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  obscureText: !_showPassword,
                  controller: _textPassController,
                  focusNode: _focusPass,
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: _isPasswordFocused,
                  child: Text(
                    passwordHint,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('cpassword'),
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'cpassword',
                  ),
                  errorText: _errorNewPass,
                  focusNode: _focusNewPass,
                  onChanged: (text) {
                    setState(() {
                      _errorNewPass = UtilValidator.validate(
                        _textNewPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    _changePassword();
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        _showCPassword = !_showCPassword;
                      });
                    },
                    child: Icon(_showCPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  obscureText: !_showCPassword,
                  controller: _textNewPassController,
                ),
                const SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('confirm'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _changePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setPasswordListener() {
    _focusPass.addListener(() {
      setState(() {
        _isPasswordFocused = _focusPass.hasFocus;
      });
    });
  }
}
