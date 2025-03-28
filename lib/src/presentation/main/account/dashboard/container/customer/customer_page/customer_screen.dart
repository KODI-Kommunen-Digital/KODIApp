import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/customer/customer_page/cubit/customer_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/customer/customer_page/cubit/customer_state.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/order_list_screen.dart';
import 'package:heidi/src/utils/translate.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    context.read<CustomerCubit>().onLoad(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) => state.maybeWhen(
          loading: () => const CustomerLoading(),
          loaded: (orders) => CustomerLoaded(
                orders: orders,
              ),
          orElse: () => ErrorWidget("Failed to load listings.")),
    );
  }
}

class CustomerLoaded extends StatefulWidget {
  final List<OrderModel> orders;

  const CustomerLoaded({super.key, required this.orders});

  @override
  State<CustomerLoaded> createState() => _CustomerLoadedState();
}

class _CustomerLoadedState extends State<CustomerLoaded> {
  List<OrderModel> orders = [];
  int pageNo = 2;
  bool finishedLoading = false;

  @override
  void initState() {
    super.initState();
    orders.addAll(widget.orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('customer')),
        centerTitle: true,
      ),
      body: OrderListScreen(
          orders: orders,
          loadMore: (page) async {
            final newOrders =
                await context.read<CustomerCubit>().newOrders(page);
            if (newOrders.isEmpty) {
              finishedLoading = true;
            }
            setState(() {
              orders.addAll(newOrders);
              pageNo++;
            });
          },
          finishedLoading: finishedLoading,
          pageNo: pageNo),
    );
  }
}

class CustomerLoading extends StatelessWidget {
  const CustomerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('customer')),
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
