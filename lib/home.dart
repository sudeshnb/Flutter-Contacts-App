import 'package:contact/bloc/bloc.dart';
import 'package:contact/update.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'contact.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const UpdatePage()),
              );
            },
            child: const Text('Add new'),
          ),
        ],
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(builder: (builder, state) {
        if (state is ContactsError) {
          return Center(child: Text(state.msg));
        }

        if (state is ContactLoad) {
          return ListView.builder(
            itemCount: state.contacts.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(state.contacts[i].displayName),
              onTap: () => onTap(state.contacts[i].id, context),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  void onTap(String id, BuildContext context) async {
    await FlutterContacts.getContact(id).then(
      (fullContact) async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ContactPage(fullContact!)),
        );
      },
    );
  }
}
