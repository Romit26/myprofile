import 'package:flutter/material.dart';
import 'package:myprofile/core/constant/color_constant.dart';

///common button for in whole app
class CustomBtn extends StatelessWidget {
  final String title;
  EdgeInsets margin;
  void Function() onTap;

  CustomBtn(
      {super.key,
      required this.title,
      required this.onTap,
      this.margin = const EdgeInsets.symmetric(vertical: 10)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: btnBGColor, borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
