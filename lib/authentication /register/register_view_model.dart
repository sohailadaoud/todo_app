import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication%20/register/register_navigator.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/providers/auth_provider.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  late AuthProvider authProvider;

  void Register(String email, String password, context, String name) async {
    //register
    // todo : show loading
    navigator.showMyLoading();

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser myUser = MyUser(
        id: credential.user?.uid ?? '',
        name: name,
        email: email,
      );
      await FirebaseUtils.addUserToFireStore(myUser);
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.updateUser(myUser);
      // todo : hide loading
      navigator.hideMyLoading();
      // todo : show message
      navigator.showMyMessage('Register Successfully');
      // DialogUtlis.showMessage(context, 'Register Successfully',
      //     title: 'Success', posActionName: 'ok', posAction: () {
      //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      // });

      print('register successfully!');
      print(credential.user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // todo : hide loading
        navigator.hideMyLoading();
        // todo : show message
        navigator.showMyMessage('The password provided is too weak.');

        //   DialogUtlis.showMessage(context, 'The password provided is too weak.',
        //       title: 'Error', posActionName: 'ok');
        //
        //   print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // todo : hide loading
        navigator.hideMyLoading();
        // todo : show message
        navigator.showMyMessage('The account already exists for that email.');

        //   DialogUtlis.showMessage(
        //       context, 'The account already exists for that email.',
        //       title: 'Error', posActionName: 'ok');
        //   print('The account already exists for that email.');
      }
    } catch (e) {
      // todo : hide loading
      navigator.hideMyLoading();
      // todo : show message
      navigator.showMyMessage(e.toString());

      //   DialogUtlis.showMessage(context, '${e.toString()}',
      //       title: 'Error', posActionName: 'ok');
      print(e);
    }
  }
}
