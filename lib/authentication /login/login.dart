import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Home/home_screen.dart';
import 'package:todo_app/authentication%20/login/login_navigator.dart';
import 'package:todo_app/authentication%20/login/login_view_model.dart';
import 'package:todo_app/authentication%20/register/register.dart';
import 'package:todo_app/components/custom_textform_field.dart';
import 'package:todo_app/dialog_utlis.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  var emailController = TextEditingController(text: 'sohaila@route.com');

  var passwordController = TextEditingController(text: '1234567');

  var formKey = GlobalKey<FormState>();
  LoginScreenViewModel viewModel = LoginScreenViewModel();

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
                        label: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                        controller: viewModel.emailController,
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
                        controller: viewModel.passwordController,
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
                            login(context);
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
                            child:
                                Text('SignUp', style: TextStyle(fontSize: 18)),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void login(context) async {
    if (formKey.currentState?.validate() == true) {
      viewModel.login(context);
    }
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    DialogUtlis.hideLoading(context);
  }

  @override
  void showMyLoading() {
    // TODO: implement showMyLoading
    DialogUtlis.showLoading(context, 'loading...');
  }

  @override
  void showMyMessage(String message) {
    // TODO: implement showMyMessage
    DialogUtlis.showMessage(context, message,
        title: 'success', posActionName: 'ok', posAction: () {
      Navigator.pushNamed(context, HomeScreen.routeName);
    });
  }
}
