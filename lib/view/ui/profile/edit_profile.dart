import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprofile/core/bloc/update_profile/update_profile_bloc.dart';
import 'package:myprofile/core/constant/image_constant.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/constant/label_constant.dart';
import 'package:myprofile/core/util/util.dart';
import 'package:myprofile/view/widgets/custom_btn.dart';
import 'package:myprofile/view/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myprofile/view/widgets/edit_avtar_btn.dart';

class EditProfile extends StatefulWidget {
  final String editFieldType;
  String fieldValue;
  final String fieldHint;
  Map<String, dynamic>? currentProfileInfo;

  EditProfile(
      {super.key,
      required this.editFieldType,
      this.currentProfileInfo,
      this.fieldValue = "",
      required this.fieldHint});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? textFieldValue;
  TextEditingController fieldController = TextEditingController();
  ValueNotifier<String> imagePath = ValueNotifier("");
  String? tempValue;
  late double width;
  late double height;

  @override
  void initState() {
    if (widget.editFieldType == avtarPath) {
      imagePath.value = widget.fieldValue;
      tempValue = widget.fieldValue;
      textFieldValue = imagePath.value;
    } else {
      fieldController.text = widget.fieldValue;
      textFieldValue = fieldController.text;
      tempValue = widget.fieldValue;
    }
    super.initState();
  }

  Future<void> imagePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
      textFieldValue = image.path;
    }
  }

  void showSaveChangesDialog() {
    commonDialog(
      context: context,
      title: discardTitle,
      desc: discardDesc,
      onAction: (value) {
        if (value == true) {
          Navigator.pop(context);
        }
      },
    );
  }

  void validator(bool userManualBack) {
    if (userManualBack) {
      if (tempValue != textFieldValue) {
        showSaveChangesDialog();
      } else {
        Navigator.pop(context);
      }
    } else {
      saveProfileInformation();
    }
  }

  void saveProfileInformation() {
    Map<String, dynamic> updatedInfoMap = {};
    if (widget.currentProfileInfo != null) {
      updatedInfoMap.addAll(widget.currentProfileInfo!);
    }
    if (widget.editFieldType == avtarPath) {
      updatedInfoMap[widget.editFieldType] = imagePath.value;
    } else {
      updatedInfoMap[widget.editFieldType] = textFieldValue;
    }
    BlocProvider.of<UpdateProfileBloc>(context)
        .add(UpdateProfileUserEvent(map: updatedInfoMap));
  }

  @override
  Widget build(BuildContext context) {
    width = size(context).width;
    height = size(context).height;
    return WillPopScope(
      onWillPop: () async {
        validator(true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(editProfileAppBar),
        ),
        body: BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is UpdateProfileSuccess) {
              Navigator.pop(context, true);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  widget.editFieldType == avtarPath
                      ? Center(
                          child: SizedBox(
                            height: 125,
                            width: 125,
                            child: Stack(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: imagePath,
                                  builder: (context, value, child) {
                                    return Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(width * 3)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(width * 3),
                                          child: imagePath.value == ""
                                              ? Image.asset(personImg,
                                                  height: height * 3,
                                                  width: width * 3)
                                              : Image.file(
                                                  File(imagePath.value),
                                                  height: height * 3,
                                                  width: width * 3,
                                                  fit: BoxFit.cover,
                                                )),
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: imagePicker,
                                    child: EditAvtarBtn(),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : CustomTextField(
                          textEditingController: fieldController,
                          hint: widget.fieldHint,
                          onChange: (value) {
                            textFieldValue = value;
                          },
                        ),
                  const Spacer(),
                  CustomBtn(
                    title: saveChanges,
                    onTap: () => validator(false),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
