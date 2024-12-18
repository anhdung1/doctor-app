import 'dart:ui';

import 'package:app/layers/presentation/blocs/favorite_bloc/favorite_bloc.dart';

import 'package:app/layers/presentation/views/user/doctor_details.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';

import 'package:app/layers/presentation/views/widgets/clip_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            decoration: homeTheme,
            height: MediaQuery.of(context).size.height,
            child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(children: [
                  AppBar(
                    automaticallyImplyLeading: false,
                    title: Text(
                      "Favorite Doctors",
                      style: titleStyle,
                    ),
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                  ),
                  BlocConsumer<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      if (state is FavoriteSuccessState) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 140,
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                                dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch
                                }),
                            child: GridView.builder(
                              itemCount: state.doctorsDTO.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 1.2,
                                      crossAxisCount:
                                          (screenWidth / 180).toInt() == 0
                                              ? 1
                                              : ((screenWidth + 50) / 180)
                                                  .toInt()),
                              itemBuilder: (context, index) {
                                return doctor(state, index);
                              },
                            ),
                          ),
                        );
                      }
                      if (state is FavoriteFailureState) {
                        return Center(
                          child: Text(state.error),
                        );
                      }
                      if (state is FavoriteLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        width: 10,
                        height: 10,
                        color: Colors.amber,
                      );
                    },
                    listener: (context, state) {},
                  )
                ]))));
  }

  Widget doctor(FavoriteSuccessState state, index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DoctorDetails(doctorsDTO: state.doctorsDTO[index]),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 10),
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    context.read<FavoriteBloc>().add(FavoriteEditEvent(
                        isFavorite: state.doctorsDTO[index].isFavorite,
                        doctorId: state.doctorsDTO[index].doctors.id));
                  },
                  child: state.doctorsDTO[index].isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 16,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          size: 16,
                        ),
                ),
              ),
              SizedBox(
                width: 84,
                height: 84,
                child: clipImage(state.doctorsDTO[index].doctors.image),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  state.doctorsDTO[index].doctors.name,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Text(
                  state.doctorsDTO[index].doctors.category,
                  style: TextStyle(fontSize: 12, color: Colors.green[400]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
