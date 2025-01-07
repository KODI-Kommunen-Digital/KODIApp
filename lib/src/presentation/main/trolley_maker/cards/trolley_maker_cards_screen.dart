import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heidi/src/presentation/main/trolley_maker/add_card/trolley_maker_add_card_sheet.dart';
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
    trolleyMakerCubit = BlocProvider.of<TrolleyMakerCardsCubit>(context);
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('title_card'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_card),
            onPressed: () {
              _showAddCardDialog(context);
            },
          ),
        ],
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
                addedNewCard: (cardNumber) {
                  setState(() {
                    final List<int> tempCardList = List.from(cardList!)
                      ..add(cardNumber);
                    cardList = tempCardList;
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
              addedNewCard: (cardNumber) {
                return _getCardDetailsWidget();
              },
              error: (message) {
                return _getErrorScreenWidget(message);
              },
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
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;
        var displayWidth =
            (screenWidth < screenHeight) ? screenWidth : screenHeight;
        var cardWidth = displayWidth - 80;

        return SingleChildScrollView(
          child: Center(
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
                    StyledCardName(cardName: cardName),
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
                        Center(
                          child: SizedBox(
                            height: 250,
                            width: cardWidth,
                            child: Image.asset(
                              'assets/images/tro-card.png',
                              fit: BoxFit.contain,
                            ),
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
                const SizedBox(
                  height: 40,
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
          ),
        );
      },
    );
  }

  _getBarCode(int? cardNumber) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var displayWidth =
        (screenWidth < screenHeight) ? screenWidth : screenHeight;
    var width = displayWidth - 150;
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

  void _showAddCardDialog(BuildContext context) {
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return TrolleyMakerAddCardSheet(cardList?.first);
        });
  }
}

class StyledCardName extends StatelessWidget {
  final String? cardName;

  const StyledCardName({super.key, required this.cardName});

  @override
  Widget build(BuildContext context) {
    const suffix = "CARD";
    bool endsWithCard = cardName?.endsWith(suffix) ?? false;
    String? baseText = endsWithCard
        ? cardName?.substring(0, (cardName?.length ?? 0) - suffix.length)
        : cardName;

    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: baseText,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w100, fontSize: 30),
            ),
            if (endsWithCard)
              TextSpan(
                text: suffix,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 30),
              ),
          ],
        ),
      ),
    );
  }
}
