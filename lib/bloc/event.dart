part of 'bloc.dart';

sealed class ContactsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchContacts extends ContactsEvent {}

class InsertContact extends ContactsEvent {
  final Contact contact;
  InsertContact({required this.contact});
}

class UpdateContact extends ContactsEvent {
  final Contact contact;
  UpdateContact({required this.contact});
}

class DeleteContact extends ContactsEvent {
  final Contact contact;
  DeleteContact({required this.contact});
}
