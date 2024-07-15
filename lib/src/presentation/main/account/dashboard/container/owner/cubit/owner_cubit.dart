import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'owner_state.dart';

class OwnerCubit extends Cubit<OwnerState> {
  OwnerCubit() : super(const OwnerState.loading());

  List<StoreModel> stores = [];

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const OwnerState.loading());
    }
    final newStores = await ContainerRepository.loadStoresOwner(1);
    stores.addAll(newStores ?? []);
    await Future.delayed(const Duration(seconds: 2));
    emit(OwnerState.loaded(stores));
  }

  Future<List<StoreModel>> newStores(int pageNo) async {
    final newStores = await ContainerRepository.loadStoresOwner(pageNo);
    stores.addAll(newStores ?? []);
    return stores;
  }

  Future<bool> deleteStore(StoreModel store) async {
    //final success = await ContainerRepository.deleteStore();
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
