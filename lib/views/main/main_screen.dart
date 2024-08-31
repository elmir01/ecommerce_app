import 'package:ecommerce_app/views/home/home_screen.dart';
import 'package:ecommerce_app/views/settings/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/notification_screen.dart';
import '../home/orders_screen.dart';
import '../settings/settings_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: screens.length, vsync: this);
    super.initState();
  }

  var screens = [
    HomeScreen(),
    NotificationScreen(),
    WishlistScreen(),
    SettingsScreen(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0.sp,
        currentIndex: selectedIndex,
        onTap: (int? value) {
          setState(() {
            selectedIndex = value!;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home.png',
              color: selectedIndex == 0
                  ? Color.fromARGB(255, 142, 108, 209)
                  : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/notf.png',
              color: selectedIndex == 1
                  ? Color.fromARGB(255, 142, 108, 209)
                  : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            // icon: Image.asset(
            //   'assets/favicon.png',
            //   color: selectedIndex == 2
            //       ? Color.fromARGB(255, 142, 108, 209)
            //       : null,
            // ),
            icon: Icon(
              size: 28.sp,
              Icons.favorite_border_rounded,
              color: selectedIndex == 2
                  ? Color.fromARGB(255, 142, 108, 209)
                  : Colors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/settings.png',
              color: selectedIndex == 3
                  ? Color.fromARGB(255, 142, 108, 209)
                  : null,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
