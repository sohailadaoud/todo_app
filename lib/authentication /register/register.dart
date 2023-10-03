import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/home_screen.dart';
import 'package:todo_app/authentication%20/login/login.dart';
import 'package:todo_app/components/custom_textform_field.dart';
import 'package:todo_app/dialog_utlis.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'sohaila');
  var emailController = TextEditingController(text: 'sohaila@route.com');
  var passwordController = TextEditingController(text: '1234567');
  var confirmPasswordController = TextEditingController(text: '1234567');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/background.png',
              width: double.infinity, fit: BoxFit.fill),
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
                      label: 'UserName',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter your username';
                        }
                        return null;
                      },
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
                    CustomTextFormField(
                      label: 'confirm password',
                      keyboardType: TextInputType.number,
                      controller: confirmPasswordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please confirm your password';
                        }
                        if (text != passwordController.text) {
                          return 'password doesnt match';
                        }

                        return null;
                      },
                      isPassword: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          register();
                        },
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          //navigate to loginscreen
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                        child: Text('already have an account?'))
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      //register
      // todo : show loading
      DialogUtlis.showLoading(context, 'loading...');

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseUtils.addUserToFireStore(myUser);
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(myUser);
        // todo : hide loading
        DialogUtlis.hideLoading(context);
        // todo : show message
        DialogUtlis.showMessage(context, 'Register Successfully',
            title: 'Success', posActionName: 'ok', posAction: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });

        print('register successfully!');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo : hide loading
          DialogUtlis.hideLoading(context);
          // todo : show message
          DialogUtlis.showMessage(context, 'The password provided is too weak.',
              title: 'Error', posActionName: 'ok');

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          // todo : hide loading
          DialogUtlis.hideLoading(context);
          // todo : show message
          DialogUtlis.showMessage(
              context, 'The account already exists for that email.',
              title: 'Error', posActionName: 'ok');
          print('The account already exists for that email.');
        }
      } catch (e) {
        // todo : hide loading
        DialogUtlis.hideLoading(context);
        // todo : show message
        DialogUtlis.showMessage(context, '${e.toString()}',
            title: 'Error', posActionName: 'ok');
        print(e);
      }
    }
  }
}
