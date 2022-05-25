import 'package:screen_assignments/styling/app_colors.dart';
import 'package:screen_assignments/styling/app_images.dart';
import 'package:screen_assignments/styling/responsive.dart';
import 'package:flutter/material.dart';

import '../adaptive_base_widget.dart';
import '../adaptive_breakpoints.dart';
import '../adaptive_screen_type.dart';
import '../adaptive_sizing.dart';
 

abstract class AdaptiveScaffoldImpl {
  PreferredSizeWidget? appBar(
      BuildContext context, AdaptiveSizingInfo sizingInfo) {}

  PreferredSizeWidget? simpleAppBar(
      BuildContext context, AdaptiveSizingInfo sizingInfo) {}

  Widget bottomNavBar(BuildContext context, AdaptiveSizingInfo sizingInfo);

  Widget drawer(BuildContext context, AdaptiveSizingInfo sizingInfo);

  Widget? endDrawer(BuildContext context, AdaptiveSizingInfo sizingInfo);

  Widget getScaffold(
      {required BuildContext context,
      PreferredSizeWidget? glorifiAppBar,
      Color? backgroundColor,
      String? appBarTitle,
      required Widget body,
      Widget? bottomSheet,
      Widget? floatingActionButton,
      bool? resizeToAvoidBottomInset = true,
      bool isSimpleAppbar = false}) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      final _appBar = appBar(context, sizingInfo);
      final _bottomNavBar = bottomNavBar(context, sizingInfo);
      final _drawer = drawer(context, sizingInfo);
      final _endDrawer = endDrawer(context, sizingInfo);
      final mediaQuery = MediaQuery.of(context);
      return Scaffold(
        endDrawer: _endDrawer,
        appBar: getDeviceType(mediaQuery) == AdaptiveScreenType.nativeMobile
            ? glorifiAppBar
            : _appBar,
        body: body,
        bottomNavigationBar: _bottomNavBar,
        bottomSheet: bottomSheet,
        drawer: _drawer,
        backgroundColor: backgroundColor ?? Colors.white,
        floatingActionButton: floatingActionButton,
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      );
    });
  }
}

class AdaptiveScaffold extends StatelessWidget {
  AdaptiveScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.appBarTitle,
    this.bottomSheet,
    this.floatingActionButton,
    this.isSimpleAppBar = false,
    this.hideWebAppBar = false,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  PreferredSizeWidget? appBar;
  Color? backgroundColor;
  String? appBarTitle;
  Widget body;
  Widget? bottomSheet;
  Widget? floatingActionButton;
  bool isSimpleAppBar;
  bool hideWebAppBar;
  bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.deviceType == AdaptiveScreenType.nativeMobile) {
        return Container();
      } else {
        return Container();
      }
    });
  }
}



class _AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AdaptiveAppBar({
    Key? key,
    this.isSimpleAppbar = false,
    this.hideWebAppBar = false,
  }) : super(key: key);

  final bool isSimpleAppbar;
  final bool hideWebAppBar;

  @override
  Widget build(BuildContext context) {
    Widget _glorifiTextLogo = Image.asset(
      AppImages.settings,
      height: 26.h,
      width: 170.w,
    );

    Widget _menuIcon = GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: 24.sp,
      ),
    );

    Widget _supportIcon = Icon(
      Icons.messenger_outline,
      color: Colors.white,
      size: 27.5.sp,
    );

    Widget _profileIcon = GestureDetector(
      onTap: () => Scaffold.of(context).openEndDrawer(),
      child: Container(
        height: 32.sp,
        width: 32.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (hideWebAppBar) {
        return SizedBox.shrink();
      } else if (sizingInfo.deviceType == AdaptiveScreenType.desktop) {
        return Container(
          height: sizingInfo.screenSize.height,
          color: AppColors.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _glorifiTextLogo,

              isSimpleAppbar
                  ? SizedBox.shrink()
                  : Row(
                      children: [
                        _supportIcon,
                        SizedBox(width: 24.w),
                        _profileIcon,
                        SizedBox(width: 20.w),
                      ],
                    ),
            ],
          ),
        );
      } else if (sizingInfo.deviceType == AdaptiveScreenType.tablet) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          height: sizingInfo.screenSize.height,
          color: AppColors.backgroundColor,
          child: Row(
            children: [
              isSimpleAppbar ? SizedBox.shrink() : _menuIcon,
              const Spacer(),
              _glorifiTextLogo,
              const Spacer(),
              isSimpleAppbar ? SizedBox.shrink() : _supportIcon,
              SizedBox(width: 24.w),
              isSimpleAppbar ? SizedBox.shrink() : _profileIcon,
            ],
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          height: sizingInfo.screenSize.height,
          color: AppColors.backgroundColor,
          child: Row(
            children: [
              isSimpleAppbar ? SizedBox.shrink() : _menuIcon,
              const Spacer(),
              _glorifiTextLogo,
              const Spacer(),
              isSimpleAppbar ? SizedBox.shrink() : _supportIcon,
              SizedBox(width: 24.w),
              isSimpleAppbar ? SizedBox.shrink() : _profileIcon,
            ],
          ),
        );
      }
    });
  }

  @override
  Size get preferredSize => Size(1.sw, 56.h);
}



class _AdaptiveDrawer extends StatelessWidget {
  const _AdaptiveDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.deviceType == AdaptiveScreenType.desktop) {
          return Container();
        } else {
          return Container(
            color: AppColors.backgroundColor,
            width: 428.w,
            height: 1.sh,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 81.h,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 100.h),

                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}






