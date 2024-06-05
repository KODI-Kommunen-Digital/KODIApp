import 'package:bloc/bloc.dart';
import 'package:heidi/src/data/model/model_contact.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(const ContactState.loading());

  Future<void> onLoad() async {
    emit(const ContactState.loading());
    final List<ContactPerson>? list = await ListRepository.loadContact();
    if (list != null) {
      emit(ContactState.loaded(list));
    } else {
      emit(const ContactState.error("error"));
    }
  }
}
