import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/order_list_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_state.dart';
import 'package:heidi/src/utils/translate.dart';

class SellerOrderScreen extends StatefulWidget {
  final UserModel user;

  const SellerOrderScreen({super.key, required this.user});

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen> {
  @override
  void initState() {
    context.read<SellerCubit>().onLoad(false, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      builder: (context, state) => state.maybeWhen(
          loading: () => const SellerOrdersLoading(),
          loadedOrders: (soldOrders) => SellerOrdersLoaded(
                soldOrders: soldOrders,
                user: widget.user,
              ),
          orElse: () => ErrorWidget("Failed to load listings.")),
    );
  }
}

class SellerOrdersLoaded extends StatefulWidget {
  final List<SellerOrderModel> soldOrders;
  final UserModel user;

  const SellerOrdersLoaded({super.key, required this.soldOrders, required this.user});

  @override
  State<SellerOrdersLoaded> createState() => _SellerLoadedState();
}

class _SellerLoadedState extends State<SellerOrdersLoaded> {
  List<SellerOrderModel> soldOrders = [];
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
        title: Text(Translate.of(context).translate('orders')),
        centerTitle: true,
      ),
      body: OrderListScreen(
          sellerOrders: soldOrders,
          loadMore: (page) async {
            final newOrders = await context.read<SellerCubit>().newOrders(page);
            setState(() {
              soldOrders.addAll(newOrders);
              pageNo++;
            });
          },
          pageNo: pageNo),
    );
  }
}

class SellerOrdersLoading extends StatelessWidget {
  const SellerOrdersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('orders')),
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
