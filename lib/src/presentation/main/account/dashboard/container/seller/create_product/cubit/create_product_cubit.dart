import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(const CreateProductState.loading());

  Future<void> onLoad(int? cityId, int? storeId, int? categoryId) async {
    emit(const CreateProductState.loading());
    final cityRequestResponse = await Api.requestCities();
    final cities = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    List<StoreModel> stores = [];
    List<CategoryModel> categories = [];
    List<CategoryModel> subCategories = [];

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
        cities, stores, cityId, categories, subCategories));
  }
}
