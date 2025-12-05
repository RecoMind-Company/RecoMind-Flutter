import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/drop_Down_History.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/history_card.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/search_widget.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import 'Expand.dart';



class ReportHistory extends StatelessWidget {
  const ReportHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchWidget(),
            Gap(32),
            Row(
              children: [
                DropDownHistory(selected:ValueNotifier('All reports') ,),
              ],
            ),
            Gap(16),
        
        
        
            ///Card
            HistoryCard(ontapExpand:(){Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandScreen(),));} ,),
            Gap(32),
            HistoryCard(ontapExpand:(){Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandScreen(),));} ,),
            Gap(32),
            HistoryCard(ontapExpand:(){Navigator.push(context, MaterialPageRoute(builder: (context) => ExpandScreen(),));} ,),
          ],
        ),
      ),
    );
  }
}
