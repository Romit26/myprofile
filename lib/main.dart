import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprofile/core/bloc/logged_user_info/logged_user_info_bloc.dart';
import 'package:myprofile/core/bloc/login_bloc/login_bloc.dart';
import 'package:myprofile/core/bloc/logout_user/logout_user_bloc.dart';
import 'package:myprofile/core/bloc/profile_info/profile_information_bloc.dart';
import 'package:myprofile/core/bloc/update_profile/update_profile_bloc.dart';
import 'package:myprofile/core/bloc/user_info/userinfo_bloc.dart';
import 'package:myprofile/core/constant/color_constant.dart';
import 'package:myprofile/core/repository/preference_repository.dart';
import 'package:myprofile/view/ui/splashscreen/splashscreen.dart';

///this key use for navigation
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => PreferenceRepository(),
          )
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(
                    preferenceRepository: context.read<PreferenceRepository>()),
              ),
              BlocProvider<UserinfoBloc>(
                create: (context) => UserinfoBloc(
                    preferenceRepository: context.read<PreferenceRepository>()),
              ),
              BlocProvider<LoggedUserInfoBloc>(
                create: (context) => LoggedUserInfoBloc(
                    preferenceRepository: context.read<PreferenceRepository>()),
              ),
              BlocProvider<ProfileInformationBloc>(
                create: (context) => ProfileInformationBloc(
                    preferenceRepository: context.read<PreferenceRepository>()),
              ),
              BlocProvider<UpdateProfileBloc>(
                create: (context) => UpdateProfileBloc(
                    preferenceRepository: context.read<PreferenceRepository>()),
              ),
              BlocProvider<LogoutUserBloc>(
                create: (context) => LogoutUserBloc(
                    preferenceRepository: context.read<PreferenceRepository>()),
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'My Profile',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                checkboxTheme: CheckboxThemeData(
                    visualDensity: const VisualDensity(horizontal: -3),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: const BorderSide(color: Colors.black, width: 2),
                    fillColor: MaterialStateProperty.all(primarySwatchColor)),
                primarySwatch: Colors.blue,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                useMaterial3: true,
              ),
              home: const SplashScreen(),
            )));
  }
}
