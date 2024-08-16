import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_products_screen/cubit/owner_products_cubit.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class ProductRequestScreen extends StatefulWidget {
  final List<ProductRequestModel> requests;

  const ProductRequestScreen({super.key, required this.requests});

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
        final List<ProductRequestModel> newRequests =
            await context.read<OwnerProductsCubit>().newRequests(++pageNo);
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
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.productRequestDetailScreen,
                            arguments: {'request': item}).then((approved) {
                          if (approved != null) {
                            if (approved == true) {
                              setState(() {
                                requests.remove(item);
                              });
                            }
                          }
                        });
                      },
                      child: AppListTitle(
                        title: item.title,
                        subtitle: item.description,
                        trailing: Text("${item.price.toString()}€"),
                        leading: Text((item.sellerId != null)
                            ? item.sellerId.toString()
                            : ''),
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
}
