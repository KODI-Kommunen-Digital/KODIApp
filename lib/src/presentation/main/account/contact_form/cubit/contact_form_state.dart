part of 'contact_form_cubit.dart';

enum ContactFormStatus { initial, loading, success, error }

class ContactFormState extends Equatable {
  final ContactFormStatus status;
  final String? errorMessage;

  const ContactFormState({
    this.status = ContactFormStatus.initial,
    this.errorMessage,
  });

  factory ContactFormState.initial() {
    return const ContactFormState(status: ContactFormStatus.initial, errorMessage: null);
  }

  ContactFormState copyWith({
    ContactFormStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false, // Flag to explicitly clear errorMessage
  }) {
    return ContactFormState(
      status: status ?? this.status,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}