import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/cards/cubit/trolley_maker_cards_cubit.dart';
import 'package:heidi/src/presentation/main/trolley_maker/cards/cubit/trolley_maker_cards_state.dart';
import 'package:heidi/src/utils/translate.dart';

class TrolleyMakerCardsScreen extends StatefulWidget {
  const TrolleyMakerCardsScreen({super.key});

  @override
  State<TrolleyMakerCardsScreen> createState() =>
      _TrolleyMakerCardsScreenState();
}

class _TrolleyMakerCardsScreenState extends State<TrolleyMakerCardsScreen> {
  late TrolleyMakerCardsCubit trolleyMakerCubit;
  final PageController _pageController = PageController();

  String? cardName;

  List<int>? cardList;

  @override
  void initState() {
    super.initState();
    trolleyMakerCubit =
        TrolleyMakerCardsCubit(context.read<TrolleyMakerRepository>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      trolleyMakerCubit.getCardDetails();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => trolleyMakerCubit,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('title_card'),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: BlocConsumer<TrolleyMakerCardsCubit, TrolleyMakerCardsState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (msg) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(msg)));
                  },
                  success: (cardName, cardList) {
                    setState(() {
                      this.cardName = cardName;
                      this.cardList = cardList;
                    });
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) => state.when(
                initial: () {
                  return Container();
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                success: (cardName, cardList) {
                  return _getCardDetailsWidget();
                },
                error: (message) {
                  return _getErrorScreenWidget(message);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getErrorScreenWidget(String message) {
    return Center(
      child: Text(message, textAlign: TextAlign.center),
    );
  }

  Widget _getCardDetailsWidget() {
    return PageView.builder(
      controller: _pageController,
      itemCount: cardList?.length,
      itemBuilder: (context, index) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(width: 200,
                          "assets/images/card-name-landshut.png",
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: index != 0,
                          child: _getLeftArrow()),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          "assets/images/landshut-card.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: index != ((cardList?.length ?? 1) - 1),
                          child: _getRightArrow()),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getBarCode(cardList?[index]),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }

  _getBarCode(int? cardNumber) {
    var screenWidth = MediaQuery.of(context).size.width;
    var width = screenWidth - 150;
    var height = width * (4 / 10);
    var color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    if (cardNumber != null) {
      return BarcodeWidget(
        textPadding: 10,
        color: color,
        barcode: Barcode.code128(),
        data: cardNumber.toString(),
        width: width,
        height: height,
      );
    } else {
      return const SizedBox();
    }
  }

  _getLeftArrow() {
    return getArrow('assets/images/arrow_previous.svg', () {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  _getRightArrow() {
    return getArrow('assets/images/arrow_next.svg', () {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  Widget getArrow(String assetId, VoidCallback onClick) {
    var color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return GestureDetector(
      onTap: onClick,
      child: SvgPicture.asset(
        assetId,
        height: 24,
        width: 24,
        semanticsLabel: 'previous',
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
