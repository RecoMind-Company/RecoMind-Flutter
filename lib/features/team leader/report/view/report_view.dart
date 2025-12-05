import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/invite%20Admin/view/invite_view.dart';
import 'package:recomind/features/team%20leader/report%20history/view/Lastest_report.dart';
import 'package:recomind/features/team%20leader/report%20history/view/report_History.dart';
import 'package:recomind/features/team%20leader/report/widget/Category_button.dart';
import 'package:recomind/features/team%20leader/report%20history/widget/search_widget.dart';
import 'package:recomind/shared/widgets/TL_header.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  int currentpage = 0;

  late PageController controller;
  bool lastestReport = true;
  bool historyReport = false;
  late List<Widget> pages;

  @override
  void initState() {
    controller = PageController(initialPage: currentpage);
     pages = [
       LastestReport(),
       ReportHistory(),
    ];
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(

        body: Containerwid(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Gap(70),

              ///header team leader
              TlHeader(icon: "assets/Team leader svg/report_setting.svg",),
              Gap(24),

              ///Category
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CategoryButton(ontap:(){
                    setState(() {
                      currentpage = 0 ;
                      lastestReport = true;
                      historyReport = false;
                    });
                    controller.jumpToPage(currentpage);
                  },
                  color: lastestReport?Color(0xFF1E394D):Colors.transparent,text: "Lastest Report",borderColor: lastestReport?Color(0xFF1E394D):Colors.white,),
                  Gap(12),
                  CategoryButton(ontap:(){
                    setState(() {
                      currentpage = 1;
                      lastestReport = false;
                      historyReport = true;
                    });
                    controller.jumpToPage(currentpage);
                  },
                    color: historyReport?Color(0xFF1E394D):Colors.transparent,text: "Report History",borderColor: historyReport?Color(0xFF1E394D):Colors.white,),
                ],
              ),
              Gap(32),

              ///body
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentpage = index;
                      lastestReport = index == 0;
                      historyReport = index == 1;
                    });
                  },
                  children: pages,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
