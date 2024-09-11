import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';

import 'owner_category_state.dart';

class OwnerCategoryCubit extends Cubit<OwnerCategoryState> {
  OwnerCategoryCubit() : super(const OwnerCategoryState.loading());

  int? categoryId;

  Future<void> onLoadCategories() async {
    emit(const OwnerCategoryState.loading());
    final categories = await ContainerRepository.loadCategoriesGlobal(1);
    emit(OwnerCategoryState.loaded(categories ?? [], false));
  }

  Future<void> onLoadSubCategories() async {
    emit(const OwnerCategoryState.loading());
    final categories =
        await ContainerRepository.loadSubCategoriesGlobal(categoryId!, 1);
    emit(OwnerCategoryState.loaded(categories ?? [], true));
  }

  Future<List<CategoryModel>> newCategories(int pageNo) async {
    final newCategories =
        await ContainerRepository.loadCategoriesGlobal(pageNo);
    return newCategories ?? [];
  }

  Future<List<CategoryModel>> newSubCategories(int pageNo) async {
    final newSubCategories =
        await ContainerRepository.loadSubCategoriesGlobal(categoryId!, pageNo);
    return newSubCategories ?? [];
  }

  Future<ResultApiModel> addCategoryToStore(int storeId, int categoryId) async {
    final response = await ContainerRepository.addCategoryToStore(storeId, categoryId);
    return response;
  }

  Future<ResultApiModel> removeCategoryFromStore(int storeId, int categoryId) async {
    final response = await ContainerRepository.removeCategoryFromStore(storeId, categoryId);
    return response;
  }

  Future<ResultApiModel> addSubCategoryToStore(int storeId, int categoryId) async {
    final response = await ContainerRepository.addSubCategoryToStore(storeId, categoryId);
    return response;
  }

  Future<ResultApiModel> removeSubCategoryFromStore(int storeId, int categoryId) async {
    final response = await ContainerRepository.removeSubCategoryFromStore(storeId, categoryId);
    return response;
  }

  Future<bool?> doesStoreHaveCategory(StoreModel store) async {
    final bool? response = await ContainerRepository.doesStoreHaveCategory(store.cityId, store.id, categoryId!);
    return response;
  }
}
