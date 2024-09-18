// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heidi/src/data/model/model_seller_request.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_requests_view/cubit/seller_requests_view_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_requests_view/cubit/seller_requests_view_state.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:html/dom.dart' as dom;

class SellerRequestsViewScreen extends StatefulWidget {
  final StoreModel? store;
  final bool isOwner;

  const SellerRequestsViewScreen({super.key, this.isOwner = false, this.store});

  @override
  State<SellerRequestsViewScreen> createState() =>
      _SellerRequestsViewScreenState();
}

class _SellerRequestsViewScreenState extends State<SellerRequestsViewScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SellerRequestsViewCubit>().isOwner = widget.isOwner;
    context.read<SellerRequestsViewCubit>().store = widget.store;
    context.read<SellerRequestsViewCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerRequestsViewCubit, SellerRequestsViewState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const SellerRequestsViewLoading(),
            loaded: (requests) => SellerRequestsViewLoaded(
                  sellerRequests: requests,
                  isOwner: widget.isOwner,
                ),
            orElse: () => ErrorWidget("Failed to load requests.")));
  }
}

class SellerRequestsViewLoaded extends StatefulWidget {
  final List<SellerRequestModel> sellerRequests;
  final bool isOwner;

  const SellerRequestsViewLoaded(
      {super.key, required this.sellerRequests, required this.isOwner});

  @override
  State<SellerRequestsViewLoaded> createState() =>
      _SellerRequestsViewLoadedState();
}

class _SellerRequestsViewLoadedState extends State<SellerRequestsViewLoaded> {
  final ScrollController _scrollController = ScrollController();
  List<SellerRequestModel> requests = [];
  bool isLoadingMore = false;
  int pageNo = 1;

  Future _scrollListener() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        setState(() {
          isLoadingMore = true;
        });
        final newRequests =
            await context.read<SellerRequestsViewCubit>().newOrders(++pageNo);
        setState(() {
          requests.addAll(newRequests);
          isLoadingMore = false;
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
    requests.addAll(widget.sellerRequests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate('requests_seller')),
          centerTitle: true,
        ),
        body: (requests.isNotEmpty)
            ? ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index < requests.length) {
                    SellerRequestModel request = requests[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.sellerRequestDetailsScreen,
                              arguments: {
                                'request': request,
                                'isOwner': widget.isOwner
                              }).then((approved) {
                            if (approved != null && approved == true) {
                              context
                                  .read<SellerRequestsViewCubit>()
                                  .onLoad(false);
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
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Text(
                                          dom.DocumentFragment.html(request.title).text ?? request.title,
                                          maxLines: 2,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Html(
                                          data: request.description,
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                Translate.of(context)
                                                    .translate('owes'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                            Text("${request.paymentOwed ?? 0}€",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Translate.of(context)
                                                  .translate('request_seller'),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              request.id.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Translate.of(context)
                                                  .translate('maccount'),
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              "${request.user?.firstname ?? ''} ${request.user?.lastname ?? ''}",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
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

class SellerRequestsViewLoading extends StatelessWidget {
  const SellerRequestsViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
