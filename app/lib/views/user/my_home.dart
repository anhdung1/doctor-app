import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_bloc.dart';
import 'package:app/bloc/all_bloc_favorite/favorite_bloc/favorite_event.dart';
import 'package:app/bloc/all_bloc_home/doctor_bloc/doctor_bloc.dart';
import 'package:app/bloc/all_bloc_home/doctor_bloc/doctor_event.dart';
import 'package:app/bloc/all_bloc_home/home_page_bloc/home_page_bloc.dart';
import 'package:app/bloc/all_bloc_home/home_page_bloc/home_page_event.dart';

import 'package:app/bloc/all_bloc_home/home_page_bloc/home_page_state.dart';

import 'package:app/views/user/favorite/favorite.dart';
import 'package:app/views/user/home/home.dart';
import 'package:app/views/user/user_info/user_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHome extends StatelessWidget {
  const MyHome({
    super.key,
    required this.lastName,
    required this.firstName,
    required this.imageUrl,
  });
  final String lastName;
  final String firstName;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomePageBloc(),
          ),
          BlocProvider(
            create: (context) => DoctorBloc()..add(DoctorStarted()),
          ),
          BlocProvider(
            create: (context) => FavoriteBloc([])..add(FavoriteStartedEvent()),
          )
        ],
        child: MyHomePage(
            lastName: lastName, firstName: firstName, imageUrl: imageUrl));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.lastName,
      required this.firstName,
      required this.imageUrl});
  final String lastName;
  final String firstName;
  final String imageUrl;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.chat_rounded), label: ""),
  ];
  onToggle() {
    setState(() {
      isEnterOtp2 = !isEnterOtp2;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(FavoriteStartedEvent());
  }

  bool isEnterOtp2 = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              [
                Home(
                  lastName: widget.lastName,
                  firstName: widget.firstName,
                  imageUrl: widget.imageUrl,
                  show: isEnterOtp2,
                  onToggle: onToggle,
                ),
                const Favorite(),
                const SizedBox(),
                const SizedBox(),
              ][state.pageIndex],
              SizedBox(
                height: 90,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.black26,
                    selectedItemColor: Colors.white,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: state.pageIndex,
                    items: items.map((item) {
                      return BottomNavigationBarItem(
                        icon: SizedBox(
                          width: 48,
                          height: 48,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              color: items[state.pageIndex] == item
                                  ? const Color.fromARGB(255, 75, 203, 139)
                                  : item.backgroundColor,
                              child: item.icon,
                            ),
                          ),
                        ),
                        label: item.label,
                      );
                    }).toList(),
                    onTap: (value) {
                      context
                          .read<HomePageBloc>()
                          .add(HomePageRouteEvent(index: value));
                    },
                  ),
                ),
              ),
              UserMenu(
                  lastName: widget.lastName,
                  firstName: widget.firstName,
                  imageUrl: widget.imageUrl,
                  show: isEnterOtp2,
                  onToggle: onToggle)
            ],
          ),
        );
      },
    );
  }
}
