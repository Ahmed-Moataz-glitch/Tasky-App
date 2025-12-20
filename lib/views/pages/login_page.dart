// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/views/widgets/app_dialog_widget.dart';
import 'package:tasky/views/widgets/app_routes.dart';
import 'package:tasky/views/widgets/firebase_authentication.dart';
import 'package:tasky/views/widgets/firebase_result.dart';
import 'package:tasky/views/widgets/text_form_field_widget.dart';
import 'package:tasky/views/widgets/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xDE24252C),
                  ),
                ),
                SizedBox(height: 54),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xDE24252C),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: emailController,
                        validator: Validator.validateEmail,
                        hintText: 'enter email...',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 26),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xDE24252C),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: passwordController,
                        validator: Validator.validatePassword,
                        hintText: 'Password...',
                        obscureText: true,
                        isPassword: true,
                      ),
                      SizedBox(height: 70),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _loginOnPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff5F33E1),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 245),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account? ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6E6A7C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        emailController.clear();
                        passwordController.clear();
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xDE5F33E1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginOnPressed() async {
    if (formKey.currentState!.validate()) {
      AppDialogWidget.showLoading(context);
      final result = await FirebaseAuthentication.login(
        email: emailController.text,
        password: passwordController.text,
      );
      switch (result) {
        case FirebaseSuccess<UserCredential>():
          Navigator.of(context).pop();
          emailController.clear();
          passwordController.clear();
          Navigator.of(context).pushReplacementNamed(AppRoutes.homePage);
        case FirebaseError<UserCredential>():
          Navigator.of(context).pop();
          AppDialogWidget.showError(context, errorMessage: result.message);
      }
    }
  }
}
