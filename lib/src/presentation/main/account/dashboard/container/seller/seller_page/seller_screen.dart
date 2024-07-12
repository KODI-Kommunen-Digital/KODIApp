import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  void initState() {
    context.read<SellerCubit>().onLoad(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      builder: (context, state) => state.maybeWhen(
          loading: () => const SellerLoading(),
          loaded: (soldOrders, productRequests) => SellerLoaded(
                soldOrders: soldOrders,
                productRequests: productRequests,
              ),
          orElse: () => ErrorWidget("Failed to load listings.")),
    );
  }
}

class SellerLoaded extends StatefulWidget {
  final List<OrderModel> soldOrders;
  final List<ProductRequestModel> productRequests;

  const SellerLoaded(
      {super.key, required this.soldOrders, required this.productRequests});

  @override
  State<SellerLoaded> createState() => _SellerLoadedState();
}

class _SellerLoadedState extends State<SellerLoaded> {
  final ScrollController _scrollController = ScrollController();

  List<OrderModel> soldOrders = [];
  bool isLoadingMore = false;
  int pageNo = 1;

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    soldOrders.addAll(widget.soldOrders);
    _scrollController.addListener(_scrollListener);
  }

  Future _onRefreshLoader() async {
    await context.read<SellerCubit>().onLoad(true);
  }

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
          //previousScrollPosition = _scrollController.position.pixels;
        });
        soldOrders = await context.read<SellerCubit>().newOrders(++pageNo);

        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('seller')),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                //Navigate to Product Request page
              },
              icon: const Icon(Icons.forum))
        ],
      ),
      body: Stack(
        children: [
          (soldOrders.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 4, 0),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    controller: _scrollController,
                    slivers: <Widget>[
                      CupertinoSliverRefreshControl(
                        onRefresh: _onRefreshLoader,
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          if (index < soldOrders.length) {
                            final item = soldOrders[index];
                            //TODO dummy data, get first orderProduct
                            final firstProduct = ProductModel(
                                id: 1,
                                title: "",
                                image: "",
                                expiryDate: "",
                                startDate: "",
                                endDate: "",
                                createDate: "",
                                favorite: false,
                                address: "",
                                phone: "",
                                email: "",
                                website: "",
                                externalId: "",
                                description: "",
                                userId: 1);
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: InkWell(
                                onTap: () {
                                  //Navigate to Order Details
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Stack(
                                    children: [
                                      Row(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              imageUrl: (firstProduct
                                                      .image.isNotEmpty)
                                                  ? '${Application.picturesURL}${firstProduct.image}'
                                                  : '${Application.picturesURL}admin/News.jpeg',
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
                                              errorWidget:
                                                  (context, url, error) {
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                                Text(
                                                  item.amount.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  item.id.toString(),
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  item.createdAt ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                const SizedBox(height: 4),
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
                            (isLoadingMore)
                                ? const Positioned(
                                    bottom: 20,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  )
                                : Container();
                          }
                          return null;
                        }, childCount: soldOrders.length + 1),
                      ),
                    ],
                  ),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          //add product screen
        },
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SellerLoading extends StatelessWidget {
  const SellerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('seller')),
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
