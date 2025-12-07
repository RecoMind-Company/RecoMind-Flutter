import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_reporistory.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/diver_wid.dart';

class ExpandScreen extends StatefulWidget {
  const ExpandScreen({super.key, this.taskId});
 final String? taskId ;
  @override
  State<ExpandScreen> createState() => _ExpandScreenState();
}

class _ExpandScreenState extends State<ExpandScreen> {
  /// get report
  reportRepo resultrepo = reportRepo();
  Future<void> getResult ()async {
    try {
      final result = await resultrepo.getReportResult("${widget.taskId}");
      print("TASK ID = ${result.taskId}");
      print("Status = ${result.status}");
    } on ApiError catch (e) {
      print("Error: ${e.message}");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResult ();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Gap(90),
              Row(
                children: [
                  Gap(5),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
              Gap(40),

              /// title
              Row(
                children: [
                  customText(
                    text: "Your insights and action plan are\nready",
                    textsize: 20,
                    fontweight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ],
              ),
              Gap(16),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 505,
                  width: double.infinity,
                  decoration: BoxDecoration(
                   color:AppColor.darkBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              ///Divider

            ],
          ),
        ),
      )),
    );
  }
}
