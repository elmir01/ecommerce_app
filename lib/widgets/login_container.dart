import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginContainer extends StatelessWidget {
  Widget widget;
  LoginContainer({required this.widget});
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: widget,
      width: 344.sp,
      height: 49.sp,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 244, 244, 244),
        borderRadius: BorderRadius.all(Radius.circular(100))
      ),
    );
  }
}
