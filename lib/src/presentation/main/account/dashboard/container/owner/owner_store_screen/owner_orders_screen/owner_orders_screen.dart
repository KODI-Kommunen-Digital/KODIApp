import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/order_list_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_orders_screen/cubit/owner_orders_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_orders_screen/cubit/owner_orders_state.dart';
import 'package:heidi/src/utils/translate.dart';

class OwnerOrdersScreen extends StatefulWidget {
  final StoreModel store;

  const OwnerOrdersScreen({super.key, required this.store});

  @override
  State<OwnerOrdersScreen> createState() => _OwnerOrdersScreenState();
}

class _OwnerOrdersScreenState extends State<OwnerOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OwnerOrdersCubit>().store = widget.store;
    context.read<OwnerOrdersCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerOrdersCubit, OwnerOrdersState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const OwnerOrdersLoading(),
            loaded: (orders) => OwnerOrdersLoaded(orders: orders),
            orElse: () => ErrorWidget("Failed to load orders.")));
  }
}

class OwnerOrdersLoaded extends StatefulWidget {
  final List<OrderModel> orders;

  const OwnerOrdersLoaded({super.key, required this.orders});

  @override
  State<OwnerOrdersLoaded> createState() => _OwnerOrdersLoadedState();
}

class _OwnerOrdersLoadedState extends State<OwnerOrdersLoaded> {
  List<OrderModel> orders = [];
  int pageNo = 1;

  @override
  void initState() {
    super.initState();
    orders.addAll(widget.orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('orders')),
        centerTitle: true,
      ),
      body: OrderListScreen(
          orders: orders,
          loadMore: (page) async {
            final newOrders =
                await context.read<OwnerOrdersCubit>().newOrders(page);
            setState(() {
              orders.addAll(newOrders);
              pageNo++;
            });
          },
          pageNo: pageNo),
    );
  }
}

class OwnerOrdersLoading extends StatelessWidget {
  const OwnerOrdersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
