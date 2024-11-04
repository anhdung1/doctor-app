import 'package:app/layers/presentation/blocs/profile_bloc/profile_bloc.dart';

import 'package:app/layers/domain/entities/user_data_model.dart';
import 'package:app/layers/presentation/views/user/my_home.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';
import 'package:app/layers/presentation/views/widgets/app_bar.dart';

import 'package:app/layers/presentation/views/widgets/button.dart';
import 'package:app/layers/presentation/views/widgets/clip_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileFetchingEvent()),
      child: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  UserDataModel? user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileErrorState) {
          return Scaffold(
            appBar: appBar(context, "Profile"),
          );
        }
        if (state is ProfileSuccessState) {
          user = state.user;
          isLoading = false;
          lastNameController.text = state.user.lastName;
          firstNameController.text = state.user.firstName;
          emailController.text = state.user.email;
          phoneNumberController.text = state.user.phoneNumber;
          addressController.text = state.user.address;
        }
        return user == null ? const Scaffold() : initPage(user!);
      },
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          isLoading = true;
        }

        if (state is ProfileUpdateSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MyHome(
                user: state.user,
              ),
            ),
            ModalRoute.withName('/'),
          );
        }
      },
    );
  }

  initPage(UserDataModel user) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: homeTheme,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context)
                  .copyWith(dragDevices: dragDevices),
              child: ListView(
                children: [
                  AppBar(
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: colorButton,
                    title: const Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    leading: Align(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: colorButton,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            "Set up your profile",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                            "Update your profile to connect your doctor with better impression.",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Stack(
                          alignment: const Alignment(0.93, 0.93),
                          children: [
                            const SizedBox(
                              width: 130,
                              height: 130,
                            ),
                            SizedBox(
                              width: 130,
                              height: 130,
                              child: clipImage(user.image),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(18)),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 19,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   "Personal Information",
                        //   style:
                        //       TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        // ),
                        nameTextField("First Name"),
                        textField(firstNameController, "First name"),
                        nameTextField("Last Name"),
                        textField(lastNameController, "Last name"),
                        nameTextField(
                          "Email",
                        ),
                        textField(emailController, "Email"),
                        nameTextField("Phone Number"),
                        textField(phoneNumberController, "Phone number"),
                        nameTextField("Address"),
                        textField(addressController, "Address"),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: continueButton(() {
                            context.read<ProfileBloc>().add(ProfileEditEvent(
                                user: UserDataModel(
                                    lastName: lastNameController.text.trim(),
                                    firstName: firstNameController.text.trim(),
                                    id: 1,
                                    phoneNumber:
                                        phoneNumberController.text.trim(),
                                    image: "",
                                    email: emailController.text.trim(),
                                    address: addressController.text.trim())));
                          }, "Save"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }

  nameTextField(String name) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  textField(TextEditingController controller, String hinText) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: Colors.white),
      child: TextFormField(
        controller: controller,
        // initialValue: controller.text,
        decoration: InputDecoration(
            hintText: hinText,
            hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black38,
                fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(7))),
      ),
    );
  }
}
