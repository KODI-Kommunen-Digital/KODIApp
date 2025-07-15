import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_result_api.dart';
import 'package:heidi/src/data/model/model_waste_location.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/data/remote/api/firebase_api.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:loggy/loggy.dart';

class WasteCalendarRepository {
  final Preferences prefs;

  WasteCalendarRepository(this.prefs);

  Future<List<WasteLocation>?> loadWasteCalendarStreets(int cityId) async {
    final response = await Api.requestWasteStreets(cityId);
    if (response.success) {
      final responseData = List<Map<String, dynamic>>.from(response.data ?? []).map((item) {
        return WasteLocation.fromJson(item);
      }).toList();

      return responseData;
    } else {
      logError('Load Waste Locations Error', response.message);
    }
    return null;
  }

  static Future<ResultApiModel> loadWastePickup(int cityId, String streetId) async {
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
    final previousHashedStreetName = prefs.getKeyValue(Preferences.selectedStreetHashedName, null);
    final firebaseApi = FirebaseApi(navigatorKey, prefs);

    // Determine new waste types
    List<int> newWasteTypes = [];
    if (wasteTypeIds != null) {
      newWasteTypes = wasteTypeIds;
    } else if (wasteTypeId != null) {
      newWasteTypes = [wasteTypeId];
    } else {
      newWasteTypes = previousWasteTypes;
    }

    // If location has changed, we need to unsubscribe from all previous topics
    final isLocationChanged = hashedStreetName != null && hashedStreetName != previousHashedStreetName;
    if (isLocationChanged && previousHashedStreetName != null && previousWasteTypes.isNotEmpty) {
      for (int previousType in previousWasteTypes) {
        final previousTopic = getTopicString(cityId, previousHashedStreetName, previousType);
        await firebaseApi.unsubscribeFromTopic(previousTopic);
        logInfo('Unsubscribed from topic due to location change: $previousTopic');
      }
    } else if (!isLocationChanged && previousHashedStreetName != null) {
      // Location hasn't changed, only unsubscribe from types that are no longer selected
      final typesToUnsubscribe = previousWasteTypes.where((type) => !newWasteTypes.contains(type));
      for (int type in typesToUnsubscribe) {
        final topic = getTopicString(cityId, previousHashedStreetName, type);
        await firebaseApi.unsubscribeFromTopic(topic);
        logInfo('Unsubscribed from removed waste type: $topic');
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
      await prefs.setKeyValue(Preferences.selectedStreetHashedName, hashedStreetName);
    }
    if (newWasteTypes.isNotEmpty) {
      await prefs.setSelectedWasteTypes(newWasteTypes);
    }

    // Subscribe to new topics
    final currentHashedStreetName = hashedStreetName ?? previousHashedStreetName;
    if (currentHashedStreetName != null && newWasteTypes.isNotEmpty) {
      for (int newType in newWasteTypes) {
        final newTopic = getTopicString(cityId, currentHashedStreetName, newType);
        // Only subscribe if this is a new type or location changed
        if (isLocationChanged || !previousWasteTypes.contains(newType)) {
          await firebaseApi.subscribeToTopic(newTopic);
          logInfo('Subscribed to new topic: $newTopic');
        } else {
          logInfo('Keeping existing subscription for topic: $newTopic');
        }
      }
    }
  }
}
