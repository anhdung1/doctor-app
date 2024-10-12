import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_bloc.dart';
import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_event.dart';
import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_state.dart';
import 'package:app/bloc/all_bloc_home/search_bloc/search_state.dart';
import 'package:app/model/doctors_dto_data_model.dart';
import 'package:app/views/variables/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

continueButton(Function() onTap, nameButton) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      // width: MediaQuery.of(context).size.width - 30,
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: colorButton),
      child: Text(
        nameButton,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}

Widget favoriteButton(BuildContext context, index, SearchSuccessState state,
    favoriteState, List<DoctorsDtoDataModel> doctorsDTO) {
  bool favorite = state.doctorsDTO[index].isFavorite;

  return BlocProvider(
    create: (contextEditing) => FavoriteBloc(
        (favoriteState is FavoriteSuccessState)
            ? favoriteState.doctorsDTO
            : []),
    child: BlocConsumer<FavoriteBloc, FavoriteState>(
      builder: (contextEditing, state1) {
        if (state1 is FavoriteLoadingState) {}
        return InkWell(
          onTap: () {
            contextEditing.read<FavoriteBloc>().add(FavoriteEditEvent(
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
      listener: (contextEditing, state1) {
        if (state1 is FavoriteSuccessState) {
          favorite = !favorite;
          doctorsDTO[index] = DoctorsDtoDataModel(
              doctors: doctorsDTO[index].doctors, isFavorite: favorite);
          context.read<FavoriteBloc>().add(FavoriteUpdateEvent());
        }
      },
    ),
  );
}
