import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_seller_order.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/order_list_screen.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_page/cubit/seller_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class SellerScreen extends StatefulWidget {
  final UserModel user;

  const SellerScreen({super.key, required this.user});

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
          loaded: (soldOrders) => SellerLoaded(
                soldOrders: soldOrders,
                user: widget.user,
              ),
          orElse: () => ErrorWidget("Failed to load listings.")),
    );
  }
}

class SellerLoaded extends StatefulWidget {
  final List<SellerOrderModel> soldOrders;
  final UserModel user;

  const SellerLoaded({super.key, required this.soldOrders, required this.user});

  @override
  State<SellerLoaded> createState() => _SellerLoadedState();
}

class _SellerLoadedState extends State<SellerLoaded> {
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
        title: Text(Translate.of(context).translate('seller')),
        centerTitle: true,
        actions: [
          AppButton(
            Translate.of(context).translate('requests'),
            type: ButtonType.text,
            onPressed: () {
              Navigator.pushNamed(context, Routes.sellerRequestsViewScreen);
            },
          )
        ],
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
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, Routes.createProductScreen,
              arguments: {'sellerId': widget.user.id});
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
