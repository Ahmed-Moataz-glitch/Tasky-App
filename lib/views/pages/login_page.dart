// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/views/widgets/app_colors.dart';
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
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            right: 24,
            left: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.08),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.semiBlack,
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.semiBlack,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    TextFormFieldWidget(
                      controller: emailController,
                      validator: Validator.validateEmail,
                      hintText: 'enter email...',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.semiBlack,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    TextFormFieldWidget(
                      controller: passwordController,
                      validator: Validator.validatePassword,
                      hintText: 'Password...',
                      obscureText: true,
                      isPassword: true,
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _loginOnPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
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
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginOnPressed() async {
    if(formKey.currentState!.validate()){
      AppDialogWidget.showLoading(context, title: 'Logging in...');
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
          AppDialogWidget.showError(
            context,
            errorMessage: result.message,
          );
      }
    }
  }
}
