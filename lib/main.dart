import 'package:contact/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/bloc.dart';
import 'core/keyboard.dart';
import 'cubit/cubit.dart';

Future<void> main() async {
  //  This is the main app
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactsBloc()..add(FetchContacts()),
        ),
        BlocProvider(create: (context) => FullContactCubit()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, ch) {
            return const DismissKeyboard(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Contacts App",
                home: HomePage(),
              ),
            );
          }),
    );
  }
}
