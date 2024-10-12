import 'package:app/bloc/signup_bloc/signup_bloc.dart';
import 'package:app/bloc/signup_bloc/signup_event.dart';
import 'package:app/bloc/signup_bloc/signup_state.dart';
import 'package:app/views/user/login.dart';
import 'package:app/views/variables/variable.dart';
import 'package:app/views/widgets/auth.dart';
import 'package:app/views/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _otp1Controller = TextEditingController();
  final TextEditingController _otp2Controller = TextEditingController();
  final TextEditingController _otp3Controller = TextEditingController();
  final TextEditingController _otp4Controller = TextEditingController();

  final FocusNode _otp1FocusNode = FocusNode();
  final FocusNode _otp2FocusNode = FocusNode();
  final FocusNode _otp3FocusNode = FocusNode();
  final FocusNode _otp4FocusNode = FocusNode();
  bool isEnterOtp = false;
  bool isSendOtp = false;
  bool agreeCondition = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();

  final TextEditingController _reEnterPsswordController =
      TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        builder: (context, state) {
          if (state is ShowLoginState) {
            return const Login();
          }
          if (state is SignUpInitalState) {
            isEnterOtp = false;
            isSendOtp = false;
          }
          if (state is SignUpFailureState) {
            error = state.error;
          }
          if (state is SignUpSuccessState) {
            isEnterOtp = true;
          }
          if (state is SendSignUpSuccessState) {
            isSendOtp = state.showNotify;
            isEnterOtp = false;
          }
          return initSignUpState(error, isEnterOtp, isSendOtp);
        },
        listener: (context, state) {},
      ),
    );
  }

  otpTextField(TextEditingController controller, FocusNode currentFocus,
      FocusNode? nextFocus) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 10),
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
      ),
    );
  }

  initSignUpState(error, bool isEnterOtp1, bool isEnterOtp2) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          height: MediaQuery.of(context).size.height + 38,
          decoration: BoxDecoration(gradient: gradient),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleName("Join us to start searching"),
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
                    _gmailController, "Email", false, Icons.email_rounded),
                textField(
                    _passwordController, "Password", true, Icons.lock_rounded),
                textField(_reEnterPsswordController, "Re-enter password", true,
                    Icons.lock_rounded),
                Align(
                  alignment: Alignment.centerLeft,
                  child: error == ""
                      ? const SizedBox()
                      : Text(
                          error,
                          style: const TextStyle(color: Colors.red),
                        ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 33,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) => InkWell(
                          onTap: () {
                            setState(() {
                              agreeCondition = !agreeCondition;
                            });
                          },
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                                color: agreeCondition
                                    ? Colors.blue
                                    : Colors.black26,
                                borderRadius: BorderRadius.circular(8)),
                            child: agreeCondition
                                ? const Icon(
                                    Icons.check,
                                    size: 12,
                                    color: Colors.white,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "I agree with the Terms of Service & Privacy Policy",
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: InkWell(
                    onTap: () {
                      context.read<SignupBloc>().add(SignUpCheckEvent(
                            username: _usernameController.text,
                            password: _passwordController.text,
                            reEnterPassword: _reEnterPsswordController.text,
                            agreeCondition: agreeCondition,
                          ));
                    },
                    child: Container(
                      height: 54,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: colorButton),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                textButton(() {
                  context.read<SignupBloc>().add(ShowLoginEvent());
                }, "Have an account? Log in")
              ],
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 130),
          bottom: isEnterOtp1 ? 0 : -MediaQuery.of(context).size.height,
          left: 0,
          right: 00,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            child: SizedBox(
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 380,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<SignupBloc>()
                                    .add(BackSignUpEvent());
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 2, bottom: 2),
                                width: 130,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: nameAuth("Enter 4 Digits Code",
                              "Enter the 4 digits code that you received on your email."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              otpTextField(_otp1Controller, _otp1FocusNode,
                                  _otp2FocusNode),
                              otpTextField(_otp2Controller, _otp2FocusNode,
                                  _otp3FocusNode),
                              otpTextField(_otp3Controller, _otp3FocusNode,
                                  _otp4FocusNode),
                              otpTextField(
                                  _otp4Controller, _otp4FocusNode, null),
                            ],
                          ),
                        ),
                        continueButton(() {
                          context.read<SignupBloc>().add(SendSignUpEvent(
                              username: _usernameController.text,
                              password: _passwordController.text));
                        }, "Continue")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 130),
          bottom: isEnterOtp2 ? 0 : -MediaQuery.of(context).size.height,
          left: 0,
          right: 00,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            child: SizedBox(
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                context
                                    .read<SignupBloc>()
                                    .add(BackSignUpEvent());
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 2, bottom: 2),
                                width: 130,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 50),
                          child: nameAuth("Sign Up Susccess",
                              "Continue to return to login"),
                        ),
                        continueButton(() {
                          context.read<SignupBloc>().add(ShowLoginEvent());
                        }, "Continue")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  nameAuth(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        )
      ],
    );
  }
}
