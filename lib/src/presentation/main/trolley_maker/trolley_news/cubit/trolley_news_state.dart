import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_trolley_news.dart';

part 'trolley_news_state.freezed.dart';

@freezed
class TrolleyNewsState with _$TrolleyNewsState {
  const factory TrolleyNewsState.loading() = Loading;
  const factory TrolleyNewsState.loaded(List<TrolleyNews>? news) = Loaded;
  const factory TrolleyNewsState.error(String message) = Error;
}
