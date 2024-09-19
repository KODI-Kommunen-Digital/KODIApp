import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/cubit/app_bloc.dart';
import 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(const CreateProductState.loading());

  File? selectedImage;
  File? downloadedImage;
  bool isImageChanged = false;

  Future<void> onLoad(
      {int? cityId,
      int? storeId,
      int? categoryId,
      ContainerProductModel? product,
      StoreModel? selectedStore,
      CategoryModel? selectedCategory,
      CategoryModel? selectedSubCategory}) async {
    emit(const CreateProductState.loading());
    final cityRequestResponse = await Api.requestCities();
    final cities = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    List<StoreModel> stores = [];
    List<CategoryModel> categories = [];
    List<CategoryModel> subCategories = [];

    Map<String, dynamic>? productDetails;
    if (product != null) {
      productDetails = await getProductDetails(product);
      selectedCategory = productDetails?['category'];
      selectedSubCategory = productDetails?['subCategory'];
      cityId = product.cityId;
      storeId = product.shopId;
      categoryId = product.categoryId;
    }

    if (cityId != null) {
      final list = await ContainerRepository.loadStores(cityId, null);
      if (list != null) {
        stores = list;
      }
      if (storeId != null) {
        final categoryResponse =
            await ContainerRepository.loadStoreCategories(cityId, storeId);
        categories = categoryResponse ?? [];
        if (categoryId != null) {
          final subCategoryResponse =
              await ContainerRepository.loadStoreSubCategories(
                  cityId, storeId, categoryId);
          subCategories = subCategoryResponse ?? [];
        }
      }
    }
    emit(CreateProductState.loaded(
        cities,
        stores,
        cityId,
        categories,
        subCategories,
        productDetails,
        selectedStore,
        selectedCategory,
        selectedSubCategory));
  }

  Future<Map<String, dynamic>?> getProductDetails(
      ContainerProductModel product) async {
    final cityRequestResponse = await Api.requestCities();
    final cities = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    final selectedCity = AppBloc.homeCubit.getCityName(cities, product.cityId);
    final category = await ContainerRepository.loadStoreCategory(
        product.cityId, product.shopId, product.categoryId);
    final subcategory = await ContainerRepository.loadStoreSubCategory(
        product.cityId, product.shopId, product.subCategoryId);
    final shop =
        await ContainerRepository.loadStore(product.cityId, product.shopId);
    if (category == null || subcategory == null || shop == null) {
      emit(const CreateProductState.error());
      return null;
    }
    return {
      'cityName': selectedCity,
      'category': category,
      'subcategory': subcategory,
      'store': shop
    };
  }

  void clearImages() {
    selectedImage = null;
    downloadedImage = null;
    isImageChanged = false;
  }
}
