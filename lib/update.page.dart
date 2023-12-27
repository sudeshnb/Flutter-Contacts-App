import 'package:contact/bloc/bloc.dart';
import 'package:contact/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdatePage extends StatefulWidget {
  final Contact? contact;
  const UpdatePage({super.key, this.contact});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  void initState() {
    if (!mounted) return;
    setupData();
    super.initState();
  }

  setupData() {
    if (widget.contact != null) {
      firstname.text = widget.contact!.name.first;
      lastname.text = widget.contact!.name.last;
      phone.text = widget.contact!.phones.first.number;
      email.text = widget.contact!.emails.first.address;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: update,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            CircleAvatar(radius: 80.sp),
            SizedBox(height: 40.h),
            TextField(
              controller: firstname,
              decoration: const InputDecoration(hintText: 'First name'),
            ),
            TextField(
              controller: lastname,
              decoration: const InputDecoration(hintText: 'Last name'),
            ),
            TextField(
              controller: phone,
              decoration: const InputDecoration(hintText: 'Phone number'),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: 'Email address'),
            ),
          ],
        ),
      ),
    );
  }

  void update() {
    if (widget.contact != null) {
      final newContact = widget.contact!
        ..name.first = firstname.text
        ..name.last = lastname.text
        ..phones = [Phone(phone.text)]
        ..emails = [Email(email.text)];
      context.read<ContactsBloc>().add(UpdateContact(contact: newContact));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()), (v) => false);
    } else {
      final newContact = Contact()
        ..name.first = firstname.text
        ..name.last = lastname.text
        ..phones = [Phone(phone.text)]
        ..emails = [Email(email.text)];
      context.read<ContactsBloc>().add(InsertContact(contact: newContact));
      Navigator.pop(context);
    }
  }
}
