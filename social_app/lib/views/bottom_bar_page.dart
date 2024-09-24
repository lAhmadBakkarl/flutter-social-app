import 'package:flutter/material.dart';
import 'package:social_app/Constants/AppColors.dart';
import 'package:social_app/views/home.dart';

// ignore: must_be_immutable
class BottomBarPage extends StatefulWidget {
  @override
  // ignore: override_on_non_overriding_member
  int selectedIndex = 0;

  BottomBarPage(this.selectedIndex, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _selectedIndex = 0;
  final screens = [
    const Home(),
    // const TodoListScreen(),
  ];

  @override
  void initState() {
    _onItemTapped(widget.selectedIndex);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Hello Abdul!'), surfaceTintColor: const Color.fromRGBO(247, 247, 249, 1), toolbarHeight: 30, backgroundColor: const Color.fromRGBO(247, 247, 249, 1),),
      body: screens.elementAt(_selectedIndex),
      extendBody: true,
      // backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(
        height: 90,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Wrap(children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.redColor,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  label: '',
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'images/todo1.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset(
                      'images/todo1.png',
                      height: 45,
                      width: 45,
                    ),
                  )),
              // BottomNavigationBarItem(
              //     label: '',
              //     icon: Padding(
              //       padding: EdgeInsets.only(top: 10),
              //       child: Image.asset(
              //         'images/fav.png',
              //         height: 30,
              //         width: 30,
              //       ),
              //     ),
              //     activeIcon: Padding(
              //       padding: EdgeInsets.only(top: 5),
              //       child: Image.asset(
              //         'images/favactive.png',
              //         height: 45,
              //         width: 45,
              //       ),
              //     )),
              // BottomNavigationBarItem(
              //     label: '',
              //     icon: Padding(
              //       padding: EdgeInsets.only(top: 10),
              //       child: Image.asset(
              //         'images/cart.png',
              //         height: 30,
              //         width: 30,
              //       ),
              //     ),
              //     activeIcon: Padding(
              //       padding: EdgeInsets.only(top: 5),
              //       child: Image.asset(
              //         'images/cartactive.png',
              //         height: 45,
              //         width: 45,
              //       ),
              //     )),
              BottomNavigationBarItem(
                  label: '',
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      'images/todo2.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset(
                      'images/todo2.png',
                      height: 45,
                      width: 45,
                    ),
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}
