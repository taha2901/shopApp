import 'package:flutter/material.dart';
import 'package:shopapp/helper/cach.dart';
import 'package:shopapp/views/login.dart';

void signOut(context) {
  ChachHelper.removeData(key: 'token')!.then((value) => {
        if (value == true)
          {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            )
          }
      });
}
String token = 'IqSDmSB38a56pujykO880daku4Z8zwr8KJAklBE5XGdDeAm0rSckxABSesKlVwY9jee2Ry';

// String token = '';