import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_repository.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/dropDown.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/data/review_repo.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/DB_info.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/com_info.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/department.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/edit_button.dart';
import 'package:recomind/features/auth/sign%20up%20views/robot%20&&%20department/view/start_AI_processing.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/Cubit/company_setup_3_cubit.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Model.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Repo.dart';
import 'package:recomind/shared/widgets/show_dialog_comInfo.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/title_Text_Field.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../plan & complete/view/plan.dart';
import '../widget/show_dialog_dep.dart';

class ReviewAllSetup extends StatefulWidget {
  ReviewAllSetup({super.key,this.dbList});
DBModel? dbList;
  @override
  State<ReviewAllSetup> createState() => _ReviewAllSetupState();
}

class _ReviewAllSetupState extends State<ReviewAllSetup> {
  final List depList = ['Sales', 'marketing', 'Sales'];
  final ValueNotifier<String?> _selectedCountryNotifier =
      ValueNotifier<String?>("EGYPT");
late bool isclicked_info ;
late bool isclicked_dep ;
late bool click_more = false;
DBModel dbModel = DBModel();

  reviewRepo review = reviewRepo();
/// review Company setup
  SetupRepository authRepo = SetupRepository();
   setupModel? getSetup;
  bool isLoading = false ;
  /// get setup
  Future<void> getsetupdata() async {
    try {
      final user = await authRepo.getSetup();
      setState(() {
        getSetup = user;
      });
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    }
  }

  //===================department===================
  // ================= GET TEAMS =================
  final TeamRepo teamRepo = TeamRepo();
  List<TeamNameModel> teams = [];

  Future<void> getTeams() async {
    try {

      final result = await teamRepo.getTeamNames();
      teams = result ?? [];

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ///review DB
  Future<void> getDB() async {
    try {
      final userlist = await review.getDB();

      if (userlist != null) {
        dbModel = userlist;
        print(dbModel.id);
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No data returned from server"),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print("Unexpected error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unexpected error occurred"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
Future<void> refresh ()async{
    try{
      await review.refresh();
    }on ApiError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      print("Unexpected error: $e");
    }
    }
  @override
  void initState() {
     isclicked_info=false ;
     isclicked_dep= false;
    // TODO: implement initState
    super.initState();
     getDB();
     getsetupdata();
     getTeams();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.greenAccent,
      backgroundColor: AppColor.primaryColor,
      onRefresh: () async {
        await getDB();
      },
      child: Scaffold(
        body: Skeletonizer(
          enabled: getSetup == null ? true : false,
          child: Stack(
            children: [
              Containerwid(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(70),

                      ///title
                      customText(
                        text: "Review Setup",
                        fontweight: FontWeight.w400,
                        textsize: 28,
                        color: Color(0xFFEEEEEE),
                      ),
                      Gap(10),

                      ///subtitle
                      Row(
                        children: [
                          customText(
                            text:
                                "Check your company details before completing\nthe setup.",
                            fontweight: FontWeight.w400,
                            textsize: 13,
                            color: Color(0xFFEEEEEE),
                            iscenter: false,
                          ),
                        ],
                      ),
                      Gap(20),

                      ///Company info
                      Skeletonizer(
                        enabled: isLoading == true ? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText(
                              text: "Company info",
                              textsize: 20,
                              fontweight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            EditButton(
                              ontap: () {
                                setState(() {
                                  isclicked_info = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Gap(15),

                      ///info
                      Skeletonizer(
                        enabled: isLoading == true ? true : false,
                        child: ComInfo(
                          title: "company Name",
                          name: getSetup?.name ??"CName",
                        ),
                      ),
                      ComInfo(
                        title: "Industry",
                        name: getSetup?.industry??"Software Development",
                      ),
                      ComInfo(
                        title: "Country",
                        name: getSetup?.country??"Egypt",
                      ),
                      ComInfo(
                        title: "Company Size",
                        name: "200 - 500", //////////// this code ///////////
                      ),
                      Row(
                        children: [
                          customText(
                            text: "Company Description",
                            fontweight: FontWeight.w400,
                            textsize: 12,
                            color: Color(0xFFB5B5B5),
                          ),
                        ],
                      ),
                      Gap(4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                            text: getSetup?.description ?? "",
                            fontweight: FontWeight.w400,
                            textsize: 12,
                            color: const Color(0xFFEEEEEE),
                            iscenter: false,
                          ),
                        ],
                      ),
                      Gap(24),
                      Divider(
                        color: Color(0xFF03294A),
                        thickness: 1,
                      ),
                      Gap(24),

                      ///DEPARTMENT
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: "Department",
                            textsize: 20,
                            fontweight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          EditButton(
                            ontap: () {setState(() {
                              isclicked_dep = !isclicked_dep;
                            });},
                          ),
                        ],
                      ),
                      Gap(15),
                      Department(
                        isclicked: click_more,
                        depList:teams,
                      ),
                      Gap(12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                click_more = !click_more ;
                              });
                            },
                            child: customText(
                              text: teams.length <= 3 ? "":click_more==true ? "less departments":"+${teams.length-3} more departments",
                              color: AppColor.primaryColor,
                              fontweight: FontWeight.w400,
                              textsize: 12,
                            ),
                          ),
                        ],
                      ),
                      Gap(24),
                      Divider(
                        color: Color(0xFF03294A),
                        thickness: 1,
                      ),
                      Gap(24),

                      ///DB_Setup
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customText(
                            text: "Database Setup",
                            textsize: 20,
                            fontweight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          EditButton(
                            ontap: () {},
                          ),
                        ],
                      ),
                      Gap(15),
                      DbInfo(title: "Server", name: dbModel.server ?? "sales"),
                      Gap(8),
                      Divider(
                        color: Color(0xFF03294A),
                        thickness: 1,
                      ),
                      Gap(8),
                      DbInfo(title: "Database Name", name: dbModel.dbName ?? "sales"),
                      Gap(8),
                      Divider(
                        color: Color(0xFF03294A),
                        thickness: 1,
                      ),
                      Gap(8),
                      DbInfo(title: "User ID", name: dbModel.user ?? ""),
                      Gap(32),

                      ///button
                      button(
                          onPressed: () {
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartAiProcessing(),));
                           refresh ();
                          },
                          color: AppColor.primaryColor,
                          borderColor: AppColor.primaryColor,
                          buttonText: "Finish Setup",
                          textColor: Colors.black),
                      Gap(30)
                    ],
                  ),
                ),
              )),
              isclicked_info == true
                  ?
              ShowDialogCominfo(
                      ontap: () {
                        setState(() {
                          isclicked_info = false;
                        });
                        getsetupdata();
                      },
                    ): const SizedBox.shrink(),
      isclicked_dep == true
          ? BlocProvider(
        create: (_) => CompanySetup3Cubit(teamRepo)..getTeams(),
        child: ShowDialogComDep(
          list: teams,
          ontap: () {
            setState(() {
              isclicked_dep = false;
            });
            getTeams(); // علشان نعمل refresh بعد add / delete
          },
        ),
      )
          : const SizedBox.shrink(),

            ],
          ),
        ),
      ),
    );
  }
}
