import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/dashboard/dashboard_pages/download_page.dart';
import 'package:wallpaper_app/ui/dashboard/dashboard_pages/profile_page.dart';
import 'package:wallpaper_app/ui/dashboard/dashboard_pages/wallpaper_home_page.dart';

class DashboardBottomNav extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => DashboardBottomNavState();
}

class DashboardBottomNavState extends State<DashboardBottomNav>{

  int selectedPageIndex = 0;

  List<Widget> pages = [
    WallpaperHomePage(),
    DownloadPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(selectedPageIndex == 0 ? CupertinoIcons.square_split_2x2_fill : CupertinoIcons.square_split_2x2),
                label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(selectedPageIndex == 1 ? CupertinoIcons.square_arrow_down_fill : CupertinoIcons.square_arrow_down),
                label: "Download"
            ),
            BottomNavigationBarItem(
                icon: Icon(selectedPageIndex == 2 ? Icons.account_circle : Icons.account_circle_outlined),
                label: "Profile"
            ),
          ],


        currentIndex: selectedPageIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,


        onTap: (value){
            selectedPageIndex = value;
            setState(() {

            });
        },

      ),
    );
  }

}