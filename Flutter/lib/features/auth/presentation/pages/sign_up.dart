import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vkuniversal/config/routes/router_name.dart';
import 'package:vkuniversal/core/utils/icon_string.dart';
import 'package:vkuniversal/core/utils/show_snack_bar.dart';
import 'package:vkuniversal/core/widgets/back_leading_btn.dart';
import 'package:vkuniversal/core/widgets/loader.dart';
import 'package:vkuniversal/core/widgets/size_box.dart';
import 'package:vkuniversal/features/auth/presentation/bloc/sign_up/bloc/sign_up_bloc.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/filled_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/google_button.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/horizontal_line.dart';
import 'package:vkuniversal/features/auth/presentation/widgets/text_form_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void SignUpSubmitted() {
    context.read<SignUpBloc>().add(
          SignUpFormSummitted(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            name: nameController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: BackLeadingBtn(),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.popAndPushNamed(context, RoutesName.addUserInfor);
          } else if (state is SignUpFailure) {
            showErrorSnackBar(context, state.message ?? "");
          }
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            return Loader();
          }
          return Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Register",
                  style: textTheme.headlineLarge,
                ),
                CustomSizeBox(value: 10),
                Text(
                  "Create your new account",
                  style: textTheme.headlineSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                CustomSizeBox(value: 50),
                AuthTextField(
                  hintText: "Name",
                  prefixIcon: IconList.user,
                  isObscured: false,
                  controller: nameController,
                ),
                CustomSizeBox(value: 10),
                AuthTextField(
                  hintText: "Email",
                  prefixIcon: IconList.email,
                  isObscured: false,
                  controller: emailController,
                ),
                CustomSizeBox(value: 10),
                AuthTextField(
                  hintText: "Password",
                  prefixIcon: IconList.lock,
                  isObscured: true,
                  controller: passwordController,
                ),
                CustomSizeBox(value: 10),
                FilledButtonCustom(
                  label: "Create",
                  onPress: () {
                    SignUpSubmitted();
                  },
                ),
                CustomSizeBox(value: 10),
                HorizontalLine(),
                CustomSizeBox(value: 10),
                GoogleButton(
                  label: 'Sign up with Google',
                  onPressed: () {},
                ),
                CustomSizeBox(value: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutesName.login);
                  },
                  child: RichText(
                    text: TextSpan(
                        text: "Already have an account? ",
                        style: textTheme.headlineSmall
                            ?.copyWith(color: Color(0xffD0CFD4)),
                        children: [
                          TextSpan(
                            text: "Sign in",
                            style: textTheme.headlineSmall?.copyWith(
                              color: colorScheme.primaryContainer,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
