import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/Home_admin/view/home_view_admin.dart';
import 'package:recomind/features/admin/company%20Admin/view/company_view.dart';
import 'package:recomind/features/admin/invite%20Admin/view/invite_view.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/view/home_TL_view.dart';
import 'package:recomind/features/team%20leader/chat_bot/view/chat_bot_view.dart';
import 'package:recomind/features/team%20leader/report/view/report_view.dart';

class root extends StatefulWidget {
  const root({super.key});

  @override
  State<root> createState() => _rootState();
}

class _rootState extends State<root> {
  int currentpage = 0;

  late PageController controller;

  late List<Widget> pages;
  bool Admin = false;
  @override
  void initState() {
    controller = PageController(initialPage: currentpage);

     Admin == true?
         ///Admin
     pages = [
      HomeViewAdmin(),
      InviteView(),
      CompanyView(),]
     /// team leader
         : pages = [
       HomeTlView(),
       ChatBotView(),
       ReportView(),
       CompanyView(),
    ];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PageView(
          controller: controller,
          children: pages,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Color(0xFF060B1B), boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 1,
            )
          ]),

          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory:
                  NoSplash.splashFactory,
            ),
            child: Admin == true ?
            BottomNavigationBar(
              currentIndex: currentpage,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedItemColor: AppColor.primaryColor,
              unselectedItemColor: AppColor.primaryColor,
              enableFeedback: false,
                items:[

                /// first
                BottomNavigationBarItem(
                    icon: Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
              width: 60,
              height: 32,
              decoration: BoxDecoration(
                color: currentpage == 0 ? const Color(0xff7EE3FF) : Color(0xff070C1E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset("assets/Home/SVG_Icon/Default.svg" , color: currentpage != 0? AppColor.primaryColor:Color(0xff060B1B),)), label: "Home"),

                /// second
                BottomNavigationBarItem(
                  icon: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      width: 60,
                      height: 32,
                      decoration: BoxDecoration(
                        color: currentpage == 1
                            ? const Color(0xff7EE3FF)
                            : Color(0xff070C1E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                          "assets/Home/SVG_Icon/Email.svg",
                          color: currentpage != 1
                              ? AppColor.primaryColor
                              : Color(0xff060B1B))),
                  label: "Invites",
                ),

                ///third
                BottomNavigationBarItem(
                  icon: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      width: 60,
                      height: 32,
                      decoration: BoxDecoration(
                        color: currentpage == 2 ? const Color(0xff7EE3FF) : Color(0xff070C1E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset("assets/Home/SVG_Icon/company.svg" , color: currentpage != 2? AppColor.primaryColor:Color(0xff060B1B),)),
                  label: "Company",
                ),

              ],
              onTap: (v) {
                setState(() {
                  currentpage = v;
                });
                controller.jumpToPage(currentpage);
              },
            ):
            BottomNavigationBar(
              currentIndex: currentpage,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedItemColor: AppColor.primaryColor,
              unselectedItemColor: AppColor.primaryColor,
              enableFeedback: false,
              items:[

                /// first
                BottomNavigationBarItem(
                    icon: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        width: 60,
                        height: 32,
                        decoration: BoxDecoration(
                          color: currentpage == 0 ? const Color(0xff7EE3FF) : Color(0xff070C1E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset("assets/Home/SVG_Icon/Default.svg" , color: currentpage != 0? AppColor.primaryColor:Color(0xff060B1B),)), label: "Home"),
                /// second
                BottomNavigationBarItem(
                    icon: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        width: 60,
                        height: 32,
                        decoration: BoxDecoration(
                          color: currentpage == 1 ? const Color(0xff7EE3FF) : Color(0xff070C1E),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset("assets/Team_Leader/home/robot.svg" , color: currentpage != 1? AppColor.primaryColor:Color(0xff060B1B),)), label: "Chatbot"),
                ///third
                BottomNavigationBarItem(
                  icon: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      width: 60,
                      height: 32,
                      decoration: BoxDecoration(
                        color: currentpage == 2
                            ? const Color(0xff7EE3FF)
                            : Color(0xff070C1E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                          "assets/Team leader svg/report_icon.svg",
                          color: currentpage != 2
                              ? AppColor.primaryColor
                              : Color(0xff060B1B))),
                  label: "Report",
                ),
                ///fourth
                BottomNavigationBarItem(
                  icon: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      width: 60,
                      height: 32,
                      decoration: BoxDecoration(
                        color: currentpage == 3 ? const Color(0xff7EE3FF) : Color(0xff070C1E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset("assets/Team leader svg/Team_icon.svg" , color: currentpage != 3? AppColor.primaryColor:Color(0xff060B1B),)),
                  label: "Team",
                ),

              ],
              onTap: (v) {
                setState(() {
                  currentpage = v;
                });
                controller.jumpToPage(currentpage);
              },
            )
          ),
        ),
      ),
    );
  }
}
