import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'seller_request_state.dart';

class SellerRequestCubit extends Cubit<SellerRequestState> {
  SellerRequestCubit() : super(const SellerRequestState.loading());

  Future<void> onLoad(int? cityId) async {
    emit(const SellerRequestState.loading());
    final cityRequestResponse = await Api.requestCities();
    final cities = List.from(cityRequestResponse.data ?? []).map((item) {
      return CategoryModel.fromJson(item);
    }).toList();

    List<StoreModel> stores = [];

    if (cityId != null) {
      final list = await ContainerRepository.loadStores(cityId, null);
      if (list != null) {
        stores = list;
      }
    }
    emit(SellerRequestState.loaded(cities, stores, cityId));
  }
}
