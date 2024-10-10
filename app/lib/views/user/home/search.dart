import 'dart:ui';

import 'package:app/bloc/all_bloc_home/search_bloc/search_bloc.dart';
import 'package:app/bloc/all_bloc_home/search_bloc/search_event.dart';
import 'package:app/bloc/all_bloc_home/search_bloc/search_state.dart';
import 'package:app/model/doctors_dto_data_model.dart';

import 'package:app/views/user/home/select_time.dart';
import 'package:app/views/variables/variable.dart';
import 'package:app/views/widgets/app_bar.dart';
import 'package:app/views/widgets/icon_button_favorite.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.content});
  final String content;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc()..add(SearchFetchingEvent(content: content)),
      child: SearchPage(
        content: content,
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.content});
  final String content;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchController.text = widget.content;
  }

  List<DoctorsDtoDataModel> doctorsDTO = [];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar(context, "Find Doctors"),
              Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.only(bottom: 10, top: 20),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7)),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    context
                        .read<SearchBloc>()
                        .add(SearchFetchingEvent(content: value));
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(7)),
                    hintText: "Search....",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Icon(Icons.search_rounded),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: 45),
                    suffixIcon: InkWell(
                      onTap: () {
                        searchController.clear();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
              BlocConsumer<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is SearchFailureState) {
                    return Expanded(child: Center(child: Text(state.error)));
                  }
                  if (state is SearchSuccessState) {
                    doctorsDTO = state.doctorsDTO;
                    return listDoctor(state);
                  }
                  return const Expanded(
                      child: Center(child: Text("Not Found")));
                },
                listener: (context, state) {},
              )
            ],
          ),
        ),
      ),
    );
  }

  listDoctor(SearchSuccessState state) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: state.doctorsDTO.length,
            itemBuilder: (context, index) {
              String newAvailable = state.doctorsDTO[index].doctors.available
                  .substring(
                      0, state.doctorsDTO[index].doctors.available.length - 3);
              return doctor(newAvailable, state, index, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SelectTime(doctorsDTO: doctorsDTO[index]),
                    ));
              });
            }),
      ),
    );
  }

  doctor(
    newAvailable,
    SearchSuccessState state,
    index,
    onTap,
  ) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 170,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 87,
                    height: 87,
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
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          state.doctorsDTO[index].doctors.category,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.green[500],
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${state.doctorsDTO[index].doctors.experiences} Years expriences",
                          style: const TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.only(top: 6),
                        alignment: Alignment.centerRight,
                        child:
                            favoriteButton(context, index, state, doctorsDTO)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Available",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.green[500],
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${state.doctorsDTO[index].doctors.available} AM tomorrow",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: InkWell(
                        onTap: onTap,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.green[500],
                              borderRadius: BorderRadius.circular(7)),
                          width: 112,
                          height: 34,
                          child: const Text(
                            "Book Now",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
