import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model_contact.dart';

part 'contact_state.freezed.dart';

@freezed
class ContactState with _$ContactState {
  const factory ContactState.initial() = ContactStateInitial;

  const factory ContactState.loading() = ContactStateLoading;

  const factory ContactState.loaded(List<ContactPerson> list) =
      ContactStateLoaded;

  const factory ContactState.error(String error) = ContactStateError;
}
