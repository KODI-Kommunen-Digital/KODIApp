import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/owner_store_screen/owner_shelves_screen/cubit/owner_shelves_state.dart';

class OwnerShelvesCubit extends Cubit<OwnerShelvesState> {
  OwnerShelvesCubit() : super(const OwnerShelvesState.loading());

  Future<void> onLoad(bool isRefreshLoader) async {
    if (!isRefreshLoader) {
      emit(const OwnerShelvesState.loading());
    }
    //final shelves = await ContainerRepository.;
    emit(const OwnerShelvesState.loaded([]));
  }

  Future<List<ShelfModel>> newShelves(int pageNo) async {
  //final newShelves = await ContainerRepository.;
  return [];
  }
}
