import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shik_i_blisk/constants/app_colors.dart';
import 'package:shik_i_blisk/constants/app_styles.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(child: Text('ШИК І БЛИСК', style: text(24.sp,fw: FontWeight.bold, color: kWhiteColor),),)
    );
  }
}
