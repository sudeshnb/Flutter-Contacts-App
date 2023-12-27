import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'event.dart';
part 'state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitial()) {
    on<FetchContacts>(fetch);
    on<InsertContact>(insert);
    on<UpdateContact>(update);
    on<DeleteContact>(delete);
  }

  void fetch(event, emit) async {
    emit(ContactLoading());
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      emit(ContactsError(msg: 'permission Denied'));
    } else {
      final contacts = await FlutterContacts.getContacts();
      emit(ContactLoad(contacts: contacts));
    }
  }

  void insert(InsertContact event, emit) async {
    try {
      // emit(ContactLoading());
      await event.contact.insert();
      // emit(ContactLoad(contacts: state));
      // fetch();
      final contacts = await FlutterContacts.getContacts();
      emit(ContactLoad(contacts: contacts));
    } catch (e) {
      emit(ContactsError(msg: e.toString()));
    }
  }

  void update(UpdateContact event, emit) async {
    await event.contact.update();
    final contacts = await FlutterContacts.getContacts();
    emit(ContactLoad(contacts: contacts));
  }

  void delete(DeleteContact event, emit) async {
    await event.contact.delete();
    final contacts = await FlutterContacts.getContacts();
    emit(ContactLoad(contacts: contacts));
  }
}
