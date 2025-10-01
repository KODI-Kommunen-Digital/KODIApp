import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/main/account/contact_form/cubit/contact_form_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _textFirstNameController = TextEditingController();
  final _textLastNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textPhoneController = TextEditingController();
  final _textMessageController = TextEditingController();

  final _focusFirstName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPhone = FocusNode();
  final _focusMessage = FocusNode();

  String? _errorFirstName;
  String? _errorLastName;
  String? _errorEmail;
  String? _errorPhone;
  String? _errorMessage;

  @override
  void dispose() {
    _textFirstNameController.dispose();
    _textLastNameController.dispose();
    _textEmailController.dispose();
    _textPhoneController.dispose();
    _textMessageController.dispose();
    _focusFirstName.dispose();
    _focusLastName.dispose();
    _focusEmail.dispose();
    _focusPhone.dispose();
    _focusMessage.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Perform validation
    setState(() {
      _errorFirstName = UtilValidator.validate(
        _textFirstNameController.text,
        type: ValidateType.normal, // Assuming ValidateType.name is for general non-empty name
      );
      _errorLastName = UtilValidator.validate(
        _textLastNameController.text,
        type: ValidateType.normal, // Assuming ValidateType.name is for general non-empty name
      );
      _errorEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
      _errorPhone = UtilValidator.validate(
        _textPhoneController.text,
        type: ValidateType.phone,
      );
      _errorMessage = UtilValidator.validate(
        _textMessageController.text,
      );
    });

    if (_errorFirstName == null &&
        _errorLastName == null &&
        _errorEmail == null &&
        _errorPhone == null &&
        _errorMessage == null) {
      final String emailBodyContent = '''
${Translate.of(context).translate('first_name')}: ${_textFirstNameController.text}
${Translate.of(context).translate('last_name')}: ${_textLastNameController.text}
${Translate.of(context).translate('email')}: ${_textEmailController.text}
${Translate.of(context).translate('phone_number')}: ${_textPhoneController.text}

${Translate.of(context).translate('message_label')}:
${_textMessageController.text}
          ''';

      context.read<ContactFormCubit>().submitContactForm(
            firstName: _textFirstNameController.text,
            lastName: _textLastNameController.text,
            email: _textEmailController.text,
            phone: _textPhoneController.text,
            message: _textMessageController.text,
            ).then((success){
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Translate.of(context).translate('message_sent_success')),
              backgroundColor: Colors.green,
            ),
          );
          _textFirstNameController.clear();
          _textLastNameController.clear();
          _textEmailController.clear();
          _textPhoneController.clear();
          _textMessageController.clear();
          context.read<ContactFormCubit>().resetState();
          Navigator.pop(context);
        } else  {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(Translate.of(context).translate('error_message')),
              backgroundColor: Colors.red,
            ),
          );
          context.read<ContactFormCubit>().resetState();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactFormCubit(),
      child: BlocListener<ContactFormCubit, ContactFormState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(Translate.of(context).translate('contact_form_title')),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/Kontakt.jpg",
                            height: 250,
                            fit: BoxFit.fill,
                            width: double.infinity,

                          )),
                      const SizedBox(height: 15),
                      Text(
                        Translate.of(context).translate('first_name'),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate('input_first_name_hint'),
                        errorText: _errorFirstName,
                        focusNode: _focusFirstName,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (text) {
                          FocusScope.of(context).requestFocus(_focusLastName);
                        },
                        onChanged: (text) {
                          setState(() {
                            _errorFirstName = UtilValidator.validate(
                              _textFirstNameController.text,
                              type: ValidateType.normal,
                            );
                          });
                        },
                        controller: _textFirstNameController,
                      ),
                      const SizedBox(height: 16),

                      // Last Name
                      Text(
                        Translate.of(context).translate('last_name'),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate('input_last_name_hint'),
                        errorText: _errorLastName,
                        focusNode: _focusLastName,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (text) {
                          FocusScope.of(context).requestFocus(_focusEmail);
                        },
                        onChanged: (text) {
                          setState(() {
                            _errorLastName = UtilValidator.validate(
                              _textLastNameController.text,
                              type: ValidateType.normal,
                            );
                          });
                        },
                        controller: _textLastNameController,
                      ),
                      const SizedBox(height: 16),

                      // Email
                      Text(
                        Translate.of(context).translate('email'),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate('input_email_hint'),
                        errorText: _errorEmail,
                        focusNode: _focusEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (text) {
                          FocusScope.of(context).requestFocus(_focusPhone);
                        },
                        onChanged: (text) {
                          setState(() {
                            _errorEmail = UtilValidator.validate(
                              _textEmailController.text,
                              type: ValidateType.email,
                            );
                          });
                        },
                        controller: _textEmailController,
                      ),
                      const SizedBox(height: 16),

                      // Phone Number
                      Text(
                        Translate.of(context).translate('phone_number'),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate('input_phone_hint'),
                        errorText: _errorPhone,
                        focusNode: _focusPhone,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (text) {
                          FocusScope.of(context).requestFocus(_focusMessage);
                        },
                        onChanged: (text) {
                          setState(() {
                            _errorPhone = UtilValidator.validate(
                              _textPhoneController.text,
                              type: ValidateType.phone,
                            );
                          });
                        },
                        controller: _textPhoneController,
                      ),
                      const SizedBox(height: 16),

                      // Message
                      Text(
                        Translate.of(context).translate('message_label'),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate('input_message_hint_contact_form'),
                        errorText: _errorMessage,
                        focusNode: _focusMessage,
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (text) {
                          _submitForm();
                        },
                        onChanged: (text) {
                          setState(() {
                            _errorMessage = UtilValidator.validate(
                              _textMessageController.text,
                            );
                          });
                        },
                        controller: _textMessageController,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<ContactFormCubit, ContactFormState>(
                    builder: (context, state) {
                      final isLoading = state.status == ContactFormStatus.loading;
                      return AppButton(
                        Translate.of(context).translate('send'),
                        mainAxisSize: MainAxisSize.max,
                        onPressed: _submitForm,
                        disabled: isLoading,
                        loading: isLoading,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
