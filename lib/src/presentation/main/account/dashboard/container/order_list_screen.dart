import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class OrderListScreen extends StatefulWidget {
  final List<OrderModel> orders;
  final int pageNo;
  final Function(int) loadMore;

  const OrderListScreen(
      {super.key,
      required this.orders,
      required this.loadMore,
      required this.pageNo});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
          widget.loadMore(widget.pageNo);
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    return (widget.orders.isNotEmpty)
        ? ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              if (index < widget.orders.length) {
                OrderModel item = widget.orders[index];
                final firstProduct = item.shelves.first.product;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.orderDetailsScreen,
                          arguments: {'order': item});
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
                                  imageUrl: ((firstProduct.productImages ?? [])
                                          .isNotEmpty)
                                      ? '${Application.picturesURL}${firstProduct.productImages!.first}'
                                      : '${Application.picturesURL}admin/News.jpeg',
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
                                      item.amount.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
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
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.createdAt ?? '',
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
            itemCount: widget.orders.length + 1,
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
}
