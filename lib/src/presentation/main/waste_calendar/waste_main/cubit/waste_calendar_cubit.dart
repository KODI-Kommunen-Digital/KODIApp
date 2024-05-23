import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'waste_calendar_state.dart';

class WasteCollection {
  final DateTime date;
  final String type;

  WasteCollection({required this.date, required this.type});
}

class WasteCalendarCubit extends Cubit<WasteCalendarState> {
  WasteCalendarCubit() : super(WasteCalendarLoading());

  void loadWasteCollections() {
    // Dummy data for waste collections
    final wasteCollections = [
      WasteCollection(date: DateTime(2024, 5, 22), type: 'Restmüll'),
      WasteCollection(date: DateTime(2024, 5, 25), type: 'Gelbe Tonne'),
      WasteCollection(date: DateTime(2024, 5, 28), type: 'Biotonne'),
      WasteCollection(date: DateTime(2024, 5, 28), type: 'Restmüll'),
      WasteCollection(date: DateTime(2024, 5, 31), type: 'Restmüll'),
      WasteCollection(date: DateTime(2024, 6, 2), type: 'Gelbe Tonne'),
      WasteCollection(date: DateTime(2024, 6, 5), type: 'Biotonne'),
      WasteCollection(date: DateTime(2024, 6, 7), type: 'Restmüll'),
      WasteCollection(date: DateTime(2024, 6, 10), type: 'Gelbe Tonne'),
      WasteCollection(date: DateTime(2024, 6, 12), type: 'Biotonne'),
    ];

    emit(WasteCalendarLoaded(wasteCollections));
  }
}
