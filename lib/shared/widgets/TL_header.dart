import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class TlHeader extends StatelessWidget {
  const TlHeader({super.key,required this.icon,this.onTab_setting});
final String? icon;
final Function()? onTab_setting ;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Gap(8),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
          },
          child: const CircleAvatar(
            backgroundColor: Color(0xFF151B29),
            radius: 28,
           backgroundImage: AssetImage("assets/Team_Leader/home/Ellipse 79 (1).png"),
          ),
        ),
        Gap(40),
        ///icon title
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Color(0xff2F3441),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/Team leader svg/star_svgrepo.com.svg"),
                      Gap(4),
                      customText(text: "Pro",fontweight: FontWeight.w400,textsize: 10,color: Colors.white,)

                    ],),
                )
              ],),
            SvgPicture.asset("assets/Team leader svg/recomind_title.svg"),
          ],
        ),
        Spacer(),
        IconButton(onPressed: onTab_setting, icon: SvgPicture.asset(icon!))
      ],
    );
  }
}
