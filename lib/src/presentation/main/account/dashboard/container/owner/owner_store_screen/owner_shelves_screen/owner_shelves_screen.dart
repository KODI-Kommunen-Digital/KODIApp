// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_shelves_screen/cubit/owner_shelves_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_shelves_screen/cubit/owner_shelves_state.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class OwnerShelvesScreen extends StatefulWidget {
  final StoreModel store;

  const OwnerShelvesScreen({super.key, required this.store});

  @override
  State<OwnerShelvesScreen> createState() => _OwnerShelvesScreenState();
}

class _OwnerShelvesScreenState extends State<OwnerShelvesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OwnerShelvesCubit>().store = widget.store;
    context.read<OwnerShelvesCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerShelvesCubit, OwnerShelvesState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const OwnerShelvesLoading(),
            loaded: (shelves) => OwnerShelvesLoaded(
                  shelves: shelves,
                  store: widget.store,
                ),
            orElse: () => ErrorWidget("Failed to load listings.")));
  }
}

class OwnerShelvesLoaded extends StatefulWidget {
  final List<ShelfModel> shelves;
  final StoreModel store;

  const OwnerShelvesLoaded(
      {super.key, required this.shelves, required this.store});

  @override
  State<OwnerShelvesLoaded> createState() => _OwnerShelvesLoadedState();
}

class _OwnerShelvesLoadedState extends State<OwnerShelvesLoaded> {
  List<ShelfModel> shelves = [];
  final ScrollController _scrollController = ScrollController();
  int pageNo = 1;
  bool isLoadingMore = false;

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        final newShelves =
            await context.read<OwnerShelvesCubit>().newShelves(++pageNo);
        shelves.addAll(newShelves);
        if (newShelves.isEmpty) {
          _scrollController.removeListener(_scrollListener);
        }
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    shelves.addAll(widget.shelves);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate('shelves')),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, Routes.addShelfScreen,
                arguments: {'store': widget.store}).then((success) {
              if (success != null && success == true) {
                context.read<OwnerShelvesCubit>().onLoad(false);
              }
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: (shelves.isNotEmpty)
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                controller: _scrollController,
                itemBuilder: (context, int index) {
                  if (index < shelves.length) {
                    ShelfModel item = shelves[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.shelfDetailScreen,
                              arguments: {
                                'shelf': item,
                              }).then((success) {
                            if (success != null && success == true) {
                              context.read<OwnerShelvesCubit>().onLoad(false);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Stack(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          item.title ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                            item.description ??
                                                item.description ??
                                                '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!),
                                        if (item.productName != null)
                                          const SizedBox(height: 4),
                                        if (item.productName != null)
                                          Text(
                                            "${Translate.of(context).translate('product')}: ${item.productName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.formatDate(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return (isLoadingMore)
                        ? const Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          )
                        : Container();
                  }
                },
                itemCount: shelves.length + 1,
              )
            : Center(
                child: Row(
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
              ));
  }
}

class OwnerShelvesLoading extends StatelessWidget {
  const OwnerShelvesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
