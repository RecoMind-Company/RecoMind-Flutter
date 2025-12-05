import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/report%20history/view/generate_report_view.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/drop_Down_History.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/history_card.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/lastest_card.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/search_widget.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../widget/generate_report_button.dart';
import 'Expand.dart';



class LastestReport extends StatelessWidget {
  const LastestReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                customText(text: "Your Ongoing Insights",fontweight: FontWeight.w500,textsize: 20,color: Colors.white,),
              ],
            ),
            Gap(2),
            Row(
              children: [
                customText(text: "Delivered automatically, tailored to your goals",fontweight: FontWeight.w500,textsize: 14,color: Color(0xFFB5B5B5),),
              ],
            ),
            Gap(32),
            LastestCard(ontapExpand:(){Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandScreen(),));} ,)
            ,Gap(160),
            GenerateReportButton(ontapExpand:(){Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateReportView(),));} ,),



          ],
        ),
      ),
    );
  }
}
