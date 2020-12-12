import 'package:donate_blood/Screens/donations_collections//donations_collections.dart';
import 'package:donate_blood/screens/profile_details/profile_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'events/list_view_events.dart';
import 'home_user_page/components/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  final int index;
  BottomNavScreen([this.index = 0]);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState(this.index);
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  _BottomNavScreenState(this.currentIndex);
  final List _screens = [
    HomeScreen(),
    DonationsCollections(),
    ListViewEvents(),
    ProfilePage(),
  ];
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: _screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 0.0,
            items: [Icons.home, Icons.history, Icons.event_note, Icons.person]
                .asMap()
                .map((key, value) => MapEntry(
                      key,
                      BottomNavigationBarItem(
                        label: '',
                        icon: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 16.0,
                          ),
                          decoration: BoxDecoration(
                            color: currentIndex == key
                                ? Colors.red[600]
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Icon(value),
                        ),
                      ),
                    ))
                .values
                .toList(),
          ),
        ),
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false;
        });
  }
}
