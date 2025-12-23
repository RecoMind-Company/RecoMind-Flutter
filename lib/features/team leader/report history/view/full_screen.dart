import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team leader/report history/data/report_reporistory.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key, this.taskId , this.teamId , this.fixedText});
  final String? taskId;
  final String? teamId;
 final String? fixedText;
  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  String? fixedText;
  bool isLoading = false;
  reportRepo resultrepo = reportRepo();

  Future<void> getResult() async {
    try {
      setState(() => isLoading = true);

      final result = await resultrepo.getReportResult(
          widget.teamId,widget.taskId

      );

      fixedText = result.aiResponse?.replaceAll(RegExp(r'\\\\n'), r'\n');

      setState(() => isLoading = false);
    } on ApiError catch (e) {
      setState(() => isLoading = false);
      print("Error: ${e.message}");
    }
  }

  @override
  void initState() {
    super.initState();
    // getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(20),
                  /// Back button
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  Gap(30),

                  /// Content
                  isLoading
                      ? Center(
                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                        customText(
                          text: "Report is loading please wait ...",
                          color: AppColor.primaryColor,
                          fontweight: FontWeight.bold,
                          textsize: 20,
                        ),
                        Gap(20),
                        CupertinoActivityIndicator(
                          color: AppColor.primaryColor,
                          radius: 20,
                        )
                                            ],
                                          ),
                      )
                      : Markdown(
                    data: widget.fixedText ?? "",
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    styleSheet: MarkdownStyleSheet(
                      h1: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                      h2: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      h3: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      h4: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      h5: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      h6: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      p: TextStyle(
                          color: Colors.white, fontSize: 16),
                      listBullet: TextStyle(
                          color: Colors.white, fontSize: 16),
                      blockSpacing: 10.0,
                      listIndent: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
