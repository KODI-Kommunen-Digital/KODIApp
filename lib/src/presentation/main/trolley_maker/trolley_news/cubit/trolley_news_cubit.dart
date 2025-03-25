import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:heidi/src/data/model/model_trolley_news.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/trolley_news/cubit/trolley_news_state.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class TrolleyNewsCubit extends Cubit<TrolleyNewsState> {
  final TrolleyMakerRepository repository;

  TrolleyNewsCubit(this.repository) : super(const TrolleyNewsState.loading());

  Future<void> onLoad() async {
    emit(const TrolleyNewsState.loading());
    try {
      var result = await repository.getNewsList();
      result.fold((error) => {emit(TrolleyNewsState.error(error.errorMessage))},
              (responseModel) {
            emit(TrolleyNewsState.loaded(responseModel));
          });
    } catch (error) {
      emit(const TrolleyNewsState.error(
          "Etwas ist schiefgegangen. Bitte versuchen Sie es später erneut."));
    }
  }

  Future<Either<TrolleyNews?, String?>> getTrolleyNewsDetails(int newsId) async {
    try {
      var result = await repository.getTrolleyNewsDetails(newsId);
      dynamic value = result.fold((error) => null,
              (responseModel) {
            return responseModel;
          });
      if(value is TrolleyNews?) {
        return Left(value);
      }
    } catch (error) {
      return Right(error as String?);
    }
    return const Left(null);
  }

  String trimHtml(String htmlContent, {int maxChars = 200}) {
    final document = parse(htmlContent);
    final buffer = StringBuffer();
    int currentLength = 0;
    bool reachedLimit = false;

    void traverse(Node node) {
      if (reachedLimit) return;

      if (node is Text) {
        final text = node.text;
        final remaining = maxChars - currentLength;

        if (text.length <= remaining) {
          buffer.write(text);
          currentLength += text.length;
        } else {
          buffer.write(text.substring(0, remaining));
          currentLength += remaining;
          reachedLimit = true;
        }
      } else if (node is Element) {
        buffer.write('<${node.localName}');
        node.attributes.forEach((key, value) {
          buffer.write(' $key="${value.replaceAll('"', '&quot;')}"');
        });
        buffer.write('>');

        for (final child in node.nodes) {
          traverse(child);
          if (reachedLimit) break;
        }

        buffer.write('</${node.localName}>');
      }
    }

    for (final node in document.body!.nodes) {
      traverse(node);
      if (reachedLimit) break;
    }

    final trimmedHtmlRaw = buffer.toString();
    final plainText = document.body!.text.trim();
    final wasTrimmed = plainText.length > maxChars;

    if (!wasTrimmed) {
      return htmlContent;
    }

    final trimmedHtml = trimmedHtmlRaw.replaceAll(RegExp(r'\s+(?=</\w+>$)'), '');

    final match = RegExp(r'(</\w+>)\s*$').firstMatch(trimmedHtml);
    if (match != null) {
      final insertIndex = match.start;
      return '${trimmedHtml.substring(0, insertIndex)}[...]${trimmedHtml.substring(insertIndex)}';
    }

    return '$trimmedHtml[...]';
  }
}
