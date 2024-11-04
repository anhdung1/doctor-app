import 'package:app/layers/domain/entities/doctor_data_model.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';
import 'package:app/layers/presentation/views/doctor/list_user_chatted.dart';
import 'package:app/layers/presentation/views/widgets/clip_image.dart';
import 'package:flutter/material.dart';

class HomeDoctor extends StatefulWidget {
  final DoctorDataModel doctor;
  const HomeDoctor({super.key, required this.doctor});

  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screen.height,
        padding: const EdgeInsets.only(bottom: 85),
        decoration: homeTheme,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context)
              .copyWith(dragDevices: dragDevices),
          child: ListView(
            controller: _scrollController,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    width: screen.width,
                    margin: const EdgeInsets.only(bottom: 23),
                    height: 156,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(14, 190, 126, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi ${widget.doctor.name}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const Text(
                                "Find Your Doctor",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Container(
                          padding: const EdgeInsets.only(right: 15, top: 20),
                          width: 70,
                          child: imageButton(widget.doctor.image, () {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 5),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListUserChatted(),
                ));
          },
          child: Image.asset(
            "assets/images/messenger.png",
            width: 30,
            errorBuilder: (context, error, stackTrace) {
              return const Text("Error");
            },
          ),
        ),
      ),
    );
  }
}
