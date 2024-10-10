import 'package:app/bloc/login_bloc/login_bloc.dart';
import 'package:app/bloc/login_bloc/login_event.dart';
import 'package:app/bloc/login_bloc/login_state.dart';
import 'package:app/views/user/my_home.dart';
import 'package:app/views/user/signup.dart';
import 'package:app/views/variables/variable.dart';
import 'package:app/views/widgets/auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMassage = "";
  LoginBloc parentBloc = LoginBloc();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is SigupState) {
            return const Signup();
          }

          return initLoginState(errorMassage, loading);
        },
        listener: (context, state) {
          if (state is LoginLoadingState) {
            loading = true;
            errorMassage = "";
          }
          if (state is LoginFailureState) {
            errorMassage = state.error;
            loading = false;
          }
          if (state is LoginUserSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MyHome(
                  userResponse: state.login,
                ),
              ),
              ModalRoute.withName('/'),
            );
          }
        },
      ),
    );
  }

  initLoginState(error, loading) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: gradient),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleName("Welcome back"),
                content(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      loginWith("assets/images/google-symbol.png", "Google"),
                      const SizedBox(
                        width: 10,
                      ),
                      loginWith("assets/images/facebook.png", "Facebook")
                    ],
                  ),
                ),
                textField(_usernameController, "Username", false,
                    Icons.account_circle),
                textField(
                    _passwordController, "Password", true, Icons.lock_rounded),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: error == ""
                      ? const SizedBox()
                      : Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, bottom: 20),
                  child: InkWell(
                    onTap: () {
                      context.read<LoginBloc>().add(LoginCheckEvent(
                          username: _usernameController.text,
                          password: _passwordController.text,
                          parentBloc: parentBloc));
                    },
                    child: Container(
                      height: 54,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: colorButton),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                textButton(() {}, "Forgor password"),
                const Padding(padding: EdgeInsets.only(top: 20)),
                textButton(() {
                  context.read<LoginBloc>().add(ShowSignUpPageEvent());
                }, "Don’t have an account? Join us")
              ],
            ),
          ),
        ),
        if (loading)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black12,
            child: const Center(
              child: CircularProgressIndicator(
                strokeAlign: 3,
              ),
            ),
          )
      ],
    );
  }
}
