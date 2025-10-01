import 'package:equatable/equatable.dart';
import 'package:heidi/src/presentation/main/services/model/services_response_model.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object?> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final List<ServiceResponseModel>? services;

  const ServicesLoaded({
    required this.services,
  });
}

class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message);
}
