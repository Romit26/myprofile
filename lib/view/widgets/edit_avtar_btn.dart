import 'package:flutter/material.dart';
import 'package:myprofile/core/constant/color_constant.dart';

///edit btn for avtar and [customInfoTile] in home.
Widget EditAvtarBtn(
    {EdgeInsets margin = const EdgeInsets.only(bottom: 10, right: 10)}) {
  return Container(
    margin: margin,
    height: 30,
    width: 30,
    decoration:
        const BoxDecoration(shape: BoxShape.circle, color: editIconBGColor),
    child: const Icon(
      Icons.edit_outlined,
      color: Colors.white,
    ),
  );
}
