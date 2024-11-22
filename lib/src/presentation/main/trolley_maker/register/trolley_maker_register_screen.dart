import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_trolley_maker_country.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/register/cubit/trolley_maker_register_cubit.dart';
import 'package:heidi/src/presentation/main/trolley_maker/register/cubit/trolley_maker_register_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/trolley_maker_terms_url_handler.dart';
import 'package:heidi/src/utils/validate.dart';
import 'package:intl/intl.dart';

class TrolleyMakerRegisterScreen extends StatefulWidget {
  const TrolleyMakerRegisterScreen({super.key});

  @override
  State<TrolleyMakerRegisterScreen> createState() =>
      _TrolleyMakerRegisterScreenState();
}

class _TrolleyMakerRegisterScreenState
    extends State<TrolleyMakerRegisterScreen> {
  late TrolleyMakerRegisterCubit trolleyMakerCubit;

  final _cardNumberTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _confirmEmailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _streetHouseTextController = TextEditingController();
  final _zipCodeTextController = TextEditingController();
  final _locationTextController = TextEditingController();
  final _telephoneTextController = TextEditingController();
  final _dobTextController = TextEditingController();

  final _cardNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _confirmEmailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _streetHouseFocusNode = FocusNode();
  final _zipCodeFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _telephoneFocusNode = FocusNode();
  final _dobFocusNode = FocusNode();

  String? _cardNumberErrorId;
  String? _emailErrorId;
  String? _confirmEmailErrorId;
  String? _passwordErrorId;
  String? _confirmPasswordErrorId;
  String? _firstNameErrorId;
  String? _lastNameErrorId;
  String? _streetHouseErrorId;
  String? _zipCodeErrorId;
  String? _telephoneErrorId;
  String? _locationErrorId;
  String? _dobErrorId;
  String? _genderErrorText;

  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isPasswordFocused = false;

  List<TrolleyMakerCountry>? countryList;
  List<String>? genderList;
  List<String>? titleList;

  // String? _selectedTitle;
  String? _selectedGender;
  TrolleyMakerCountry? _selectedCountry;
  DateTime? _selectedDate;
  bool _conditionsConsent = false;
  bool _marketingAdsConsent = false;
  bool _newsletterConsent = false;

  @override
  void initState() {
    super.initState();
    trolleyMakerCubit =
        TrolleyMakerRegisterCubit(context.read<TrolleyMakerRepository>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String countryFileName =
          Translate.of(context).translate('trolley_maker_filename');
      trolleyMakerCubit.fetchSelectorData(countryFileName);
    });
  }

  @override
  void dispose() {
    // Dispose text controllers
    _cardNumberTextController.dispose();
    _emailTextController.dispose();
    _confirmEmailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _streetHouseTextController.dispose();
    _zipCodeTextController.dispose();
    _locationTextController.dispose();
    _telephoneTextController.dispose();
    _dobTextController.dispose();

    // Dispose focus nodes
    _cardNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _confirmEmailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _streetHouseFocusNode.dispose();
    _zipCodeFocusNode.dispose();
    _locationFocusNode.dispose();
    _telephoneFocusNode.dispose();
    _dobFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setPasswordListener();

    return BlocProvider(
      create: (_) => trolleyMakerCubit,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('sign_up'),
          ),
        ),
        body:
            BlocConsumer<TrolleyMakerRegisterCubit, TrolleyMakerRegisterState>(
          listener: (context, state) {
            state.maybeWhen(
              success: () {
                  _showSuccessDialog();
              },
              error: (msg) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(msg)));
              },
              orElse: () {},
            );
          },
          builder: (context, state) => state.when(
            initial: () {
              return _registrationForm();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            success: () {
              return Container();
            },
            error: (message) {
              return _registrationForm();
            },
            singUpValues: (List<TrolleyMakerCountry> countryList,
                List<String> genderList, List<String> titleList) {
              this.countryList = countryList;
              setDefaultCountryList();
              this.genderList = genderList;
              this.titleList = titleList;
              return _registrationForm();
            },
          ),
        ),
      ),
    );
  }

  void setPasswordListener() {
    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFocused = _passwordFocusNode.hasFocus;
      });
    });
  }

  Widget _registrationForm() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              _signUpInput(
                  'title_card_number',
                  'hint_card_number',
                  _cardNumberErrorId,
                  _cardNumberTextController,
                  _cardNumberFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _cardNumberErrorId = UtilValidator.validate(
                      _cardNumberTextController.text,
                      type: ValidateType.card);
                });
              }, () {
                Utils.fieldFocusChange(
                    context, _cardNumberFocusNode, _emailFocusNode);
              }),
              _signUpInput(
                  'title_email',
                  'hint_email',
                  _emailErrorId,
                  _emailTextController,
                  _emailFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _emailErrorId = UtilValidator.validate(
                      _emailTextController.text,
                      type: ValidateType.email);
                });
              }, () {
                Utils.fieldFocusChange(
                    context, _emailFocusNode, _confirmEmailFocusNode);
              }, keyboardType: TextInputType.emailAddress),
              _signUpInput(
                  'title_repeat_email',
                  'hint_repeat_email',
                  _confirmEmailErrorId,
                  _confirmEmailTextController,
                  _confirmEmailFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _confirmEmailErrorId = UtilValidator.validate(
                      _confirmEmailTextController.text,
                      type: ValidateType.email);
                });
              }, () {
                Utils.fieldFocusChange(
                    context, _confirmEmailFocusNode, _passwordFocusNode);
              }, keyboardType: TextInputType.emailAddress),
              _signUpInput(
                'title_password',
                'hint_password',
                _passwordErrorId,
                _passwordTextController,
                _passwordFocusNode,
                TextInputAction.next,
                () {
                  setState(() {
                    _passwordErrorId = UtilValidator.validate(
                        _passwordTextController.text,
                        type: ValidateType.trolleyMakerPassword);
                  });
                },
                () {
                  Utils.fieldFocusChange(
                      context, _passwordFocusNode, _confirmPasswordFocusNode);
                },
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  child: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                ),
                obscureText: !_showPassword,
              ),
              Visibility(
                visible: _isPasswordFocused,
                child: Text(
                  Translate.of(context).translate('rule_password'),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              _signUpInput(
                'title_repeat_password',
                'hint_repeat_password',
                _confirmPasswordErrorId,
                _confirmPasswordTextController,
                _confirmPasswordFocusNode,
                TextInputAction.next,
                () {
                  setState(() {
                    _confirmPasswordErrorId = UtilValidator.validate(
                        _confirmPasswordTextController.text,
                        type: ValidateType.trolleyMakerPassword);
                  });
                },
                () {
                  // Utils.fieldFocusChange(
                  //     context, _confirmPasswordFocusNode, _FocusNode);
                },
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    setState(() {
                      _showConfirmPassword = !_showConfirmPassword;
                    });
                  },
                  child: Icon(_showConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                obscureText: !_showConfirmPassword,
              ),
              // _titleDropDown(),
              _genderDropDown(),
              _signUpInput(
                  'title_first_name',
                  'hint_first_name',
                  _firstNameErrorId,
                  _firstNameTextController,
                  _firstNameFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _firstNameErrorId =
                      UtilValidator.validate(_firstNameTextController.text);
                });
              }, () {
                Utils.fieldFocusChange(
                    context, _firstNameFocusNode, _lastNameFocusNode);
              }),
              _signUpInput(
                  'title_last_name',
                  'hint_last_name',
                  _lastNameErrorId,
                  _lastNameTextController,
                  _lastNameFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _lastNameErrorId =
                      UtilValidator.validate(_lastNameTextController.text);
                });
              }, () {
                Utils.fieldFocusChange(
                    context, _lastNameFocusNode, _streetHouseFocusNode);
              }),
              _signUpInput(
                  'title_street_and_house',
                  'hint_street_and_house',
                  _streetHouseErrorId,
                  _streetHouseTextController,
                  _streetHouseFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _streetHouseErrorId =
                      UtilValidator.validate(_streetHouseTextController.text);
                });
              }, () {
                Utils.fieldFocusChange(
                    context, _streetHouseFocusNode, _zipCodeFocusNode);
              }),
              _signUpInput(
                  'title_zip_code',
                  'hint_zip_code',
                  _zipCodeErrorId,
                  _zipCodeTextController,
                  _zipCodeFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _zipCodeErrorId = UtilValidator.validate(
                      _zipCodeTextController.text,
                      type: ValidateType.zipCode);
                });
              }, () {
                Utils.fieldFocusChange(
                    context, _zipCodeFocusNode, _locationFocusNode);
              }, maxLength: 5),
              _signUpInput(
                  'title_location',
                  'hint_location',
                  _locationErrorId,
                  _locationTextController,
                  _locationFocusNode,
                  TextInputAction.next, () {
                setState(() {
                  _locationErrorId =
                      UtilValidator.validate(_locationTextController.text);
                });
              }, () {
                // Utils.fieldFocusChange(
                //     context, _locationFocusNode, _FocusNode);
              }),
              _countryDropDown(),
              _signUpInput(
                'title_telephone',
                'hint_telephone',
                _telephoneErrorId,
                _telephoneTextController,
                _telephoneFocusNode,
                TextInputAction.next,
                () {
                  setState(() {
                    _telephoneErrorId = UtilValidator.validate(
                        _telephoneTextController.text,
                        allowEmpty: true,
                        type: ValidateType.phone);
                  });
                },
                () {
                  Utils.fieldFocusChange(
                      context, _telephoneFocusNode, _dobFocusNode);
                },
                keyboardType: TextInputType.phone,
              ),
              _dobInput(),
              _termsAndContions(),
              AppButton(
                Translate.of(context).translate('sign_up'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _signUp,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpInput(
      String titleId,
      String hintId,
      String? errorId,
      TextEditingController controller,
      FocusNode node,
      TextInputAction action,
      VoidCallback onChange,
      VoidCallback onSubmit,
      {final Widget? trailing,
      bool obscureText = false,
      final TextInputType? keyboardType,
      final int? maxLength}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translate.of(context).translate(titleId),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppTextInput(
          maxLength: maxLength,
          hintText: Translate.of(context).translate(hintId),
          errorText: errorId,
          controller: controller,
          focusNode: node,
          textInputAction: action,
          onChanged: (text) {
            onChange.call();
          },
          onSubmitted: (text) {
            onSubmit.call();
          },
          trailing: trailing,
          obscureText: obscureText,
          keyboardType: keyboardType,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Widget _titleDropDown() {
  //   return _getDropDown(
  //       title: Translate.of(context).translate('title_title'),
  //       menuItems: titleList?.map<DropdownMenuEntry<String>>((String value) {
  //             return DropdownMenuEntry<String>(
  //               value: value,
  //               label: value,
  //             );
  //           }).toList() ??
  //           [],
  //       onSelected: (value) {
  //         _selectedTitle = value as String;
  //       },
  //       initialSelection: _selectedTitle);
  // }

  Widget _genderDropDown() {
    return _getDropDown(
      title: Translate.of(context).translate('title_gender'),
      menuItems: genderList?.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(
              value: value,
              label: value,
            );
          }).toList() ??
          [],
      onSelected: (value) {
        _selectedGender = value as String;
        setState(() {
          _checkForGenderError();
        });
      },
      errorText: _genderErrorText,
      initialSelection: _selectedGender,
    );
  }

  Widget _countryDropDown() {
    return _getDropDown<TrolleyMakerCountry>(
        title: Translate.of(context).translate('title_country'),
        menuItems: countryList?.map<DropdownMenuEntry<TrolleyMakerCountry>>(
                (TrolleyMakerCountry value) {
              return DropdownMenuEntry<TrolleyMakerCountry>(
                value: value,
                label: value.name,
              );
            }).toList() ??
            [],
        onSelected: (value) {
          _selectedCountry = value as TrolleyMakerCountry;
        },
        initialSelection: _selectedCountry,
        isEnabled: false);
  }

  Widget _dobInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translate.of(context).translate('title_dob'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppTextInput(
          readOnly: true,
          hintText: Translate.of(context).translate('hint_dob'),
          errorText: _dobErrorId,
          controller: _dobTextController,
          focusNode: _dobFocusNode,
          textInputAction: TextInputAction.next,
          onTap: () {
            _selectDate(context);
          },
          onChanged: (text) {
            if (text.isEmpty) {
              _selectedDate = null;
            }
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900), // You can change this to your requirement
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dobTextController.text = DateFormat('dd.MM.yyyy').format(pickedDate);
        _dobErrorId = UtilValidator.validate(_dobTextController.text);
      });
    }
  }

  void setDefaultCountryList() {
    try {
      _selectedCountry =
          countryList?.firstWhere((country) => country.value == "DE");
    } catch (e) {
      _selectedCountry = TrolleyMakerCountry(value: "DE", name: "Germany");
    }
  }

  Widget _getDropDown<T>({
    String? title,
    required List<DropdownMenuEntry<T>> menuItems,
    required ValueChanged<T?>? onSelected,
    T? initialSelection,
    bool? isEnabled,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              DropdownMenu<T>(
                enabled: isEnabled ?? true,
                initialSelection: initialSelection,
                inputDecorationTheme: InputDecorationTheme(
                    constraints:
                        BoxConstraints.tight(const Size.fromHeight(50)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 0)),
                width: double.infinity,
                hintText: Translate.of(context).translate('selector_hint'),
                dropdownMenuEntries: menuItems,
                onSelected: onSelected,
              ),
              Positioned(
                bottom: 0,
                left: 15,
                child: Text(
                  errorText ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.error),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _signUp() {
    _runErrorIdValidation();
    if (_areAllErrorIdsNull()) {
      trolleyMakerCubit.register(
          cardID: _cardNumberTextController.text,
          email: _emailTextController.text,
          password: _passwordTextController.text,
          gender: _selectedGender!,
          firstName: _firstNameTextController.text,
          lastName: _lastNameTextController.text,
          street: _streetHouseTextController.text,
          zip: _zipCodeTextController.text,
          city: _locationTextController.text,
          country: _selectedCountry!.value,
          phone: _telephoneTextController.text,
          birthdate: _dobTextController.text,
          conditionsConsent: _conditionsConsent,
          marketingAdsConsent: _marketingAdsConsent,
          newsletterConsent: _newsletterConsent);
    }
  }

  bool _areAllErrorIdsNull() {
    return _cardNumberErrorId == null &&
        _emailErrorId == null &&
        _confirmEmailErrorId == null &&
        _passwordErrorId == null &&
        _confirmPasswordErrorId == null &&
        _firstNameErrorId == null &&
        _lastNameErrorId == null &&
        _streetHouseErrorId == null &&
        _zipCodeErrorId == null &&
        _locationErrorId == null &&
        _telephoneErrorId == null &&
        _dobErrorId == null &&
        _genderErrorText == null;
  }

  void _runErrorIdValidation() {
    setState(() {
      _cardNumberErrorId = UtilValidator.validate(
          _cardNumberTextController.text,
          type: ValidateType.card);
      _emailErrorId = UtilValidator.validate(_emailTextController.text,
          type: ValidateType.email);
      _confirmEmailErrorId = UtilValidator.validate(
          _confirmEmailTextController.text,
          type: ValidateType.email);
      if (_confirmEmailErrorId == null && _emailErrorId == null) {
        _confirmEmailErrorId = UtilValidator.validate(
            _confirmEmailTextController.text,
            type: ValidateType.cemail,
            email: _emailTextController.text);
      }
      _passwordErrorId = UtilValidator.validate(_passwordTextController.text,
          type: ValidateType.trolleyMakerPassword);
      _confirmPasswordErrorId = UtilValidator.validate(
          _confirmPasswordTextController.text,
          type: ValidateType.trolleyMakerPassword);

      if (_passwordErrorId == null && _confirmPasswordErrorId == null) {
        _confirmPasswordErrorId = UtilValidator.validate(
            _confirmPasswordTextController.text,
            type: ValidateType.cpassword,
            password: _passwordTextController.text);
      }
      _firstNameErrorId = UtilValidator.validate(_firstNameTextController.text);
      _lastNameErrorId = UtilValidator.validate(_lastNameTextController.text);
      _streetHouseErrorId =
          UtilValidator.validate(_streetHouseTextController.text);
      _zipCodeErrorId = UtilValidator.validate(_zipCodeTextController.text,
          type: ValidateType.zipCode);
      _locationErrorId = UtilValidator.validate(_locationTextController.text);
      _telephoneErrorId = UtilValidator.validate(_telephoneTextController.text,
          allowEmpty: true, type: ValidateType.phone);
      _dobErrorId = UtilValidator.validate(_dobTextController.text);
      _checkForGenderError();
    });
  }

  void _checkForGenderError() {
    if (_selectedGender == null) {
      _genderErrorText = "Das Feld muss ausgefüllt werden.";
    } else {
      _genderErrorText = null;
    }
  }

  _termsAndContions() {
    return Column(
      children: [
        _conditionsConsentTerm(),
        const SizedBox(height: 16),
        _marketingConsentTerm(),
        const SizedBox(height: 16),
        _newsLetterConsentTerm(),
        const SizedBox(height: 20),
        _genericConsentTerm(),
        const SizedBox(height: 25),
      ],
    );
  }

  _conditionsConsentTerm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: _conditionsConsent,
          onChanged: (value) {
            setState(() {
              _conditionsConsent = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: Translate.of(context)
                  .translate('term_conditions_consent_part1'),
              style: const TextStyle(fontSize: 14),
              children: [
                _linkTextSpan(
                    Translate.of(context)
                        .translate('term_conditions_consent_part2'), () {
                  TrolleyMakerTermsUrlHandler.launchConditionsUrl();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _linkTextSpan(String text, VoidCallback onLinkClick) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.blue,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onLinkClick,
    );
  }

  _marketingConsentTerm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: _marketingAdsConsent,
          onChanged: (value) {
            setState(() {
              _marketingAdsConsent = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: Translate.of(context)
                  .translate('term_marketing_consent_part1'),
              style: const TextStyle(fontSize: 14),
              children: [
                _linkTextSpan(
                    Translate.of(context)
                        .translate('term_marketing_consent_part2'), () {
                  TrolleyMakerTermsUrlHandler.launchConsentDeclerationUrl();
                }),
                TextSpan(
                  text: Translate.of(context)
                      .translate('term_marketing_consent_part3'),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _newsLetterConsentTerm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: _newsletterConsent,
          onChanged: (value) {
            setState(() {
              _newsletterConsent = value ?? false;
            });
          },
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: Translate.of(context).translate('term_news_letter_consent'),
              style: const TextStyle(fontSize: 14),
              children: const [],
            ),
          ),
        ),
      ],
    );
  }

  _genericConsentTerm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: false,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Checkbox(
            value: false,
            onChanged: (value) {},
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              text:
                  Translate.of(context).translate('term_generic_consent_part1'),
              style: const TextStyle(fontSize: 14),
              children: [
                _linkTextSpan(
                    Translate.of(context)
                        .translate('term_generic_consent_part2'), () {
                  TrolleyMakerTermsUrlHandler.launchPrivacyPolicyUrl();
                }),
                TextSpan(
                  text: Translate.of(context)
                      .translate('term_generic_consent_part3'),
                  style: const TextStyle(fontSize: 14),
                ),
                _linkTextSpan(
                    Translate.of(context)
                        .translate('term_generic_consent_part4'), () {
                  TrolleyMakerTermsUrlHandler.launchDataProtectionUrl();
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              Translate.of(context).translate('registration_success_title')),
          content: Text(
              Translate.of(context).translate('registration_success_content')),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  Text(Translate.of(context).translate('go_to_login_button')),
            ),
          ],
        );
      },
    ).then((_) {
      Navigator.of(context).pop();
    });
  }
}
