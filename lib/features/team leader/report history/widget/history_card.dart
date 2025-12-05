import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key,required this.ontapExpand});
final Function()? ontapExpand;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      height: 293,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: AlignmentGeometry.centerRight,end: AlignmentGeometry.centerLeft,colors: [Color(0xFFA6ECFF),Color(0xFF50D9FF)]),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: CupertinoColors.inactiveGray,width: 1)
      ),
      child: Column(
        children: [
          ///image
          Container(
            padding: EdgeInsets.symmetric(horizontal: 26,vertical: 24),
            height: 242,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(image: AssetImage("assets/Team_Leader/write_pic.png"),fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.only(topRight:Radius.circular(15),topLeft:Radius.circular(10) ),
                border: Border.all(color: CupertinoColors.inactiveGray,width: 1)
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){},
                    child: Container(
                        width: 44,
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: AlignmentGeometry.centerRight,end: AlignmentGeometry.centerLeft,colors: [Color(0xFFA6ECFF),Color(0xFF50D9FF)]),
                            borderRadius: BorderRadius.circular(13)
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(FontAwesomeIcons.download,color: Color(0xFF1C274C),)])
                    )
                ),
                GestureDetector(
                    onTap: ontapExpand,
                    child: Container(
                        width: 110,
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: AlignmentGeometry.centerRight,end: AlignmentGeometry.centerLeft,colors: [Color(0xFFA6ECFF),Color(0xFF50D9FF)]),
                            borderRadius: BorderRadius.circular(13)
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [customText(text: "Expand",fontweight: FontWeight.w400,textsize: 14,color:Color(0xFF1C274C) ,),SvgPicture.asset("assets/Team leader svg/zoom.svg")])
                    )
                )
              ],),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                customText(text: "Insights with Plan",textsize: 14,fontweight: FontWeight.w400,),
                customText(text: "Report Date : Oct 01, 2025",textsize: 10,fontweight: FontWeight.w500,),

              ],),
          )

        ],
      ),

    );
  }
}
