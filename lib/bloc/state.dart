part of 'bloc.dart';

sealed class ContactsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class ContactsInitial extends ContactsState {}

final class ContactsError extends ContactsState {
  final String msg;
  ContactsError({required this.msg});
  @override
  List<Object> get props => [msg];
}

final class ContactLoad extends ContactsState {
  final List<Contact> contacts;
  ContactLoad({required this.contacts});
  @override
  List<Object> get props => [contacts];
}

final class ContactLoading extends ContactsState {}
