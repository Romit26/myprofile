import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprofile/core/bloc/logged_user_info/logged_user_info_bloc.dart';
import 'package:myprofile/core/bloc/login_bloc/login_bloc.dart';
import 'package:myprofile/core/bloc/user_info/userinfo_bloc.dart';
import 'package:myprofile/core/constant/image_constant.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/constant/label_constant.dart';
import 'package:myprofile/core/constant/key_constant.dart' as key;
import 'package:myprofile/view/ui/home/homepage.dart';
import 'package:myprofile/view/widgets/custom_btn.dart';
import 'package:myprofile/view/widgets/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String userNameError = "";
  String? userName;
  ValueNotifier<bool> userNameValid = ValueNotifier(true);
  String passwordError = "";
  String? password;
  ValueNotifier<bool> passwordValid = ValueNotifier(true);
  ValueNotifier<bool> rememberMe = ValueNotifier(false);
  ValueNotifier<bool> obscureText = ValueNotifier(true);
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  ///username validator
  bool checkUserName(bool type) {
    if (type && userName == null) {
      userNameError = nameError;
      userNameValid.value = false;
      return userNameValid.value;
    } else if (type && userName!.isEmpty) {
      userNameError = nameError;
      userNameValid.value = false;
      return userNameValid.value;
    } else if (type && !emailRegex.hasMatch(userName!)) {
      userNameError = emailError;
      userNameValid.value = false;
      return userNameValid.value;
    } else {
      userNameError = "";
      userNameValid.value = true;
      return userNameValid.value;
    }
  }

  ///password validator
  bool checkPassword(bool type) {
    if (type && password == null) {
      passwordError = passError;
      passwordValid.value = false;
      return passwordValid.value;
    } else if (type && userName!.isEmpty) {
      passwordError = passError;
      passwordValid.value = false;
      return passwordValid.value;
    } else {
      passwordError = "";
      passwordValid.value = true;
      return passwordValid.value;
    }
  }

  ///validator
  void validator() {
    if (checkUserName(true) && checkPassword(true)) {
      Map<String, dynamic> map = {
        key.userName: userName,
        key.password: password,
        key.loginType: normalLogin,
        key.rememberMe: rememberMe.value,
        key.userLoggedOut: false,
      };
      BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(map: map));
    }
  }

  void googleLogin() {
    Map<String, dynamic> map = {
      key.loginType: key.googleLogin,
    };
    BlocProvider.of<LoginBloc>(context).add(GoogleLoginUserEvent(map: map));
  }

  @override
  void initState() {
    BlocProvider.of<LoggedUserInfoBloc>(context).add(const GetLoggedUserInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(loginAppBarTitle),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              }
            },
          ),
          BlocListener<LoggedUserInfoBloc, LoggedUserInfoState>(
            listener: (context, state) {
              if (state is LoggedUserInfoSuccess) {
                if (state.map[key.rememberMe] == true) {
                  nameController.text = state.map[key.userName];
                  passwordController.text = state.map[key.password];
                  userName = nameController.text;
                  password = passwordController.text;
                  rememberMe.value = state.map[key.rememberMe];
                }
              }
            },
          ),
        ],
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: userNameValid,
                    builder: (context, value, child) {
                      return CustomTextField(
                        textEditingController: nameController,
                        hint: userNameHint,
                        error: userNameValid.value ? null : userNameError,
                        onChange: (value) {
                          userName = value;
                          userNameValid.value = checkUserName(false);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: passwordValid,
                    builder: (context, value, child) {
                      return ValueListenableBuilder(
                        valueListenable: obscureText,
                        builder: (context, value, child) {
                          return CustomTextField(
                            textEditingController: passwordController,
                            hint: passwordHint,
                            error: passwordValid.value ? null : passwordError,
                            onChange: (value) {
                              password = value;
                              passwordValid.value = checkPassword(false);
                            },
                            showSuffix: true,
                            obscure: obscureText.value,
                            onChangeObscure: (value) {
                              obscureText.value = value;
                            },
                          );
                        },
                      );
                    },
                  ),
                  Row(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: rememberMe,
                        builder: (context, value, child) {
                          return Checkbox(
                            value: rememberMe.value,
                            onChanged: (value) => rememberMe.value = value!,
                          );
                        },
                      ),
                      const Text(
                        rememberMeTitle,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  CustomBtn(
                    title: loginAppBarTitle,
                    onTap: validator,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Text(orLoginWith),
                        Expanded(child: Divider())
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: googleLogin,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(googleImg, height: 25, width: 25),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            continueWithGoogle,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
