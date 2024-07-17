import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_order.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'seller_state.dart';

class SellerCubit extends Cubit<SellerState> {
  SellerCubit() : super(const SellerState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const SellerState.loading());
    }
    final List<OrderModel> soldOrders = getDummyData();
    final List<ProductRequestModel> productRequests = [
      ProductRequestModel(
          id: 1,
          title: "title",
          description: "description",
          reqType: 1,
          sellerId: 1,
          shopId: 1,
          productId: 1,
          price: 100,
          count: 1,
          threshold: 1,
          maxCount: 1,
          status: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt"),
      ProductRequestModel(
          id: 2,
          title: "titl12312312e",
          description: "descri123123ption",
          reqType: 1,
          sellerId: 1,
          shopId: 1,
          productId: 1,
          price: 100,
          count: 1,
          threshold: 1,
          maxCount: 1,
          status: 1,
          createdAt: "createdAt",
          updatedAt: "updatedAt",
          deletedAt: "deletedAt")
    ];

    await Future.delayed(const Duration(seconds: 2));
    emit(SellerState.loaded(soldOrders, productRequests));
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
