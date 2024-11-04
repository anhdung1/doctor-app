import 'package:app/layers/presentation/blocs/favorite_bloc/favorite_bloc.dart';

import 'package:app/layers/presentation/blocs/all_bloc_home/doctor_bloc/doctor_bloc.dart';

import 'package:app/layers/presentation/blocs/home_page_bloc/home_page_bloc.dart';
import 'package:app/layers/presentation/blocs/chat_bloc/user_chatted/user_chatted_bloc.dart';

import 'package:app/layers/domain/entities/user_data_model.dart';
import 'package:app/layers/presentation/views/user/favorite/favorite.dart';
import 'package:app/layers/presentation/views/user/home/home.dart';
import 'package:app/layers/presentation/views/user/list_doctors_chat.dart';
import 'package:app/layers/presentation/views/user/user_info/user_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHome extends StatelessWidget {
  const MyHome({
    super.key,
    required this.user,
  });
  final UserDataModel user;
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
          ),
          BlocProvider(
            create: (context) =>
                UserChattedBloc()..add(UserChattedFetchingEvent()),
          ),
        ],
        child: MyHomePage(
          user: user,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.user,
  });

  final UserDataModel user;
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
      isShowMenu = !isShowMenu;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(FavoriteStartedEvent());
  }

  bool isShowMenu = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              [
                Home(
                  lastName: widget.user.lastName,
                  firstName: widget.user.firstName,
                  imageUrl: widget.user.image,
                  show: isShowMenu,
                  onToggle: onToggle,
                ),
                const Favorite(),
                const SizedBox(),
                const ListDoctorsChat()
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
                  lastName: widget.user.lastName,
                  firstName: widget.user.firstName,
                  imageUrl: widget.user.image,
                  show: isShowMenu,
                  onToggle: onToggle)
            ],
          ),
        );
      },
    );
  }
}
