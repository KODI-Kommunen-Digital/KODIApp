part of 'waste_calendar_cubit.dart';

abstract class WasteCalendarState extends Equatable {
  const WasteCalendarState();
  @override
  List<Object> get props => [];
}

class WasteCalendarLoading extends WasteCalendarState {}

class WasteCalendarLoaded extends WasteCalendarState {
  final List<WasteCollection> collections;
  final List<WasteCollection> carouselCollections;

  const WasteCalendarLoaded(this.collections, this.carouselCollections);

  @override
  List<Object> get props => [collections, carouselCollections];
}

class WasteCalendarError extends WasteCalendarState {
  final String error;

  const WasteCalendarError(this.error);

  @override
  List<Object> get props => [error];
}
