import 'package:app/bloc/all_bloc_home/doctor_bloc/doctor_bloc.dart';

import 'package:app/bloc/all_bloc_home/doctor_bloc/doctor_state.dart';
import 'package:app/views/chat_screen.dart';
import 'package:app/views/variables/variable.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListDoctorsChat extends StatelessWidget {
  const ListDoctorsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: homeTheme,
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                "Chat",
                style: titleStyle,
              ),
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context)
                    .copyWith(dragDevices: dragDevices),
                child: BlocConsumer<DoctorBloc, DoctorState>(
                  builder: (context, state) {
                    if (state is DoctorSuccessState) {
                      return _buildInitialDoctorWidget(state);
                    }
                    return const SizedBox();
                  },
                  listener: (context, state) {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildInitialDoctorWidget(DoctorSuccessState state) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 90, left: 15, right: 15),
      itemCount: state.doctorsDTO.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                      receiverId: state.doctorsDTO[index].doctors.id),
                ));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 90,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 1)
            ], color: Colors.white, borderRadius: BorderRadius.circular(7)),
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
                              state.doctorsDTO[index].doctors.image,
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
                              state.doctorsDTO[index].doctors.nameDoctor,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              state.doctorsDTO[index].doctors.category,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[500],
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: RatingBar.readOnly(
                                  initialRating:
                                      state.doctorsDTO[index].doctors.rate,
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
                            child: state.doctorsDTO[index].isFavorite
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
        );
      },
    );
  }
}
