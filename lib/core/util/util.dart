import 'package:flutter/material.dart';
import 'package:myprofile/core/constant/color_constant.dart';

///this function will return size
Size size(BuildContext context) {
  return MediaQuery.of(context).size;
}

void commonDialog(
    {required BuildContext context,
    required String title,
    required String desc,
    void Function(bool? value)? onAction}) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
          scale: curve,
          child: WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15),
                        child: Text(
                          desc,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text("No",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text("Yes",
                                style: TextStyle(
                                    color: primarySwatchColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
    },
    pageBuilder: (_, __, ___) {
      return Container();
    },
  ).then((value) {
    onAction!(value as bool);
  });
}
