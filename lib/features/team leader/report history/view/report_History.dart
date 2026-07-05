import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_model.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_reporistory.dart';
import 'package:recomind/features/team%20leader/report%20history/view/full_screen.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/drop_Down_History.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/history_card.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/search_widget.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import 'Expand.dart';



class ReportHistory extends StatefulWidget {
  const ReportHistory({super.key});

  @override
  State<ReportHistory> createState() => _ReportHistoryState();
}

class _ReportHistoryState extends State<ReportHistory> {
  bool isLoading = false ;
  reportRepo requestReport = reportRepo();
  late String teamid;
  List<SalesReportResponse> salesReports = [];
  Future<void> requestAnalysisTask() async {
    try {
      setState(() {
        isLoading = true ;
      });
      final task = await requestReport.user(
      );
      print(task);
      setState(() {
        isLoading = false ;
        teamid = task.teamId;
      });
      final response = await requestReport.getSalesReports(
          teamid);
      print(response);
      setState(() {
        salesReports = response;
      });
      print("this is team id ${teamid}");
    } on ApiError catch (e) {
      setState(() {
        isLoading = false ;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestAnalysisTask();
  }
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

           isLoading == true ? Center(child: SwappedShrinkingLoading(size: 50,strokeWidth: 5,),) : Column(
              children: List.generate(salesReports.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: HistoryCard(ontapExpand:(){Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreen(teamId: salesReports[index].teamId,taskId: salesReports[index].id,fixedText: salesReports[index].content,reportid: salesReports[index].id,),));} ,),
                );
              },),
            ),
          ],
        ),
      ),
    );
  }
}
