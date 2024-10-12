import 'package:app/model/doctors_dto_data_model.dart';
import 'package:app/views/variables/variable.dart';
import 'package:app/views/widgets/app_bar.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({super.key, required this.doctorsDTO});
  final DoctorsDtoDataModel doctorsDTO;

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: homeTheme,
        height: screenHeight,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              appBar(context, "Select Time"),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 90,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 1)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
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
                                    widget.doctorsDTO.doctors.nameDoctor,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    widget.doctorsDTO.doctors.category,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green[500],
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: RatingBar.readOnly(
                                        initialRating:
                                            widget.doctorsDTO.doctors.rate,
                                        filledIcon: Icons.star,
                                        size: 11,
                                        emptyIcon: Icons.star_outline_outlined),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 1),
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {},
                                  child: widget.doctorsDTO.isFavorite
                                      ? const Icon(
                                          Icons.favorite,
                                          size: 14,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          size: 14,
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  date(int number, onTap) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 130, height: 54,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: number % 2 == 0
                  ? Border.all(color: Colors.black26, width: 0.3)
                  : Border.all(),
              color: number % 2 == 0 ? Colors.transparent : colorButton),
          // child: Column(children: [
          //   Text(data)
          // ],),
        ),
      ),
    );
  }
}
