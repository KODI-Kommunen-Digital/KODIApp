import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heidi/src/data/model/model_contact_form.dart';
import 'package:loggy/loggy.dart';

import '../../../../../data/remote/api/api.dart';

part 'contact_form_state.dart';

class ContactFormCubit extends Cubit<ContactFormState> {
  ContactFormCubit() : super(ContactFormState.initial());

  Future<bool> submitContactForm({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String message,
  }) async {
    emit(state.copyWith(status: ContactFormStatus.loading)); // Emit loading state
    try {
      final response = await Api.sendContactForm(
          ContactForm( // Potential typo: enquiery. Should it be enquiry?
              firstname: firstName,
              lastname: lastName,
              email: email,
              phone: phone,
              enquiery: message)); 
      if (response.success) {
        emit(state.copyWith(status: ContactFormStatus.success));
        return true;
      } else {
        emit(state.copyWith(status: ContactFormStatus.error,errorMessage: response.message));
        logError('Submit Contact Form Failed', response.message);
        return false;
      }
    } catch (e, stackTrace) {
      emit(state.copyWith(status: ContactFormStatus.error, errorMessage: e.toString()));
      logError('Error submitting contact form: $e', e, stackTrace);
      return false;
    }
  }

  void resetState(){
    emit(ContactFormState.initial());
  }
}
