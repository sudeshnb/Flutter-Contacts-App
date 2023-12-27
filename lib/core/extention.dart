import 'package:flutter_contacts/contact.dart';

class AppExtention {
  static String name(Contact contact) {
    if (contact.name.first.isNotEmpty && contact.name.last.isNotEmpty) {
      return '${contact.name.first[0]} ${contact.name.last[0]}';
    }
    if (contact.name.first.isNotEmpty && contact.name.last.isEmpty) {
      return contact.name.first[0];
    }
    return '';
  }
}
