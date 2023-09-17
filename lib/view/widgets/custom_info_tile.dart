import 'package:flutter/material.dart';
import 'package:myprofile/view/widgets/edit_avtar_btn.dart';

///user information showing tile in homepage
Widget customInfoTile(
    {String? info,
    required String hint,
    required String title,
    required void Function() onTap}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200),
          child: Row(
            children: [
              Expanded(child: Text(info ?? hint)),
              InkWell(
                onTap: onTap,
                child: EditAvtarBtn(margin: EdgeInsets.zero),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
