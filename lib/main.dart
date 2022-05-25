import 'package:screen_assignments/styling/adaptive/adaptive_screen_type.dart';
import 'package:screen_assignments/styling/app_colors.dart';
import 'package:screen_assignments/styling/responsive_util_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_assignments/test_screen.dart';
import 'styling/adaptive/adaptive_base_widget.dart';

void main() {
  final systemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: AppColors.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: AppColors.backgroundColor,
    statusBarIconBrightness: Brightness.dark,
  );
  SystemChrome.setSystemUIOverlayStyle(systemTheme);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    // Get.put(MemberController());

    var theme = ThemeData(
        primaryColor: AppColors.textBlack,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppColors.textBlack),
        textTheme:
            const TextTheme(bodyMedium: TextStyle(color: AppColors.textBlack)));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return ResponsiveUtilInit(
              designSize: sizingInfo.deviceType == AdaptiveScreenType.desktop
                  ? Size(1440, 1024)
                  : sizingInfo.deviceType == AdaptiveScreenType.nativeMobile
                      ? Size(390, 844)
                      : sizingInfo.deviceType == AdaptiveScreenType.webMobile
                          ? Size(428, 844)
                          : Size(752, 1280),
              builder: () => SafeArea(
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: theme,
                      home: TestScreen(),
                    ),
                  ));
        },
      ),
    );
  }
}
