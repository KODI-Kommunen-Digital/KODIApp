import 'package:flutter/cupertino.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';

import '../model/model.dart';
import '../model/model_waste_type.dart';
import '../remote/api/firebase_api.dart';

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
      // response.data.forEach((key, value) {
      //   if (value is List) {
      //     flattenedData.addAll(value.map((e) => Map<String, dynamic>.from(e)));
      //   }
      // });

      response.data.forEach((key, value) {
        if (value is List) {
          for (final item in value) {
            if (item == null) continue;
            if (item is! Map) continue;

            flattenedData.add(Map<String, dynamic>.from(item));
          }
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
  //
  // String getTopicStringWithLocationId(int locationId) {
  //   return "WasteTruck_1_$locationId";
  // }
  //
  // String getTopicFromHash(String hash) {
  //   return "WasteTruck_1_$hash";
  // }

  Future<List<WasteType>?> loadWasteTypes(int cityId) async {
    final response = await Api.requestWasteTypes(cityId);
    if (response.success) {
      final responseData = List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return WasteType.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load Waste Types Error', response.message);
    }
    return null;
  }

  String getTopicString(int cityId, String hashedStreetName, int wasteTypeId) {
    return "WasteTruck_1_${hashedStreetName}_$wasteTypeId";
  }

  Future<void> updateSubscription({
    required GlobalKey<NavigatorState> navigatorKey,
    required int cityId,
    String? locationId,
    String? locationName,
    String? hashedStreetName,
    int? wasteTypeId,
    List<int>? wasteTypeIds,
  }) async {
    // Get previous values from preferences
    final previousWasteTypes = prefs.getSelectedWasteTypes();
    final previousHashedStreetName = prefs.getKeyValue(
        Preferences.selectedStreetHashedName, null);
    final firebaseApi = FirebaseApi(navigatorKey, prefs);
    final deviceId = prefs.getKeyValue(
        Preferences.deviceId, (await Utils.getDeviceInfo())?.uuid ?? '');

    // Determine new waste types
    List<int> newWasteTypes = [];
    if (wasteTypeIds != null) {
      newWasteTypes = wasteTypeIds;
    } else if (wasteTypeId != null) {
      newWasteTypes = [wasteTypeId];
    } else {
      newWasteTypes = previousWasteTypes;
    }

    if(newWasteTypes.isNotEmpty) {
      final params = {
        "deviceId": deviceId,
        "streetId": locationId ??
            await prefs.getKeyValue(Preferences.selectedLocationId, 1),
        "wasteTypeIds": newWasteTypes
      };

      final response = await Api.subscribeStreetAndWasteTypes(params);
      if (response.success) {
        logInfo('Updated waste types and street', response.message);
      } else {
        logError("Error Updating waste types and street", response.message);
      }
    }

    // Save new values to preferences
    if (locationId != null) {
      await prefs.setKeyValue(Preferences.selectedLocationId, locationId);
    }
    if (locationName != null) {
      await prefs.setKeyValue(Preferences.selectedLocationName, locationName);
    }
    if (hashedStreetName != null) {
      await prefs.setKeyValue(
          Preferences.selectedStreetHashedName, hashedStreetName);
    }
    if (newWasteTypes.isNotEmpty) {
      await prefs.setSelectedWasteTypes(newWasteTypes);
    }

  }

  Future<void> subscribeForWasteNotification(bool isActive) async {
    DeviceModel? deviceModel = await Utils.getDeviceInfo();
    String deviceId = await prefs.getKeyValue(
        Preferences.deviceId, deviceModel != null ? deviceModel.uuid : "");
    final params = {
      "isActive": isActive
    };
    final response =
    await Api.subscribeForWasteNotification(deviceId, params);
    logInfo("Waste calendar notifications subscription updated: ${response.success}");
  }


}
