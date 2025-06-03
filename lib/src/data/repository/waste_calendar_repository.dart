import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';

class WasteCalendarRepository {
  final Preferences prefs;

  WasteCalendarRepository(this.prefs);

  Future<List<WasteLocation>?> loadWasteCalendarStreets(int cityId) async {
    final response = await Api.requestWasteStreets(cityId);
    if (response.success) {
      final responseData =
          List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return WasteLocation.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load Waste Locations Error', response.message);
    }
    return null;
  }

  static Future<ResultApiModel> loadWastePickup(
      int cityId, String streetId) async {
    final response = await Api.requestWastePickup(cityId, streetId);
    if (response.success) {
      List<Map<String, dynamic>> flattenedData = [];
      response.data.forEach((key, value) {
        if (value is List) {
          flattenedData.addAll(value.map((e) => Map<String, dynamic>.from(e)));
        }
      });

      return ResultApiModel(
        success: response.success,
        data: flattenedData,
        message: response.message,
      );
    } else {
      logError('Load Waste Pickups Error', response.message);
      return ResultApiModel(success: false, message: response.message);
    }
  }

  String getTopicString(int locationId) {
    return "WasteTruck_1_$locationId";
  }

  String getTopicFromHash(String hash) {
    return "WasteTruck_1_$hash";
  }
}
