import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

part 'state.dart';

class FullContactCubit extends Cubit<FullContactState> {
  FullContactCubit() : super(const FullContactState());

  void getContact(String id) async {
    final fullContact = await FlutterContacts.getContact(id);
    emit(FullContactState(contact: fullContact));
  }
}
