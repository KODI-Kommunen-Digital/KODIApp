// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_category_screen/cubit/owner_category_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_category_screen/cubit/owner_category_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class OwnerCategoryScreen extends StatefulWidget {
  final List<StoreModel> stores;

  const OwnerCategoryScreen({super.key, required this.stores});

  @override
  State<OwnerCategoryScreen> createState() => _OwnerCategoryScreenState();
}

class _OwnerCategoryScreenState extends State<OwnerCategoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OwnerCategoryCubit>().onLoadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerCategoryCubit, OwnerCategoryState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const OwnerCategoryLoading(),
            loaded: (categories, isSubCategory) => OwnerCategoryLoaded(
                  isSubCategory: isSubCategory,
                  categories: categories,
                  stores: widget.stores,
                ),
            orElse: () => ErrorWidget("Failed to load listings.")));
  }
}

class OwnerCategoryLoaded extends StatefulWidget {
  final bool isSubCategory;
  final List<CategoryModel> categories;
  final List<StoreModel> stores;

  const OwnerCategoryLoaded(
      {super.key,
      required this.isSubCategory,
      required this.categories,
      required this.stores});

  @override
  State<OwnerCategoryLoaded> createState() => _OwnerCategoryLoadedState();
}

class _OwnerCategoryLoadedState extends State<OwnerCategoryLoaded> {
  final ScrollController _scrollController = ScrollController();
  List<CategoryModel> categories = [];
  int? selectedStore;

