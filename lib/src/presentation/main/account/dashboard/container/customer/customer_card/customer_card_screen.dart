import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_container_card.dart';
import 'package:heidi/src/data/model/model_container_transaction.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/customer/customer_card/cubit/customer_card_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/customer/customer_card/cubit/customer_card_state.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class CustomerCardScreen extends StatefulWidget {
  const CustomerCardScreen({super.key});

  @override
  State<CustomerCardScreen> createState() => _CustomerCardScreenState();
}

class _CustomerCardScreenState extends State<CustomerCardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CustomerCardCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('transactions')),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.addCustomerCardScreen);
              },
              icon: const Icon(Icons.add_card))
        ],
      ),
      body: BlocBuilder<CustomerCardCubit, CustomerCardState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const CustomerCardLoading(),
            loaded: (cards, transactions) => CustomerCardLoaded(
                  cards: cards,
                  transactions: transactions,
                ),
            orElse: () => ErrorWidget("Failed to load listings.")),
      ),
    );
  }
}

class CustomerCardLoaded extends StatefulWidget {
  final List<ContainerCardModel> cards;
  final List<ContainerTransactionModel>? transactions;

  const CustomerCardLoaded({super.key, required this.cards, this.transactions});

  @override
  State<CustomerCardLoaded> createState() => _CustomerCardLoadedState();
}

class _CustomerCardLoadedState extends State<CustomerCardLoaded> {
  final ScrollController _scrollController = ScrollController();
  List<ContainerTransactionModel>? transactions;
  int pageNo = 1;
  bool isLoadingMore = false;

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        int? card = context.read<CustomerCardCubit>().selectedCard;
        if (transactions != null && card != null) {
          setState(() {
            isLoadingMore = true;
          });
          final List<ContainerTransactionModel> newTransactions = await context
              .read<CustomerCardCubit>()
              .loadMoreTransactions(card, ++pageNo);
          transactions!.addAll(newTransactions);
          setState(() {
            isLoadingMore = false;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    transactions = widget.transactions;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButtonFormField<int>(
            value: context.read<CustomerCardCubit>().selectedCard,
            onChanged: (newCard) {
              if (newCard != null) {
                context.read<CustomerCardCubit>().selectedCard = newCard;
                context.read<CustomerCardCubit>().loadTransactions(newCard);
              }
            },
            items: widget.cards.map((ContainerCardModel card) {
              return DropdownMenuItem<int>(
                value: card.id,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 10.0),
                  child: Text(card.id.toString(),
                      style: const TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: (widget.cards.isEmpty)
                  ? Translate.of(context).translate('no_cards')
                  : Translate.of(context).translate('select_card'),
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white,
              ),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          if (transactions != null)
            (transactions!.isNotEmpty)
                ? Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        if (index < transactions!.length) {
                          ContainerTransactionModel transaction =
                              transactions![index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      transaction.id.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Column(
                                      children: [
                                        Text(
                                          '${Translate.of(context).translate('card')}: ${transaction.cardId}',
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${Translate.of(context).translate('quantity')}: ${transaction.amount}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        if (transaction.createdAt != null)
                                          const SizedBox(height: 4),
                                        if (transaction.createdAt != null)
                                          Text(
                                            transaction.createdAt!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return (isLoadingMore)
                              ? const Positioned(
                                  bottom: 20,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                )
                              : Container();
                        }
                      },
                      itemCount: transactions!.length + 1,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.sentiment_satisfied),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          Translate.of(context).translate('list_is_empty'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
        ],
      ),
    );
  }
}

class CustomerCardLoading extends StatelessWidget {
  const CustomerCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
