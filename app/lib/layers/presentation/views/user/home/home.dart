import 'dart:ui';
import 'package:app/layers/presentation/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:app/layers/presentation/blocs/all_bloc_home/doctor_bloc/doctor_bloc.dart';

import 'package:app/layers/presentation/views/user/doctor_details.dart';

import 'package:app/layers/presentation/views/user/home/search.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';

import 'package:app/layers/presentation/views/widgets/clip_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.onToggle,
    required this.show,
    required this.lastName,
    required this.firstName,
    required this.imageUrl,
  });
  final String lastName;
  final String firstName;
  final String imageUrl;
  final Function onToggle;
  final bool show;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  List<Color> categoryColor = [
    Colors.purple[400]!,
    Colors.green[400]!,
    Colors.orange[400]!,
    Colors.red[400]!
  ];
  List<String> categoryAssetImage = [
    "tooth.png",
    "heart.png",
    "eye.png",
    "body.png"
  ];
  final ScrollController _itemScrollController = ScrollController();
  var paddingLeft = const EdgeInsets.only(left: 15);
  var paddingRight = const Padding(padding: EdgeInsets.only(right: 15));
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
          behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
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
                                "Hi ${widget.firstName} ${widget.lastName}",
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
                          child: imageButton(widget.imageUrl, () {
                            setState(() {
                              widget.onToggle();
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: Offset(0, 0.5),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    width: screen.width - 30,
                    child: TextField(
                      onSubmitted: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider<FavoriteBloc>.value(
                              value: BlocProvider.of(context),
                              child: Search(content: value),
                            ),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        hintText: "Search....",
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.close,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 15),
                child: Text(
                  "Live Doctor",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              listLive(),
              listCategory(),
              sectionTitle("Popular Doctor", "See All", () {}),
              BlocConsumer<DoctorBloc, DoctorState>(
                builder: (context, state) {
                  if (state is DoctorLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is DoctorSuccessState) {
                    return Column(
                      children: [
                        listPopularDoctor(state),
                        sectionTitle("Feature Doctor", "See All", () {}),
                        listFeatureDoctor(state),
                      ],
                    );
                  }
                  if (state is DoctorFailureState) {
                    return const Center(
                      child: Text(
                        "Error",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    );
                  }
                  return const SizedBox();
                },
                listener: (context, state) {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  itemMenu(IconData icon, String name) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: 200,
        height: 61,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 4),
              child: Icon(
                icon,
                size: 24,
                color: Colors.white,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 4),
                child: Icon(
                  Icons.navigate_next_outlined,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  sectionTitle(name, buttonName, onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20, bottom: 10, right: 15),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          const Expanded(child: SizedBox()),
          InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: onTap,
              child: Text(
                buttonName,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[400]),
              ))
        ],
      ),
    );
  }

  listPopularDoctor(DoctorSuccessState state) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 15),
        scrollDirection: Axis.horizontal,
        itemCount: state.doctorsDTO.length,
        itemBuilder: (context, index) {
          return popularDoctor(state, index);
        },
      ),
    );
  }

  popularDoctor(DoctorSuccessState state, index) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
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
          width: 190,
          height: 264,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 190,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(7)),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      state.doctorsDTO[index].doctors.image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Hiển thị loading khi tải ảnh lỗi
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  state.doctorsDTO[index].doctors.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                state.doctorsDTO[index].doctors.category,
                style: const TextStyle(fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RatingBar.readOnly(
                  alignment: Alignment.center,
                  initialRating: state.doctorsDTO[index].doctors.rate,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  size: 16,
                  maxRating: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  listFeatureDoctor(DoctorSuccessState state) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 15),
        scrollDirection: Axis.horizontal,
        itemCount: state.doctorsDTO.length,
        itemBuilder: (context, index) {
          return featureDoctor(
              state.doctorsDTO[index].doctors.rate,
              state.doctorsDTO[index].doctors.image,
              state.doctorsDTO[index].doctors.name,
              state.doctorsDTO[index].doctors.price);
        },
      ),
    );
  }

  featureDoctor(double rate, String image, String nameDoctor, int price) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 10),
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 100,
            height: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(Icons.favorite_border, size: 12),
                      ),
                      const Expanded(
                          child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.star,
                          size: 13,
                          color: Color.fromARGB(255, 237, 213, 0),
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          rate.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 54,
                  height: 54,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(27),
                      child: Image.network(
                        image,
                        alignment: const Alignment(1, -0.9),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 4),
                  child: Text(
                    nameDoctor,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.attach_money_rounded,
                      size: 13,
                      color: Colors.green,
                    ),
                    Text(
                      "$price/hours",
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  listLive() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 198,
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 15),
          scrollDirection: Axis.horizontal,
          controller: _itemScrollController,
          itemCount: 7,
          itemBuilder: (context, index) {
            return liveItem();
          },
        ));
  }

  liveItem() {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: 168,
              width: 117,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.asset(
                  "assets/images/default.png",
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("Error"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const Icon(
              Icons.play_circle_outline_outlined,
              color: Colors.white,
            ),
            Container(
              width: 40,
              height: 18,
              margin: const EdgeInsets.only(left: 59, bottom: 130),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: const Color.fromRGBO(250, 0, 47, 1)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fiber_manual_record, // Biểu tượng dấu chấm tròn
                    color: Colors.white,
                    size: 8,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "LIVE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 7,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  listCategory() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 15),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return checkupCategory(
                categoryColor[index], categoryAssetImage[index]);
          },
        ));
  }

  checkupCategory(color, image) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {},
        child: Center(
          child: Container(
            width: 80,
            height: 90,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Image.asset(
                "assets/images/$image",
                width: 33,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
