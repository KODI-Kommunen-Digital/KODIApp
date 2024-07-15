// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/cubit/owner_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/cubit/owner_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Translate.of(context).translate('owner'),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<OwnerCubit, OwnerState>(
          builder: (context, state) => state.maybeWhen(
              loading: () => const OwnerLoading(),
              loaded: (stores) => OwnerLoaded(stores: stores),
              orElse: () => ErrorWidget("Failed to load stores."))),
    );
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
          // previousScrollPosition = _scrollController.position.pixels;
        });
        stores = await context.read<OwnerCubit>().newStores(++pageNo);
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
    final memoryCacheManager = DefaultCacheManager();
    return (stores.isNotEmpty)
        ? ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index < stores.length) {
                StoreModel store = stores[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      //Navigate to Store Details
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Stack(
                        children: [
                          Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${Application.picturesURL}admin/News.jpeg',
                                  //TODO change once added in backend
                                  cacheManager: memoryCacheManager,
                                  placeholder: (context, url) {
                                    return AppPlaceholder(
                                      child: Container(
                                        height: 140,
                                        width: 120,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: 120,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return AppPlaceholder(
                                      child: Container(
                                        width: 120,
                                        height: 140,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: const Icon(Icons.error),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      store.description,
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
                    //Edit store
                  },
                  child: ListTile(
                    leading: const Icon(Icons.edit),
                    title: Text(Translate.of(context).translate('edit')),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDeleteConfirmation(context, item);
                  },
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text(Translate.of(context).translate('delete')),
                  ),
                ),
              ]);
        });
  }

  Future<bool> showDeleteConfirmation(
      BuildContext context, StoreModel item) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('delete_Confirmation')),
          content: Text(Translate.of(context)
              .translate('Are_you_sure_you_want_to_delete_this_store?')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              }, // Yes
              child: Text(Translate.of(context).translate('yes')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // No
              child: Text(Translate.of(context).translate('no')),
            ),
          ],
        );
      },
    );
    if (result == true) {
      if (!mounted) return false;
      final deleteResponse = await context.read<OwnerCubit>().deleteStore(item);
      if (deleteResponse) {
        setState(() {
          stores.remove(item);
        });
      }
      return deleteResponse;
    }
    return false;
  }
}

class OwnerLoading extends StatelessWidget {
  const OwnerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
