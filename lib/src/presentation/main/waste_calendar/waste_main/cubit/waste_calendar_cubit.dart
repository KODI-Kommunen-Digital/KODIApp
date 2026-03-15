import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_waste.dart';
import 'package:heidi/src/data/repository/waste_calendar_repository.dart';

import '../../../../../utils/configs/preferences.dart';

part 'waste_calendar_state.dart';

class WasteCalendarCubit extends Cubit<WasteCalendarState> {
  WasteCalendarCubit() : super(WasteCalendarLoading());

  void loadWasteCollections(
      int cityId,
      String? streetId, {
        List<int>? selectedWasteTypeIds,
      }) async {
    if (selectedWasteTypeIds != null && selectedWasteTypeIds.isEmpty) {
      // emit(const WasteCalendarError("No waste types selected"));
      emit(const WasteCalendarLoaded(
        [],
        [],
      ));
      return;
    }
    try {
      final result =
      await WasteCalendarRepository.loadWastePickup(cityId, streetId!, selectedWasteTypeIds!);

      if (isClosed) return;

      if (result.success) {
        final data = result.data as List<dynamic>;

        final DateTime now = DateTime.now();
        final DateTime today = DateTime(now.year, now.month, now.day);
        final DateTime twoWeeksFromNow = today.add(const Duration(days: 14));

        List<WasteCollection> wasteCollections = [];
        List<WasteCollection> carouselCollections = [];

        for (var item in data) {
          final collection = WasteCollection.fromJson(item);
          wasteCollections.add(collection);

          final DateTime collectionDate = DateTime(
            collection.date.year,
            collection.date.month,
            collection.date.day,
          );

          if (collectionDate.isAtSameMomentAs(today) ||
              (collectionDate.isAfter(today) &&
                  collectionDate.isBefore(twoWeeksFromNow))) {
            carouselCollections.add(collection);
          }
        }

        if (!isClosed) {
          emit(WasteCalendarLoaded(
            wasteCollections,
            carouselCollections,
          ));
        }
      } else {
        if (!isClosed) {
          emit(WasteCalendarError(
              "Failed to load waste collections: ${result.message}"));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(WasteCalendarError(
            "Failed to load waste collections: ${e.toString()}"));
      }
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
