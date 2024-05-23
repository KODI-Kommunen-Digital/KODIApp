part of 'waste_calendar_cubit.dart';

abstract class WasteCalendarState extends Equatable {
  const WasteCalendarState();

  @override
  List<Object> get props => [];
}

class WasteCalendarLoading extends WasteCalendarState {}

class WasteCalendarLoaded extends WasteCalendarState {
  final List<WasteCollection> collections;

  const WasteCalendarLoaded(this.collections);

  @override
  List<Object> get props => [collections];
}

class WasteCalendarError extends WasteCalendarState {
  final String error;

  const WasteCalendarError(this.error);

  @override
  List<Object> get props => [error];
}
