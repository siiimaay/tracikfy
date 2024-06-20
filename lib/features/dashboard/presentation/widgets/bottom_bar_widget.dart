import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trackify/features/meeting/presentation/meeting_view.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int currentIndex = 0;

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
          backgroundColor: const Color(0xff9CA5D9),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: _onTap,
          items: const [
            //BottomNavigationBarItem(label: "Job", icon: Icon(Icons.add)),
            BottomNavigationBarItem(
              label: "Interviews",
              icon: Icon(Icons.schedule),
            ),
            BottomNavigationBarItem(
                label: "Todo", icon: Icon(Icons.abc_outlined)),
          ],
        ),
      ),
    );
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {

      case 0:
        context.push(MeetingView.route);
        break;
      case 1:
        break;
    }
    setState(() {
      currentIndex = tabIndex;
    });
  }
}
