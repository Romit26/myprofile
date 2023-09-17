import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprofile/core/bloc/logout_user/logout_user_bloc.dart';
import 'package:myprofile/core/bloc/profile_info/profile_information_bloc.dart';
import 'package:myprofile/core/constant/image_constant.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/constant/label_constant.dart';
import 'package:myprofile/core/util/util.dart';
import 'package:myprofile/view/ui/authentication/login_screen.dart';
import 'package:myprofile/view/ui/profile/edit_profile.dart';
import 'package:myprofile/view/widgets/custom_info_tile.dart';
import 'package:myprofile/view/widgets/edit_avtar_btn.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double width;
  late double height;

  @override
  void initState() {
    getProfileInfo();
    super.initState();
  }

  void navigateEditProfile(
      {required String fieldType,
      String fieldValue = "",
      Map<String, dynamic>? currentProfileInfo,
      required String hint}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfile(
              editFieldType: fieldType,
              fieldValue: fieldValue,
              currentProfileInfo: currentProfileInfo,
              fieldHint: hint),
        )).then((value) {
      if (value == true) {
        getProfileInfo();
      }
    });
  }

  void getProfileInfo() {
    BlocProvider.of<ProfileInformationBloc>(context).add(GetProfileInfoEvent());
  }

  void logoutDialog() {
    commonDialog(
      context: context,
      title: logoutTitle,
      desc: logoutDesc,
      onAction: (value) {
        if (value == true) {
          BlocProvider.of<LogoutUserBloc>(context)
              .add(const LogoutUserClickEvent());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    width = size(context).width;
    height = size(context).height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text(homeAppBarTitle),
        actions: [
          IconButton(onPressed: logoutDialog, icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocListener<LogoutUserBloc, LogoutUserState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LogoutUserSuccess) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginView()));
          }
        },
        child: BlocBuilder<ProfileInformationBloc, ProfileInformationState>(
          builder: (context, state) {
            if (state is ProfileInformationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileInformationSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 125,
                          width: 125,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width * 3)),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(width * 3),
                                    child: state.map != null &&
                                            state.map!.containsKey(avtarPath) &&
                                            state.map![avtarPath] != ""
                                        ? Image.file(
                                            File(state.map![avtarPath]),
                                            height: height * 3,
                                            width: width * 3,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(personImg,
                                            height: height * 3,
                                            width: width * 3)),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: InkWell(
                                  onTap: () {
                                    navigateEditProfile(
                                        currentProfileInfo: state.map,
                                        fieldType: avtarPath,
                                        fieldValue: state.map![avtarPath] ?? "",
                                        hint: avtarName);
                                  },
                                  child: EditAvtarBtn(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      customInfoTile(
                        title: nameTitle,
                        info: state.map![avtarName],
                        hint: nameHint,
                        onTap: () {
                          navigateEditProfile(
                              currentProfileInfo: state.map,
                              fieldType: avtarName,
                              fieldValue: state.map![avtarName] ?? "",
                              hint: nameHint);
                        },
                      ),
                      customInfoTile(
                        info: state.map![email],
                        hint: emailHint,
                        title: emailTitle,
                        onTap: () {
                          navigateEditProfile(
                              currentProfileInfo: state.map,
                              fieldType: email,
                              fieldValue: state.map![email] ?? "",
                              hint: emailHint);
                        },
                      ),
                      customInfoTile(
                        info: state.map![skills],
                        hint: skillHint,
                        title: skillTitle,
                        onTap: () {
                          navigateEditProfile(
                              currentProfileInfo: state.map,
                              fieldType: skills,
                              fieldValue: state.map![skills] ?? "",
                              hint: skillHint);
                        },
                      ),
                      customInfoTile(
                        info: state.map![workExp],
                        hint: experienceHint,
                        title: experienceTitle,
                        onTap: () {
                          navigateEditProfile(
                              currentProfileInfo: state.map,
                              fieldType: workExp,
                              fieldValue: state.map![workExp] ?? "",
                              hint: experienceHint);
                        },
                      )
                    ],
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
