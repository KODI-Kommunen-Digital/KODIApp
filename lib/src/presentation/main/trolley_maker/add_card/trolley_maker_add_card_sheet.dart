import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/add_card/cubit/trolley_maker_add_card_cubit.dart';
import 'package:heidi/src/presentation/main/trolley_maker/add_card/cubit/trolley_maker_add_card_state.dart';
import 'package:heidi/src/presentation/main/trolley_maker/cards/cubit/trolley_maker_cards_cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class TrolleyMakerAddCardSheet extends StatefulWidget {
  final int? cardToLock;
  const TrolleyMakerAddCardSheet(this.cardToLock, {super.key});

  @override
  State<TrolleyMakerAddCardSheet> createState() =>
      _TrolleyMakerAddCardSheetState();
}

class _TrolleyMakerAddCardSheetState extends State<TrolleyMakerAddCardSheet> {
  late TrolleyMakerAddCardCubit trolleyMakerCubit;
  bool isLoading = false;

  final _cardNumberTextController = TextEditingController();
  final _productNumberTextController = TextEditingController();
  final _focusCardNumber = FocusNode();
  final _focusProductNumber = FocusNode();
  String? _errorCardNumber;
  String? _errorProductNumber;

  String? _apiError;

  late BuildContext _buildContext;

  @override
  void initState() {
    super.initState();
    trolleyMakerCubit =
        TrolleyMakerAddCardCubit(context.read<TrolleyMakerRepository>());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return BlocProvider(
      create: (_) => trolleyMakerCubit,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text(
                  Translate.of(context).translate('add_card'),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      if (!isLoading) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: BlocConsumer<TrolleyMakerAddCardCubit,
                    TrolleyMakerAddCardState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      error: (msg) {
                        setState(() {
                          isLoading = false;
                          _apiError = msg;
                        });
                      },
                      success: (cardNumber) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pop();
                        BlocProvider.of<TrolleyMakerCardsCubit>(_buildContext)
                            .addedNewCard(cardNumber);
                      },
                      loading: () {
                        setState(() {
                          isLoading = true;
                        });
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) => _getAddCardForm(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAddCardForm() {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        AppTextInput(
          readOnly: isLoading,
          hintText: Translate.of(context).translate('card_number'),
          errorText: _errorCardNumber,
          controller: _cardNumberTextController,
          focusNode: _focusCardNumber,
          autofillHint: const [AutofillHints.username],
          textInputAction: TextInputAction.next,
          onChanged: (text) {
            setState(() {
              _errorCardNumber = UtilValidator.validate(
                  _cardNumberTextController.text,
                  type: ValidateType.card);
            });
          },
          onSubmitted: (text) {
            Utils.fieldFocusChange(
                context, _focusCardNumber, _focusProductNumber);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        AppTextInput(
          readOnly: isLoading,
          hintText: Translate.of(context).translate('production_number'),
          errorText: _errorProductNumber,
          controller: _productNumberTextController,
          focusNode: _focusProductNumber,
          autofillHint: const [AutofillHints.username],
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          onChanged: (text) {
            setState(() {
              _errorProductNumber = UtilValidator.validate(
                  _productNumberTextController.text,
                  type: ValidateType.normal);
            });
          },
          onSubmitted: (text) {
            _onAddNewCardClick();
          },
        ),
        const SizedBox(
          height: 15,
        ),
        if (_apiError != null)
          ErrorText(
            apiError: _apiError,
          ),
        const SizedBox(
          height: 15,
        ),
        if (isLoading)
          Container(
            height: 48,
            alignment: Alignment.center,
            child: const CircularProgressIndicator.adaptive(),
          )
        else
          AppButton(Translate.of(context).translate('add_new_card'),
              onPressed: _onAddNewCardClick,
              type: ButtonType.normal,
              mainAxisSize: MainAxisSize.max),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  void _onAddNewCardClick() {
    _focusProductNumber.unfocus();
    setState(() {
      _apiError = null;
      _errorCardNumber = UtilValidator.validate(_cardNumberTextController.text,
          type: ValidateType.card);
      _errorProductNumber = UtilValidator.validate(
          _productNumberTextController.text,
          type: ValidateType.normal);
    });
    if (_errorCardNumber == null &&
        _errorProductNumber == null &&
        widget.cardToLock != null) {
      trolleyMakerCubit.addCard(_cardNumberTextController.text,
          _productNumberTextController.text);
    }
  }
}

class ErrorText extends StatelessWidget {
  final String? apiError;
  const ErrorText({super.key, this.apiError});

  @override
  Widget build(BuildContext context) {
    // Colors based on the theme
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.red.shade900.withOpacity(0.8)
        : Colors.red.shade100;
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.red.shade200
        : Colors.red.shade900;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor, // Dynamic background
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: Text(
        apiError ?? "",
        style: TextStyle(
          color: textColor, // Dynamic text color
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
