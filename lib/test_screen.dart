import 'package:flutter/cupertino.dart';
import 'package:screen_assignments/styling/app_colors.dart';
import 'package:screen_assignments/styling/font_style_globle.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("HAHAHAHAHA", style:regular10(color: AppColors.textBlack)),
    );
  }
}
