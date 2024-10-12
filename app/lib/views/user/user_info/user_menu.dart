import 'package:app/views/user/user_info/profile.dart';
import 'package:app/views/widgets/clip_image.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatefulWidget {
  const UserMenu(
      {super.key,
      required this.show,
      required this.onToggle,
      required this.lastName,
      required this.firstName,
      required this.imageUrl});
  final String lastName;
  final String firstName;
  final String imageUrl;
  final bool show;
  final Function onToggle;
  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Stack(
      children: [
        AnimatedPositioned(
          left: widget.show ? 0 : -screen.width,
          right: widget.show ? 00 : screen.width,
          duration: const Duration(milliseconds: 180),
          child: Container(
            width: screen.width,
            height: screen.height,
            color: Colors.black12,
          ),
        ),
        AnimatedPositioned(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 200),
          bottom: 0,
          left: widget.show ? 0 : -screen.width,
          right: widget.show ? 100 : screen.width,
          child: Container(
            height: screen.height,
            decoration: const BoxDecoration(
              color: Colors.black12,
            ),
            child: SizedBox(
              child: Scaffold(
                body: Container(
                  padding: const EdgeInsets.only(top: 25),
                  width: screen.width,
                  height: screen.height,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(111, 127, 161, 1)),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      height: screen.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 44,
                                height: 44,
                                child: clipImage(widget.imageUrl),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "${widget.firstName} ${widget.lastName}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(right: 10, top: 3),
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      widget.onToggle();
                                    },
                                    icon: const Icon(Icons.close),
                                    color: Colors.white,
                                    splashColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 60)),
                          itemMenu(Icons.account_circle, "Profile", () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Profile(),
                                ));
                          }),
                          itemMenu(Icons.payment, "Payments", () {}),
                          itemMenu(
                              Icons.shopify_outlined, "Medicine Orders", () {}),
                          itemMenu(Icons.calendar_month_outlined,
                              "Test Bookings", () {}),
                          itemMenu(Icons.security, "Privacy & Policy", () {}),
                          itemMenu(Icons.help, "Help Center", () {}),
                          itemMenu(Icons.settings, "Settings", () {}),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: SizedBox(
                              width: 200,
                              height: 51,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/home', ModalRoute.withName('/'));
                                },
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 15, top: 4),
                                      child: Icon(
                                        Icons.logout,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
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
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  itemMenu(IconData icon, String name, onTap) {
    return SizedBox(
      width: 200,
      height: 61,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, top: 2),
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
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 4),
                child: const Icon(
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
}
