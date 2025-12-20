// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tasky/models/user_model.dart';
import 'package:tasky/views/widgets/app_dialog_widget.dart';
import 'package:tasky/views/widgets/firebase_authentication.dart';
import 'package:tasky/views/widgets/firebase_result.dart';
import 'package:tasky/views/widgets/text_form_field_widget.dart';
import 'package:tasky/views/widgets/validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
                SizedBox(height: 100),
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xDE24252C),
                  ),
                ),
                SizedBox(height: 24),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xDE24252C),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: usernameController,
                        validator: Validator.validateName,
                        hintText: 'enter username...',
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 11),
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
                      SizedBox(height: 11),
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
                      SizedBox(height: 11),
                      Text(
                        'Confirm Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xDE24252C),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormFieldWidget(
                        controller: confirmPasswordController,
                        validator: (value) => Validator.validateConfirmPassword(
                          value,
                          passwordController.text,
                        ),
                        hintText: 'Password...',
                        obscureText: true,
                        isPassword: true,
                      ),
                      SizedBox(height: 78),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _registerOnPressed,
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
                                'Register',
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
                SizedBox(height: 112),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff6E6A7C),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Login',
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

  void _registerOnPressed() async {
    if (formKey.currentState!.validate()) {
      AppDialogWidget.showLoading(context);
      final result = await FirebaseAuthentication.register(
        UserModel(
          name: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      switch (result) {
        case FirebaseSuccess<UserModel>():
          Navigator.of(context).pop();
          usernameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          Navigator.of(context).pop();
        case FirebaseError<UserModel>():
          Navigator.of(context).pop();
          AppDialogWidget.showError(context, errorMessage: result.message);
      }
    }
  }
}
