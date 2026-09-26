import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app/ui/dashboard/dashboard_bottom_nav.dart';
import 'package:wallpaper_app/ui/dashboard/dashboard_pages/wallpaper_home_page.dart';
import 'package:wallpaper_app/ui/wallpaper_apply_page.dart';
import 'package:wallpaper_app/ui/wallpaper_second_page.dart';


class AppRoutes {

  //static String route_home = "/homePage";
  static String route_dashboard_bottom_nav = "/dashboardBottomNav";
  static String route_second_page = "/secondPage";
  static String route_apply_page = "/applyPage";


  static Map<String, WidgetBuilder> mRoots = {
    //route_home : (context) => WallpaperHomePage(),
    route_dashboard_bottom_nav : (context) => DashboardBottomNav(),
    route_second_page : (context) => WallpaperSecondPage(),
    route_apply_page : (context) => WallpaperApplyPage(),
  };

}