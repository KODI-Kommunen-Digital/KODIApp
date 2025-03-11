import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:heidi/src/data/remote/api/api.dart';
import 'package:heidi/src/presentation/main/discovery/defect_report/cubit/defect_report_state.dart';
import 'package:http_parser/http_parser.dart';

class DefectReportCubit extends Cubit<DefectReportState> {
  DefectReportCubit() : super(const DefectReportState());

  Future<void> submitReport({
    required String title,
    required String description,
    required File image,
    required String address,
  }) async {
    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      List<String> parts = image.path.split('.');
      String imageExtension = parts.last;
      var formData = FormData.fromMap({
        'title': title,
        'description': description,
        //'language': 'de', // You might want to make this configurable
        'image': await MultipartFile.fromFile(image.path,
            filename: image.path,
            contentType: MediaType('image', imageExtension)),
        'address': address
      });

      final result = await Api.requestReportDefect(formData);

      if (result.success) {
        emit(state.copyWith(
          isSubmitting: false,
          isSubmitSuccessful: true,
        ));
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          error: result.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        error: e.toString(),
      ));
    }
  }
}
