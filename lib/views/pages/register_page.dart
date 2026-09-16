// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tasky/models/user_model.dart';
import 'package:tasky/views/widgets/app_colors.dart';
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
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                'Register',
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
                      'Full Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.semiBlack,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    TextFormFieldWidget(
                      controller: fullNameController,
                      validator: Validator.validateName,
                      hintText: 'enter full name...',
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: size.height * 0.03),
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
                      hintText: 'create password...',
                      obscureText: true,
                      isPassword: true,
                    ),
                    SizedBox(height: size.height * 0.03),
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.semiBlack,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    TextFormFieldWidget(
                      controller: confirmPasswordController,
                      validator: (value) => Validator.validateConfirmPassword(
                        value,
                        passwordController.text,
                      ),
                      hintText: 'confirm password...',
                      obscureText: true,
                      isPassword: true,
                    ),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _registerOnPressed,
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
                              'Register',
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
              SizedBox(height: size.height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Login',
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
  
  void _registerOnPressed() async {
    if (formKey.currentState!.validate()) {
      AppDialogWidget.showLoading(context, title: 'Registering...');
      final result = await FirebaseAuthentication.register(
        UserModel(
          name: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      switch(result){
        case FirebaseSuccess<UserModel>():
          Navigator.of(context).pop();
          fullNameController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          Navigator.of(context).pop();
        case FirebaseError<UserModel>():
          Navigator.of(context).pop();
          AppDialogWidget.showError(
            context,
            errorMessage: result.message,
          );
      }
    }
  }
}
