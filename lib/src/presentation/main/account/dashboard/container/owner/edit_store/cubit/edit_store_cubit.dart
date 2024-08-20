import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/edit_store/cubit/edit_store_state.dart';

class EditStoreCubit extends Cubit<EditStoreState> {
  EditStoreCubit() : super(const EditStoreState.loading());

  late int cityId;
  late int storeId;

  Future<void> onLoad() async {
    emit(const EditStoreState.loading());
    final store = await ContainerRepository.loadStore(cityId, storeId);
    if (store != null) {
      emit(EditStoreState.loaded(store));
    } else {
      emit(const EditStoreState.error('store_not_found'));
    }
  }

  Future<bool> updateStore(
      {required String name,
      String? longitude,
      String? latitude,
      String? address,
      String? description}) async {
    bool success = await ContainerRepository.updateStore(
        cityId: cityId,
        storeId: storeId,
        name: name,
        address: address,
        description: description,
        longitude: longitude,
        latitude: latitude);

    if (success) {
      emit(const EditStoreState.success());
      return true;
    }
    emit(const EditStoreState.error('error_message'));
    return false;
  }
}
