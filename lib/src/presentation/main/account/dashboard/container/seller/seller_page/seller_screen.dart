import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/order_view_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_state.dart';
import 'package:heidi/src/utils/configs/routes.dart';
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
  List<OrderModel> soldOrders = [];
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    soldOrders.addAll(widget.soldOrders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('seller')),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.productRequestScreen,
                    arguments: {'requests': widget.productRequests});
              },
              icon: const Icon(Icons.forum))
        ],
      ),
      body: OrderViewScreen(
          orders: soldOrders,
          loadMore: (page) async {
            final newOrders = await context.read<SellerCubit>().newOrders(page);
            setState(() {
              soldOrders.addAll(newOrders);
              pageNo++;
            });
          },
          pageNo: pageNo),
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
