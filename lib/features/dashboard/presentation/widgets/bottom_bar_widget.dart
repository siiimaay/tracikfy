import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 350,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavigationBar(
          backgroundColor: Color(0xff9CA5D9),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,

          items: const [
            BottomNavigationBarItem(label: "Job", icon: Icon(Icons.add)),
            BottomNavigationBarItem(label: "Schedule Interview", icon: Icon(Icons.schedule)),
            BottomNavigationBarItem(label: "Todo", icon: Icon(Icons.abc_outlined)),
          ],
        ),
      ),
    );

  }
}
