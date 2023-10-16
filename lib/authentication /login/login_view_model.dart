//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication%20/login/login_navigator.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/providers/auth_provider.dart';

class LoginScreenViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  late AuthProvider authProvider;

  var emailController = TextEditingController(text: 'sohaila@route.com');
  var passwordController = TextEditingController(text: '1234567');

  void login(context) async {
    //register
    // todo : show loading
    navigator.showMyLoading();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      var user =
          await FirebaseUtils.readUserFromFireStore(credential.user?.uid ?? '');
      if (user == null) {
        return;
      }
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.updateUser(user);
      // // todo : hide loading
      navigator.hideMyLoading();
      // todo : show message
      navigator.showMyMessage('Login Successfully');
      // DialogUtlis.showMessage(context, 'Login Successfully',
      //     title: 'Success', posActionName: 'ok', posAction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      //     });
      print('login successfully!');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN-CREDENTIAL') {
        // todo : hide loading
        navigator.hideMyLoading();
// todo : show message
        navigator
            .showMyMessage('No user found for that email OR WRONG PASSWORD');
        // DialogUtlis.showMessage(context, 'No user found for that email.',
        //     title: 'Error', posActionName: 'ok');
        // print('No user found for that email.');
        // } else if (e.code == 'wrong-password') {
        //   // todo : hide loading
        //   navigator.hideMyLoading();
        //   // todo : show message
        //   navigator.showMyMessage('Wrong password provided for that user.');
        //
        //   // DialogUtlis.showMessage(
        //   //     context, 'Wrong password provided for that user.',
        //   //     title: 'Error', posActionName: 'ok');
        //   // print('Wrong password provided for that user.');
      }
    } catch (e) {
      // todo : hide loading
      navigator.hideMyLoading();
      // todo : show message
      navigator.showMyMessage(e.toString());

      // DialogUtlis.showMessage(context, '${e.toString()}',
      //         title: 'Error', posActionName: 'ok');
      //     print(e.toString());
      // }
    }
  }
}
