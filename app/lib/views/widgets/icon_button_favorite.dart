import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_bloc.dart';
import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_event.dart';
import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_state.dart';
import 'package:app/bloc/all_bloc_home/search_bloc/search_state.dart';
import 'package:app/model/doctors_dto_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget favoriteButton(BuildContext context, index, SearchSuccessState state,
    List<DoctorsDtoDataModel> doctorsDTO) {
  bool favorite = state.doctorsDTO[index].isFavorite;

  return BlocProvider(
    create: (context) => FavoriteBloc([]),
    child: BlocConsumer<FavoriteBloc, FavoriteState>(
      builder: (context, state1) {
        if (state1 is FavoriteLoadingState) {}
        return InkWell(
          onTap: () {
            context.read<FavoriteBloc>().add(FavoriteEditEvent(
                isFavorite: state.doctorsDTO[index].isFavorite,
                doctorId: state.doctorsDTO[index].doctors.id));
          },
          child: favorite
              ? const Icon(
                  Icons.favorite,
                  size: 16,
                  color: Colors.red,
                )
              : const Icon(Icons.favorite_border, size: 16),
        );
      },
      listener: (context, state1) {
        if (state1 is FavoriteSuccessState) {
          favorite = !favorite;
          doctorsDTO[index] = DoctorsDtoDataModel(
              doctors: doctorsDTO[index].doctors, isFavorite: favorite);
        }
      },
    ),
  );
}
