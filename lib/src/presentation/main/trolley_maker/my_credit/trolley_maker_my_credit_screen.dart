import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_trolley_maker_card_balance_transaction_response.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/my_credit/cubit/trolley_maker_my_credit_cubit.dart';
import 'package:heidi/src/presentation/main/trolley_maker/my_credit/cubit/trolley_maker_my_credit_state.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:intl/intl.dart';

class TrolleyMakerMyCreditScreen extends StatefulWidget {
  const TrolleyMakerMyCreditScreen({super.key});

  @override
  State<TrolleyMakerMyCreditScreen> createState() =>
      _TrolleyMakerMyCreditScreenState();
}

class _TrolleyMakerMyCreditScreenState
    extends State<TrolleyMakerMyCreditScreen> {
  late TrolleyMakerMyCreditCubit trolleyMakerCubit;

  Map<String, CardTransactionData>? _cardList;
  String? _selectedCard;

  Iterable<String>? _cardListKeys;

  @override
  void initState() {
    super.initState();
    trolleyMakerCubit =
        TrolleyMakerMyCreditCubit(context.read<TrolleyMakerRepository>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      trolleyMakerCubit.getCardBalanceAndTransactions();
    });
  }

  @override
  void dispose() {
    // Cleanup logic here
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
            Translate.of(context).translate('card_balance'),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: BlocConsumer<TrolleyMakerMyCreditCubit,
                TrolleyMakerMyCreditState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (msg) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(msg)));
                  },
                  success: (response) {
                    setState(() {
                      setInitialState(response);
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
                success: (response) {
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
    var pageWidth = MediaQuery.of(context).size.width - 32;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          Translate.of(context).translate('card_number'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownMenu<String>(
          initialSelection: _selectedCard,
          width: pageWidth,
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color.fromARGB(255, 60, 59, 59)
                  : const Color.fromARGB(255, 199, 191, 191),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 0)),
          hintText: Translate.of(context).translate('selector_hint'),
          dropdownMenuEntries:
              _cardListKeys?.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList() ??
                  [],
          onSelected: (item) {
            setState(() {
              _selectedCard = item as String;
            });
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCardTile(
                    title: Translate.of(context).translate('credit'),
                    balance:
                        _cardList?[_selectedCard]?.balance.balanceFormattedDE ??
                            ""),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  Translate.of(context).translate('transaction_overview'),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  Translate.of(context).translate('transaction_overview_info'),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _cardList?[_selectedCard]?.transactions.length,
                  itemBuilder: (context, index) {
                    var transactions = _cardList?[_selectedCard]?.transactions;
                    return ListItemWidget(
                      partnerInfo: transactions?[index].partner,
                      comments: transactions?[index].text,
                      date: transactions?[index].dateFormattedDE,
                      balance: transactions?[index].amountFormattedDE,
                      isCredit: ((transactions?[index].amountCent ?? 0) >= 0),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void setInitialState(CardBalanceAndTransactionResponse response) {
    _cardList = response.cards;
    _cardListKeys = response.cards.keys;
    if (response.cards.isNotEmpty) {
      _selectedCard = response.cards.entries.first.key;
    }
  }
}

class MyCardTile extends StatelessWidget {
  final String title;
  final String balance;

  const MyCardTile({super.key, required this.title, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 60, 59, 59)
            : const Color.fromARGB(255, 199, 191, 191),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 100,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    '$balance €',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String? partnerInfo;
  final String? comments;
  final String? date;
  final String? balance;
  final bool isCredit;

  const ListItemWidget({
    super.key,
    required this.partnerInfo,
    required this.comments,
    required this.date,
    required this.balance,
    required this.isCredit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partnerInfo ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 4.0),
                Text(
                  comments ?? "",
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4.0),
                Text(
                  formatDate(date),
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Text(
            '$balance €',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return "";
    }
    try {
      DateFormat inputFormat = DateFormat('dd.MM.yyyy HH:mm:ss');
      DateTime dateTime = inputFormat.parse(dateString);
      DateFormat dateFormat = DateFormat('MMM dd, yyyy hh:mm a');
      return dateFormat.format(dateTime);
    } catch (e) {
      return "";
    }
  }
}
