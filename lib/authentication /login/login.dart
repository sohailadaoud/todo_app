import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication%20/register/register.dart';
import 'package:todo_app/components/custom_textform_field.dart';
import 'package:todo_app/dialog_utlis.dart';
import 'package:todo_app/firebase_utils.dart';

import '../../Home/home_screen.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'sohaila@route.com');

  var passwordController = TextEditingController(text: '1234567');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset('assets/images/background',
          // width: double.infinity,
          // fit: BoxFit.fill),
          Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    CustomTextFormField(
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter your email';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'please enter valid email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      keyboardType: TextInputType.number,
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter your password';
                        }
                        if (text.length < 6) {
                          return 'password should be at least 6 characters';
                        }
                        return null;
                      },
                      isPassword: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: Text(
                          'LogIn',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(
                          'Dont have an account?',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            //navigate to registerscreen
                            Navigator.of(context)
                                .pushNamed(RegisterScreen.routeName);
                          },
                          child: Text('SignUp', style: TextStyle(fontSize: 18)),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == true) {
      //register
      // todo : show loading
      DialogUtlis.showLoading(context, 'loading...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(user);
        // todo : hide loading
        DialogUtlis.hideLoading(context);
        // todo : show message
        DialogUtlis.showMessage(context, 'Login Successfully',
            title: 'Success', posActionName: 'ok', posAction: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
        print('login successfully!');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // todo : hide loading
          DialogUtlis.hideLoading(context);
          // todo : show message
          DialogUtlis.showMessage(context, 'No user found for that email.',
              title: 'Error', posActionName: 'ok');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // todo : hide loading
          DialogUtlis.hideLoading(context);
          // todo : show message
          DialogUtlis.showMessage(
              context, 'Wrong password provided for that user.',
              title: 'Error', posActionName: 'ok');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        // todo : hide loading
        DialogUtlis.hideLoading(context);
        // todo : show message
        DialogUtlis.showMessage(context, '${e.toString()}',
            title: 'Error', posActionName: 'ok');
        print(e.toString());
      }
    }
  }
}
