import 'package:bloc/bloc.dart';
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


    emit(OwnerShelvesState.loaded(shelves ?? []));
  }

  Future<List<ShelfModel>> newShelves(int pageNo) async {
    final newShelves = await ContainerRepository.getStoreShelves(
        store.cityId, store.id, pageNo);
    return newShelves ?? [];
  }
}
