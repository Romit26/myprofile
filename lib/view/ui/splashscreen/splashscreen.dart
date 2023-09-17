import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprofile/core/bloc/user_info/userinfo_bloc.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/util/util.dart';
import 'package:myprofile/view/ui/authentication/login_screen.dart';
import 'package:myprofile/view/ui/home/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<UserinfoBloc>(context)
        .add(const GetUserInfoEvent(key: userLoginKey));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserinfoBloc, UserinfoState>(
        listener: (context, state) {
          if (state is UserInfoSuccess) {
            if (state.map!.isNotEmpty && state.map![userLoggedOut]) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
                (route) => false,
              );
            } else if (state.map!.isNotEmpty && !state.map![userLoggedOut]) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ));
            }
          }
        },
        child: Center(
          child: FlutterLogo(size: size(context).height / 4),
        ),
      ),
    );
  }
}
