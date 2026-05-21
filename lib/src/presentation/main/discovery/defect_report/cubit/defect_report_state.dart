import 'package:equatable/equatable.dart';

class DefectReportState extends Equatable {
  final bool isSubmitting;
  final String? error;
  final bool isSubmitSuccessful;

  const DefectReportState({
    this.isSubmitting = false,
    this.error,
    this.isSubmitSuccessful = false,
  });

  DefectReportState copyWith({
    bool? isSubmitting,
    String? error,
    bool? isSubmitSuccessful,
  }) {
    return DefectReportState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
      isSubmitSuccessful: isSubmitSuccessful ?? this.isSubmitSuccessful,
    );
  }

  @override
  List<Object?> get props => [isSubmitting, error, isSubmitSuccessful];
}
