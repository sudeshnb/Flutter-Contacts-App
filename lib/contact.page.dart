import 'package:contact/bloc/bloc.dart';
import 'package:contact/core/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'update.page.dart';

class ContactPage extends StatelessWidget {
  final Contact contact;
  const ContactPage(this.contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => UpdatePage(contact: contact)),
              );
            },
            child: const Text('Edit'),
          ),
        ],
      ),
      body: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ListView(
            children: [
              _profileCircleAvatar(),
              SizedBox(height: 20.h),
              _displayName(),
              SizedBox(height: 20.h),
              ...contact.phones.map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.label.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(e.number),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              if (contact.emails.isNotEmpty)
                Text(
                  'Email address:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ...contact.emails.map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.label.name,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(e.address)
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              TextButton(
                onPressed: () {
                  context
                      .read<ContactsBloc>()
                      .add(DeleteContact(contact: contact));
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center _displayName() {
    return Center(
      child: Text(
        contact.displayName,
        maxLines: 1,
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  CircleAvatar _profileCircleAvatar() {
    return CircleAvatar(
      radius: 80.sp,
      child: Text(
        AppExtention.name(contact),
        style: TextStyle(
          fontSize: 58.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