  bool isLoadingMore = false;
  int pageNo = 1;

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        late List<CategoryModel> newCategories;
        if (widget.isSubCategory) {
          newCategories = await context
              .read<OwnerCategoryCubit>()
              .newSubCategories(++pageNo);
        } else {
          newCategories =
              await context.read<OwnerCategoryCubit>().newCategories(++pageNo);
        }
        categories.addAll(newCategories);
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    categories.addAll(widget.categories);
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
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate(
              (widget.isSubCategory) ? 'all_subCategories' : 'all_Categories')),
          centerTitle: true,
        ),
        body: PopScope(
          canPop: !widget.isSubCategory,
          onPopInvokedWithResult: (pop, result) async {
            pageNo = 1;
            context.read<OwnerCategoryCubit>().categoryId = null;
            context.read<OwnerCategoryCubit>().onLoadCategories();
          },
          child: Column(
            children: [
              Expanded(
                child: (categories.isNotEmpty)
                    ? ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, int index) {
                          if (index < categories.length) {
                            CategoryModel category = categories[index];
                            return InkWell(
                              onTap: () {
                                if (!widget.isSubCategory) {
                                  pageNo = 1;
                                  context
                                      .read<OwnerCategoryCubit>()
                                      .categoryId = category.id;
                                  context
                                      .read<OwnerCategoryCubit>()
                                      .onLoadSubCategories();
                                }
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: (category.image != '')
                                                ? category.image
                                                : '${Application.picturesURL}admin/eatOrDrink.jpeg',
                                            cacheManager: memoryCacheManager,
                                            placeholder: (context, url) {
                                              return AppPlaceholder(
                                                child: Container(
                                                  height: 140,
                                                  width: 120,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            },
                                            imageBuilder:
                                                (context, imageProvider) {
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child:
                                                      const Icon(Icons.error),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                category.title,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                category.description ?? '',
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              _openActionPopUp(category);
                                            },
                                            icon: const Icon(Icons.more_vert))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return (isLoadingMore)
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  )
                                : Container();
                          }
                        },
                        itemCount: categories.length + 1,
                      )
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.sentiment_satisfied),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                Translate.of(context)
                                    .translate('list_is_empty'),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ));
  }

  void _openActionPopUp(CategoryModel item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            title: Center(
              child: Text(Translate.of(context).translate('manage_category'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {},
                child: DropdownButtonFormField<int>(
                  value: selectedStore,
                  onChanged: (newStore) {
                    if (newStore != null) {
                      setState(() {
                        selectedStore = newStore;
                      });
                    }
                  },
                  items: widget.stores.map((StoreModel store) {
                    return DropdownMenuItem<int>(
                      value: store.id,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        child: Text(store.name,
                            style: const TextStyle(fontSize: 16)),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    labelText: (widget.stores.isEmpty)
                        ? Translate.of(context).translate('no_stores')
                        : Translate.of(context)
                            .translate('choose_store_category'),
                    labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (widget.isSubCategory) {
                    addSubCategoryToStore(item);
                  } else {
                    addCategoryToStore(item);
                  }
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: const Icon(Icons.link),
                  title: Text(Translate.of(context).translate('add_to_store')),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (widget.isSubCategory) {
                    removeSubCategoryFromStore(item);
                  } else {
                    removeCategoryFromStore(item);
                  }
                  Navigator.of(context).pop();
                },
                child: ListTile(
                  leading: const Icon(Icons.link_off),
                  title: Text(
                      Translate.of(context).translate('remove_from_store')),
                ),
              ),
            ]);
      },
    );
  }

  Future<void> addCategoryToStore(CategoryModel item) async {
    late String message;
    if (selectedStore != null) {
      final response = await context
          .read<OwnerCategoryCubit>()
          .addCategoryToStore(selectedStore!, item.id);
      if (response.success) {
        message = 'category_added_successfully';
      } else {
        if (response.message.contains('already')) {
          message = 'category_already_added';
        } else {
          message = 'error_message';
        }
      }
    } else {
      message = 'choose_store_category';
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Translate.of(context).translate(message))));
  }

  Future<void> removeCategoryFromStore(CategoryModel item) async {
    late String message;
    if (selectedStore != null) {
      final response = await context
          .read<OwnerCategoryCubit>()
          .removeCategoryFromStore(selectedStore!, item.id);
      if (response.success) {
        message = 'category_removed_successfully';
      } else {
        if (response.message.contains('not found')) {
          message = 'category_already_removed';
        } else {
          message = 'error_message';
        }
      }
    } else {
      message = 'choose_store_category';
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Translate.of(context).translate(message))));
  }

  Future<void> addSubCategoryToStore(CategoryModel item) async {
    late String message;
    if (selectedStore != null) {
      final StoreModel store =
          widget.stores.firstWhere((store) => store.id == selectedStore!);
      final hasCategory =
          await context.read<OwnerCategoryCubit>().doesStoreHaveCategory(store);

      if (hasCategory != null) {
        if (hasCategory) {
          final response = await context
              .read<OwnerCategoryCubit>()
              .addSubCategoryToStore(selectedStore!, item.id);
          if (response.success) {
            message = 'subcategory_added_successfully';
          } else {
            if (response.message.contains('already')) {
              message = 'subcategory_already_added';
            } else {
              message = 'error_message';
            }
          }
        } else {
          message = 'category_missing_subcategory';
        }
      } else {
        message = 'error_message';
      }
    } else {
      message = 'choose_store_category';
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Translate.of(context).translate(message))));
  }

  Future<void> removeSubCategoryFromStore(CategoryModel item) async {
    late String message;
    if (selectedStore != null) {
      final StoreModel store =
          widget.stores.firstWhere((store) => store.id == selectedStore!);
      final hasCategory =
          await context.read<OwnerCategoryCubit>().doesStoreHaveCategory(store);

      if (hasCategory != null) {
        if (hasCategory) {
          final response = await context
              .read<OwnerCategoryCubit>()
              .removeSubCategoryFromStore(selectedStore!, item.id);
          if (response.success) {
            message = 'subcategory_removed_successfully';
          } else {
            if (response.message.contains('not found') || response.message.contains('not added')) {
              message = 'subcategory_already_removed';
            } else {
              message = 'error_message';
            }
          }
        } else {
          message = 'category_missing_subcategory';
        }
      } else {
        message = 'error_message';
      }
    } else {
      message = 'choose_store_category';
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(Translate.of(context).translate(message))));
  }
}

class OwnerCategoryLoading extends StatelessWidget {
  const OwnerCategoryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
