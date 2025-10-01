import 'package:bloc/bloc.dart';
import 'package:heidi/src/presentation/main/services/model/services_response_model.dart';
import 'package:heidi/src/presentation/main/services/view/services_event.dart';
import 'package:heidi/src/presentation/main/services/view/services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial()) {
    on<LoadServicesData>(_onLoadServicesData);
  }

  Future<void> _onLoadServicesData(
    LoadServicesData event,
    Emitter<ServicesState> emit,
  ) async {
    emit(ServicesLoading());
    emit(ServicesLoaded(services: services));
    // emit(ServicesError("Not able to load services. Please try again later."));
  }
}
