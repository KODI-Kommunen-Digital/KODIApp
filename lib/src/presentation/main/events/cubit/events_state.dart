import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_product.dart';

part 'events_state.freezed.dart';

@freezed
class EventsState with _$EventsState {
  const factory EventsState.initial() = EventsStateInitial;

  const factory EventsState.loading() = EventsStateLoading;

  const factory EventsState.loaded(
      List<ProductModel> events) = EventsStateLoaded;

  const factory EventsState.updated(
      List<ProductModel> events) = EventsStateUpdated;

  const factory EventsState.error(String msg) = EventsStateError;
}
