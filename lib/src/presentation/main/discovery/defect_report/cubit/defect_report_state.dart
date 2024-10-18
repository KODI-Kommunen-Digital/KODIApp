import 'package:equatable/equatable.dart';

class DefectReportState extends Equatable {
  final bool isSubmitting;
  final String? error;

  const DefectReportState({
    this.isSubmitting = false,
    this.error,
  });

  DefectReportState copyWith({
    bool? isSubmitting,
    bool? isSubmitted,
    String? reportId,
    String? error,
  }) {
    return DefectReportState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isSubmitting, error];
}
