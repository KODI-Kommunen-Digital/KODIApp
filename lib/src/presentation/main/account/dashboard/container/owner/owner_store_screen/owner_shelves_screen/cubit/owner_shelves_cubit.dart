import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_shelves_screen/cubit/owner_shelves_state.dart';

class OwnerShelvesCubit extends Cubit<OwnerShelvesState> {
  OwnerShelvesCubit() : super(const OwnerShelvesState.loading());

  late StoreModel store;

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const OwnerShelvesState.loading());
    }
    final shelves =
        await ContainerRepository.getStoreShelves(store.cityId, store.id, 1);

    final categories =
        await ContainerRepository.loadStoreCategories(store.cityId, store.id);

    List<CategoryModel> subCategories = [];
    if(categories != null) {
      for(var category in categories) {
        final subCategory = await ContainerRepository.loadStoreSubCategories(store.cityId, store.id, category.id);
        if(subCategory != null) {
          subCategories.addAll(subCategory);
        }
      }
    }

    emit(OwnerShelvesState.loaded(shelves ?? [], categories ?? [], subCategories));
  }

  Future<List<ShelfModel>> newShelves(int pageNo) async {
    final newShelves = await ContainerRepository.getStoreShelves(
        store.cityId, store.id, pageNo);
    return newShelves ?? [];
  }
}
