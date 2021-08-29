import 'package:flutter/material.dart';
import 'package:to_do_list/theme/color.dart';

class UIUtitilies {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.white,
                    elevation: 3,
                    shadowColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
