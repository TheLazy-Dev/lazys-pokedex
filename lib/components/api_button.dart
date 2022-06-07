import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ApiButton extends StatelessWidget {
  ApiButton(
      {Key? key, required this.color, required this.name, required this.path})
      : super(key: key);
  Color color;
  String name;
  Widget path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => path,
          ),
        );
      },
      child: SizedBox(
        height: 50.h,
        width: 140.w,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: color,
            image: DecorationImage(
                image: const AssetImage('assets/pokeball.png'),
                fit: BoxFit.fitHeight,
                scale: 0.5.sp,
                filterQuality: FilterQuality.high,
                opacity: 0.3,
                matchTextDirection: true,
                alignment: Alignment.topRight),
          ),
          child: Center(
            child: Text(name,
                style: GoogleFonts.poppins(
                  letterSpacing: 1.sp,
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black,
                )),
          ),
        ),
      ),
    );
  }
}
