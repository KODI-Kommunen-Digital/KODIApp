import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/logging/loggy_exp.dart';

class ContainerRepository {
  final Preferences prefs;

  ContainerRepository(this.prefs);

  static Future<List<StoreModel>?> loadStores(int cityId) async {
    final response = await Api.getAllStores(cityId);
    if (response.success) {
      final list = List.from(response.data ?? []).map((item) {
        return StoreModel.fromJson(item);
      }).toList();
      return list;
    } else {
      logError('Error loading stores ${response.message}');
      return null;
    }
  }
}
