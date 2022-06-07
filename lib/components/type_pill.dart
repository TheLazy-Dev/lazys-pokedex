import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/components/color_lib.dart';
import 'package:pokedex/models/pokemon_model.dart';

class TypePill extends StatelessWidget {
  TypePill({Key? key, required this.type, required this.color})
      : super(key: key);
  String type;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30.h,
        width: 100.w,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
                type.replaceFirst(
                    type.substring(0, 1), type.substring(0, 1).toUpperCase()),
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(17))),
          ),
        ),
      ),
    );
  }
}
