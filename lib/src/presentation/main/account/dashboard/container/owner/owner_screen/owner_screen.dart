// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_screen/cubit/owner_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_screen/cubit/owner_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class OwnerScreen extends StatefulWidget {
  const OwnerScreen({super.key});

  @override
  State<OwnerScreen> createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OwnerCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerCubit, OwnerState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const OwnerLoading(),
            loaded: (stores) => OwnerLoaded(stores: stores),
            orElse: () => ErrorWidget("Failed to load stores.")));
  }
}

class OwnerLoaded extends StatefulWidget {
  final List<StoreModel> stores;

  const OwnerLoaded({super.key, required this.stores});

  @override
  State<OwnerLoaded> createState() => _OwnerLoadedState();
}

class _OwnerLoadedState extends State<OwnerLoaded> {
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  List<StoreModel> stores = [];
  int pageNo = 1;

  Future<void> _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        final newStores = await context.read<OwnerCubit>().newStores(++pageNo);
        stores.addAll(newStores);
        if (newStores.isEmpty) {
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
    _scrollController.addListener(_scrollListener);
    stores.addAll(widget.stores);
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
        title: Text(
          Translate.of(context).translate('owner'),
        ),
        centerTitle: true,
        actions: [
          AppButton(Translate.of(context).translate('categories'),
              type: ButtonType.text, onPressed: () {
            Navigator.pushNamed(context, Routes.ownerCategoryScreen,
                arguments: {'stores': widget.stores});
          })
        ],
      ),
      body: (stores.isNotEmpty)
          ? ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: (context, index) {
                if (index < stores.length) {
                  StoreModel store = stores[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.storeDetailScreen,
                            arguments: {'store': store});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Stack(
                          children: [
                            Row(
                              children: <Widget>[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Text(
                                        store.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        store.description ?? '',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        store.address ?? '',
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
                                      const SizedBox(height: 8),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _openStoreActionPopUp(store);
                                    },
                                    icon: const Icon(Icons.more_vert))
                              ],
                            ),
                          ],
                        ),
                      ),
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
              itemCount: stores.length + 1,
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
            ),
    );
  }

  void _openStoreActionPopUp(StoreModel item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Center(
                child: Text(Translate.of(context).translate('options'),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                    editStore(item);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.edit),
                    title: Text(Translate.of(context).translate('edit')),
                  ),
                ),
              ]);
        });
  }

  void editStore(StoreModel item) async {
    await Navigator.pushNamed(context, Routes.editStoreScreen,
        arguments: {'storeId': item.id, 'cityId': item.cityId});
    context.read<OwnerCubit>().onLoad(false);
  }
}

class OwnerLoading extends StatelessWidget {
  const OwnerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
