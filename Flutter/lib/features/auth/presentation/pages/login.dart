import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/images_string.dart';
import 'package:vkuniversal/core/utils/show_snack_bar.dart';
import 'package:vkuniversal/core/widgets/back_leading_btn.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_in/bloc/sign_in_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/curved_bottom_clipper.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/dont_have_account.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/filled_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/google_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/text_form_field.dart';

import '../../../../core/utils/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void SubmitForm() {
    context.read<SignInBloc>().add(
          SubbmitLoginForm(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

        final isDesktop = Responsive.isDesktop(context);
     final isMobileLarge = Responsive.isMobileLarge(context);
    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, RoutesName.checkUserState);
          } else if (state is LoginFailure) {
            showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return Loader();
          }
          return Stack(
            children: [
              Positioned(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: CurvedBottomClipper(),
                       child: Container(
                        height: isDesktop ? 400 : isMobileLarge ? 300 : 200, // Adjust height based on isDesktop and isMobileLarge
                        width: double.infinity,
                        child: Image.asset(
                          ImageString.vku_landscape,
                          fit: isDesktop ? BoxFit.fitWidth : BoxFit.cover,
                        ),
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Welcome back",
                              style: textTheme.headlineLarge,
                            ),
                            Text(
                              "Login to your account",
                              style: textTheme.headlineSmall
                                  ?.copyWith(color: colorScheme.primary),
                            ),
                            CustomSizeBox(value: 30),
                            AuthTextField(
                              widthFieldPercent: isDesktop ? 0.5: 0.9,
                              hintText: "Email",
                              prefixIcon: IconList.email,
                              isObscured: false,
                              controller: emailController,
                              validation: null,
                            ),
                            CustomSizeBox(value: isDesktop ? 30: 10),
                            AuthTextField(
                              widthFieldPercent: isDesktop ? 0.5: 0.9,
                              hintText: "Password",
                              prefixIcon: IconList.lock,
                              isObscured: true,
                              controller: passwordController,
                              validation: null,
                            ),
                            CustomSizeBox(value: isDesktop ? 30: 10),
                            FilledButtonCustom(
                              label: "Login",
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  SubmitForm();
                                }
                              },
                              heightButton:  isDesktop ? 40: 10,
                              widthPercent: isDesktop ? 0.5: 0.9,
                            ),
                            CustomSizeBox(value: isDesktop ? 15: 10),
                            DontHaveAccount(),
                            CustomSizeBox(value: isDesktop ? 15: 10),
                            Text(
                              "Or \n",
                              style: textTheme.headlineSmall
                                  ?.copyWith(color: Color(0xffD0CFD4)),
                            ),
                            GoogleButton(
                              label: 'Sign up with Google',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent.withOpacity(0),
                  leading: BackLeadingBtn(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
