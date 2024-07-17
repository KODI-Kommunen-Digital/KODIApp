import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(const CustomerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const CustomerState.loading());
    }
    final List<OrderModel> soldOrders = getDummyData();

    await Future.delayed(const Duration(seconds: 2));
    emit(CustomerState.loaded(soldOrders));
  }

  List<OrderModel> getDummyData() {
    return [
      OrderModel(
          id: 1,
          shopId: 1,
          amount: 100,
          products: 5,
          shelves: [
            ShelfModel(
                id: 1,
                shopId: 1,
                productId: 1,
                createdAt: "createdAt",
                updatedAt: "updatedAt",
                deletedAt: "deletedAt",
                title: "title",
                description: "description",
                product: ContainerProductModel(
                    id: 1,
                    cityId: 1,
                    createdAt: "createdAt",
                    updatedAt: "updatedAt",
                    deletedAt: "deletedAt",
                    title: "title",
                    description: "description",
                    price: 1123,
                    tax: 0.1,
                    inventory: 231,
                    minCount: 1,
                    maxCount: 12,
                    sellerId: 1,
                    shopId: 1,
                    categoryId: 1,
                    subCategoryId: 1,
                    meta: "meta",
                    isActive: true,
                    isArchived: false,
                    deletedBy: null,
                    productImages: []))
          ],
          cartId: 1,
          userId: 1,
          paymentId: 12341,
          discount: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt",
          cartItems: {"cartItems": 50}),
      OrderModel(
          id: 1,
          shopId: 1,
          amount: 100,
          products: 5,
          shelves: [
            ShelfModel(
                id: 1,
                shopId: 1,
                productId: 1,
                createdAt: "createdAt",
                updatedAt: "updatedAt",
                deletedAt: "deletedAt",
                title: "title",
                description: "description",
                product: ContainerProductModel(
                    id: 1,
                    cityId: 1,
                    createdAt: "createdAt",
                    updatedAt: "updatedAt",
                    deletedAt: "deletedAt",
                    title: "title",
                    description: "description",
                    price: 1123,
                    tax: 0.1,
                    inventory: 231,
                    minCount: 1,
                    maxCount: 12,
                    sellerId: 1,
                    shopId: 1,
                    categoryId: 1,
                    subCategoryId: 1,
                    meta: "meta",
                    isActive: true,
                    isArchived: false,
                    deletedBy: null,
                    productImages: []))
          ],
          cartId: 1,
          userId: 1,
          paymentId: 12341,
          discount: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt",
          cartItems: {"cartItems": 50}),
    ];
  }

  Future<List<OrderModel>> newOrders(int pageNo) async {
    return [];
  }
}
