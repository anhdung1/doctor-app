import 'package:app/layers/domain/entities/doctors_dto_data_model.dart';
import 'package:app/layers/presentation/views/user/home/select_time.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';
import 'package:app/layers/presentation/views/widgets/app_bar.dart';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key, required this.doctorsDTO});
  final DoctorsDtoDataModel doctorsDTO;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: homeTheme,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            appBar(context, "Doctor Details"),
            doctor(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 30),
              child: Container(
                height: 84,
                width: screenWidth,
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 2)
                ], color: Colors.white, borderRadius: BorderRadius.circular(4)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    content(100, "Runing"),
                    content(500, "Ongoing"),
                    content(700, "Patient")
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Services",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            contentService(
                1, "Patient care should be the number one priority."),
            solid(),
            contentService(
                2, "If you run your practiceyou know how frustrating."),
            solid(),
            contentService(
                3, "That’s why some of appointment reminder system."),
            SizedBox(
                child: Image.asset(
              "assets/images/map.png",
            ))
          ],
        ),
      ),
    );
  }

  solid() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, top: 15),
      color: Colors.black26,
      height: 0.3,
      width: MediaQuery.of(context).size.width,
    );
  }

  contentService(int number, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$number. ",
          style: TextStyle(
              fontSize: 14, color: colorButton, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  content(number, String name) {
    return Container(
      width: 80,
      height: 56,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }

  doctor() {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 1)
            ], color: Colors.white, borderRadius: BorderRadius.circular(7)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              widget.doctorsDTO.doctors.image,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.account_circle,
                                  size: 87,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctorsDTO.doctors.name,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              widget.doctorsDTO.doctors.category,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.green[500],
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: RatingBar.readOnly(
                                  initialRating: widget.doctorsDTO.doctors.rate,
                                  filledIcon: Icons.star,
                                  size: 11,
                                  emptyIcon: Icons.star_outline_outlined),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 1),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.attach_money_rounded,
                                      color: colorButton,
                                      size: 16,
                                    ),
                                  ),
                                  Text(
                                    "${widget.doctorsDTO.doctors.price}/hr",
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 2),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectTime(doctorsDTO: widget.doctorsDTO),
                            ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        height: 32,
                        decoration: BoxDecoration(
                            color: colorButton,
                            borderRadius: BorderRadius.circular(3)),
                        child: const Text(
                          "Book Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
