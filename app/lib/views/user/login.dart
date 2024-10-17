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
  final TextEditingController _usernameController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is SigupState) {
            return const Signup();
          }
          return _initLoginState(state);
        },
        listener: (context, state) {
          if (state is LoginLoadingState) {
            errorMessage = "";
          }
          if (state is LoginFailureState) {
            errorMessage = state.error;
          }
          if (state is LoginUserSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MyHome(
                  lastName: state.login.lastName,
                  firstName: state.login.firstName,
                  imageUrl: state.login.image,
                  id: state.login.id,
                ),
              ),
              ModalRoute.withName('/'),
            );
          }
        },
      ),
    );
  }

  Widget _initLoginState(LoginState state) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height,
          decoration: homeTheme,
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
                      const SizedBox(width: 10),
                      loginWith("assets/images/facebook.png", "Facebook"),
                    ],
                  ),
                ),
                textField(_usernameController, "Username", false,
                    Icons.account_circle),
                textField(
                    _passwordController, "Password", true, Icons.lock_rounded),
                _errorMessage(),
                Padding(
                  padding: const EdgeInsets.only(top: 35, bottom: 20),
                  child: InkWell(
                    onTap: () {
                      // Kiểm tra dữ liệu đầu vào trước khi gửi sự kiện

                      context.read<LoginBloc>().add(LoginCheckEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          ));
                    },
                    child: Container(
                      height: 54,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: colorButton,
                      ),
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                textButton(() {}, "Forgot password"),
                const Padding(padding: EdgeInsets.only(top: 20)),
                textButton(() {
                  context.read<LoginBloc>().add(ShowSignUpPageEvent());
                }, "Don’t have an account? Join us"),
              ],
            ),
          ),
        ),
        if (state is LoginLoadingState) _loadingIndicator(),
      ],
    );
  }

  Widget _loadingIndicator() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 3),
      ),
    );
  }

  Widget _errorMessage() {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: errorMessage.isEmpty
          ? const SizedBox()
          : Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
    );
  }
}
