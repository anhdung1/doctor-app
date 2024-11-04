import 'package:app/layers/presentation/blocs/chat_bloc/user_chatted/user_chatted_bloc.dart';
import 'package:app/layers/domain/entities/user_data_model.dart';
import 'package:app/layers/presentation/views/chat/chat_screen.dart';
import 'package:app/layers/presentation/views/constants/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListUserChatted extends StatelessWidget {
  const ListUserChatted({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserChattedBloc()..add(UserChattedFetchingEvent()),
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: homeTheme,
            child: Column(
              children: [
                AppBar(
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
                    child: BlocConsumer<UserChattedBloc, UserChattedState>(
                      builder: (context, state) {
                        if (state is UserChattedOfDoctorSuccessState) {
                          return _buildInitialDoctorWidget(state.listUser);
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
        ));
  }

  _buildInitialDoctorWidget(List<UserDataModel> listUser) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 90, left: 15, right: 15),
      itemCount: listUser.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(receiver: listUser[index]),
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
                              listUser[index].image,
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
                              "${listUser[index].firstName}${listUser[index].lastName}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
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
