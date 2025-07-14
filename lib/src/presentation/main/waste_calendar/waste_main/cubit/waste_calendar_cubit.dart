import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_waste.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';

part 'waste_calendar_state.dart';

class WasteCalendarCubit extends Cubit<WasteCalendarState> {
  WasteCalendarCubit() : super(WasteCalendarLoading());

  void loadWasteCollections(int cityId, String? streetId, {List<int>? selectedWasteTypeIds}) async {
    try {
      final result =
          await WasteCalendarRepository.loadWastePickup(cityId, streetId!);
      if (result.success) {
        final data = result.data as List<dynamic>;

        // Normalize 'now' and 'twoWeeksFromNow' to have the time set to 00:00:00
        final DateTime now = DateTime.now();
        final DateTime today = DateTime(now.year, now.month, now.day);
        final DateTime twoWeeksFromNow = today.add(const Duration(days: 14));

        List<WasteCollection> wasteCollections = [];
        List<WasteCollection> carouselCollections = [];

        for (var item in data) {
          final collection = WasteCollection.fromJson(item);
          if ((collection.type.contains("wöchentlich")) ||
              collection.type.contains("14")) {
            //continue;
          }
          wasteCollections.add(collection);
          final DateTime collectionDate = DateTime(
              collection.date.year, collection.date.month, collection.date.day);
          if (collectionDate.isAtSameMomentAs(today) ||
              (collectionDate.isAfter(today) &&
                  collectionDate.isBefore(twoWeeksFromNow))) {
            carouselCollections.add(collection);
          }
        }
        emit(WasteCalendarLoaded(wasteCollections, carouselCollections));
      } else {
        emit(WasteCalendarError(
            "Failed to load waste collections: ${result.message}"));
      }
    } catch (e) {
      emit(WasteCalendarError(
          "Failed to load waste collections: ${e.toString()}"));
    }
  }

  void updateStreetId(String newStreetId, {List<int>? selectedWasteTypeIds}) {
    loadWasteCollections(1, newStreetId, selectedWasteTypeIds: selectedWasteTypeIds);
  }

  Color getColorForType(String type) {
    switch (type) {
      case 'Restmüll 14-tägig':
      case 'Restmüll 4-wöchentlich':
      case 'Restmüllcontainer wöchentlich':
      case 'Restmüllcontainer 14-tägig':
        return Colors.grey;

      case 'Biotonne':
        return Colors.green;

      case 'Blaue Tonne':
        return Colors.blue;

      case 'Gelbe Tonne':
        return Colors.yellow;

      default:
        return Colors.white;
    }
  }
}

extension DateTimeExtension on DateTime {
  String monthName() {
    const months = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember'
    ];
    return months[month - 1];
  }

  String weekdayName() {
    const weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag'
    ];
    return weekdays[weekday - 1];
  }
}
