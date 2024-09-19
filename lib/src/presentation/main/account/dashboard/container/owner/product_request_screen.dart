// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_products_screen/cubit/owner_products_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_cubit.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:html/dom.dart' as dom;

class ProductRequestScreen extends StatefulWidget {
  final bool isOwner;
  final List<ProductRequestModel> requests;

  const ProductRequestScreen(
      {super.key, required this.requests, required this.isOwner});

  @override
  State<ProductRequestScreen> createState() => _ProductRequestScreenState();
}

class _ProductRequestScreenState extends State<ProductRequestScreen> {
  final ScrollController _scrollController = ScrollController();

  List<ProductRequestModel> requests = [];

  bool isLoadingMore = false;
  int pageNo = 1;

  Future<void> _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        late List<ProductRequestModel> newRequests;
        if (widget.isOwner) {
          newRequests =
              await context.read<OwnerProductsCubit>().newRequests(++pageNo);
        } else {
          newRequests = await context.read<SellerCubit>().newRequests(++pageNo);
        }
        requests.addAll(newRequests);
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
    requests.addAll(widget.requests);
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
          title: Text(Translate.of(context).translate('product_request')),
          centerTitle: true,
        ),
        body: (requests.isNotEmpty)
            ? ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index < requests.length) {
                    ProductRequestModel item = requests[index];
                    return InkWell(
                      onTap: () async {
                        navigateToDetail(item);
                      },
                      child: AppListTitle(
                        title: dom.DocumentFragment.html(item.title).text ?? '',
                        subtitle:
                            dom.DocumentFragment.html(item.description).text ??
                                '',
                        trailing: Text("${item.price.toString()}€"),
                      ),
                    );
                  } else {
                    return (isLoadingMore)
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Container();
                  }
                },
                itemCount: requests.length + 1,
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

  void navigateToDetail(ProductRequestModel item) async {
    List<ShelfModel>? shelves;
    if (widget.isOwner) {
      shelves = await context.read<OwnerProductsCubit>().getShelves();
    }
    await Navigator.pushNamed(context, Routes.productRequestDetailScreen,
        arguments: {
          'request': item,
          'shelves': shelves,
          'isOwner': widget.isOwner
        }).then((approvedOrDeleted) {
      if (approvedOrDeleted != null) {
        if (approvedOrDeleted == true) {
          setState(() {
            requests.remove(item);
          });
        }
      }
    });
  }
}
