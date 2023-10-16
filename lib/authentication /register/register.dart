import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/home_screen.dart';
import 'package:todo_app/authentication%20/login/login.dart';
import 'package:todo_app/authentication%20/register/register_navigator.dart';
import 'package:todo_app/authentication%20/register/register_view_model.dart';
import 'package:todo_app/components/custom_textform_field.dart';
import 'package:todo_app/dialog_utlis.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  var nameController = TextEditingController(text: 'sohaila');
  var emailController = TextEditingController(text: 'sohaila@route.com');
  var passwordController = TextEditingController(text: '1234567');
  var confirmPasswordController = TextEditingController(text: '1234567');
  var formKey = GlobalKey<FormState>();

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.Register(emailController.text, passwordController.text, context,
          nameController.text);
    }
  }

  @override
  void hideMyLoading() {
    DialogUtlis.hideLoading(context);
  }

  @override
  void showMyLoading() {
    DialogUtlis.showLoading(context, 'loading...');
  }

  @override
  void showMyMessage(String message) {
    DialogUtlis.showMessage(context, message,
        title: 'success', posActionName: 'ok', posAction: () {
      Navigator.pushNamed(context, HomeScreen.routeName);
    });
  }
}
