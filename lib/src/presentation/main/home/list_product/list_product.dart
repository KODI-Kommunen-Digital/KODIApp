// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:async';
import 'package:custom_in_app_webview/custom_in_app_webview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/widget/app_navbar.dart';
import 'package:heidi/src/presentation/widget/app_product_item.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

import '../../../../utils/custom_cache_manager.dart';
import 'cubit/cubit.dart';

class ListProductScreen extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const ListProductScreen({super.key, required this.arguments});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  int pageNo = 1;
  int? categoryId;
  String? searchTerm;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    categoryId = widget.arguments['id'];
    searchTerm = widget.arguments['search'];
    loadListingsList();
  }

  Future<void> loadListingsList() async {
    if (searchTerm != null) {
      await context.read<ListCubit>().searchListing(content: searchTerm,newSearch: true,isGlobalSearch: true);
    } else {
      await context.read<ListCubit>().onLoad(categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: widget.arguments['title'] != ''
              ? Text(widget.arguments['title'])
              : FutureBuilder<String?>(
                  future: context.read<ListCubit>().getCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      return Container();
                    } else {
                      String category = snapshot.data!;
                      return Text(Translate.of(context).translate(category));
                    }
                  }),
          actions: [
            Visibility(
              visible: searchTerm == null,
              child: IconButton(
                  onPressed: () {
                    _searchListings();
                  },
                  icon: const Icon(Icons.search)),
            )
          ],
        ),
        body: BlocConsumer<ListCubit, ListState>(
          listener: (context, state) {
            state.maybeWhen(
              error: (msg) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(msg))),
              orElse: () {},
            );
          },
          builder: (context, state) => state.when(
            loading: () => const ListLoading(),
            loaded: (list,newsList) => ListLoaded(
              list: list,
              selectedId: categoryId ?? 0,
              isGlobalSearch: widget.arguments['search']!=null,
            ),
            updated: (list,newsLoaded) {
              return ListLoaded(
                list: list,
                updated: true,
                selectedId: categoryId ?? 0,
                isGlobalSearch: widget.arguments['search']!=null,
              );
            },
            error: (e) => ErrorWidget('Failed to load listings.'),
            initial: () {
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Future _searchListings() async {
    String? searchResult = await openSearchDialog();
    if (searchResult is String && searchResult.trim() != "") {
      context.read<ListCubit>().searchListing(content:searchResult.trim(),newSearch:true,listingStatus: 1);
    } else if ((searchResult == null || searchResult.trim() == "") &&
        context.read<ListCubit>().isSearching) {
      context.read<ListCubit>().cancelSearch(categoryId ?? 0);
    }
  }

  Future<String?> openSearchDialog() async {
    String? searchRequest = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            if (didPop) return;
            Navigator.pop(context, context.read<ListCubit>().searchTerm);
          },
          child: SimpleDialog(
              title: Center(
                  child: Text(Translate.of(context).translate('search_title'))),
              contentPadding: const EdgeInsets.all(24.0),
              children: [
                AppTextInput(
                  hintText: Translate.of(context).translate('search_title'),
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                  //focusNode: _focusPass,
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        Navigator.pop(context, null);
                      },
                      child: Text(Translate.of(context).translate('cancel')),
                    ),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {
                        String content = _searchController.text;
                        Navigator.pop(context, content);
                      },
                      child: Text(
                        Translate.of(context).translate('search_title'),
                      ),
                    ),
                  ],
                ),
              ]),
        );
      },
    );
    return searchRequest;
  }
}

class ListLoading extends StatelessWidget {
  const ListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class ListLoaded extends StatefulWidget {
  final List<ProductModel> list;
  final int selectedId;
  final bool updated;
  final bool isGlobalSearch;

  const ListLoaded({
    super.key,
    required this.list,
    required this.selectedId,
    this.updated = false,
    this.isGlobalSearch = false,
  });

  @override
  State<ListLoaded> createState() => _ListLoadedState();
}

class _ListLoadedState extends State<ListLoaded> {
  // Use the widget.list directly to avoid accidental long-lived copies
  List<ProductModel> get _items => widget.list;

  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  int pageNo = 1;

  Timer? _debounceClearTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // If new data must be loaded initially (keeps behavior)
    if (!widget.updated) {
      // loadListingsList() already exists in parent; if needed call from parent
      // but we keep behavior similar to your previous code (no action here).
    }
  }

  @override
  void dispose() {

    _debounceClearTimer?.cancel();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    // Debounce: when user stops scrolling, call cleanup
    _debounceClearTimer?.cancel();
    _debounceClearTimer = Timer(const Duration(milliseconds: 300), () {
      // Trigger disk cleanup if needed
      CustomCacheManager().clearIfExceedsLimit();
    });

    // Detect end of scroll for pagination
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.atEdge && pos.pixels != 0 && !isLoadingMore) {
      // We're at bottom
      setState(() {
        isLoadingMore = true;
      });

      try {
        if (context.read<ListCubit>().isSearching) {
          // keep same behavior as before
          await context.read<ListCubit>().searchListing(
            content: context.read<ListCubit>().searchTerm,
            newSearch: false,
            isGlobalSearch: widget.isGlobalSearch,
            listingStatus: widget.isGlobalSearch ? 1 : null,
          );
        } else {
          // load next page
          final newItems =
          await context.read<ListCubit>().newListings(++pageNo, widget.selectedId);

        }
      } catch (e) {
        // handle/log if needed
      } finally {
        if (mounted) {
          setState(() {
            isLoadingMore = false;
          });
        }
      }
    }
  }

  void _onProductDetail(ProductModel item) {
    if (item.sourceId == 2 || item.showExternal == 1) {
      String link = item.website;
      if (!link.startsWith('http')) link = 'https://$link';
      CustomInAppWebView.showAsBottomSheet(context: context, url: link);
    } else {
      Navigator.pushNamed(context, Routes.productDetail, arguments: item);
    }
  }

  Widget _buildItem({required ProductModel item}) {
    // RepaintBoundary prevents the whole screen from repainting when this item changes.
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, top: 5),
        child: AppProductItem(
          isRefreshLoader: true,
          onPressed: () => _onProductDetail(item),
          item: item,
          type: Application.setting.listMode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use BlocBuilder to listen to data changes
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        // If empty show placeholder
        if (_items.isEmpty) {
          return SafeArea(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.sentiment_satisfied),
                  const SizedBox(width: 4),
                  Text(
                    Translate.of(context).translate('list_is_empty'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }

        // Main scrollable content
        return SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        // Safety: ensure index within range
                        if (index < 0 || index >= _items.length) return const SizedBox.shrink();
                        final item = _items[index];
                        return _buildItem(item: item);
                      },
                      childCount: _items.length,
                      addAutomaticKeepAlives: false, // important: allow disposal
                      addRepaintBoundaries: true,
                      addSemanticIndexes: false,
                    ),
                  ),
                  // Optional small spacer at end
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              ),

              // Loading indicator for pagination
              if (isLoadingMore)
                const Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                ),
            ],
          ),
        );
      },
    );
  }
}
