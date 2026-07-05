import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/admin/company%20Admin/widget/com_info_admin.dart';
import 'package:recomind/features/admin/company%20Admin/widget/show_dialog_admin.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/database_setup.dart';
import 'package:recomind/features/admin/profile/view/profile_view.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_model.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/data/company_repository.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/data/review_repo.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/com_info.dart';
import 'package:recomind/features/auth/sign%20up%20views/review%20setup/widget/edit_button.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_bloc.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_repo.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/admin_head.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/show_notification_TL.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/show_dialog_comInfo.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../company members & DB/view/company_members.dart';



class CompanyView extends StatefulWidget {
  const CompanyView({super.key});

  @override
  State<CompanyView> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyView> {
 bool isclicked_info = false;
 bool notification = false;


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

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsetupdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Skeletonizer(
            enabled: getSetup == null ? true : false,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0077A8),
                    Color(0xFF003B57),
                    Color(0xFF060B1B),
                  ],
                  stops: [0.0001, 0.02, 0.120],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Gap(70),

                  // Header
                AdminHead(ontap: (){setState(() {
                  notification = !notification;
                });},),

                  Gap(50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(children: [
                      Row(
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
                      Gap(16),

                      ///info
                      ComInfoAdmin(
                        title: "company Name",
                        name: getSetup?.name ?? "CName",
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

                        Row(
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

                      Gap(16)
                      ,
                      ComInfoAdmin(
                        title: "Industry",
                        name:getSetup?.industry ?? "Software Development",
                      ),
                      ComInfoAdmin(
                        title: "Country",
                        name: getSetup?.country??"Egypt",
                      ),
                      ComInfoAdmin(
                        title: "Company Size",
                        name: getSetup?.size ?? "200 - 500",
                      ),
                      Gap(32),

                      ///DB setup
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseSetup(),));
                        },
                        child: Container(
                          height: 48,
                          width: 343,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                               Icon(FeatherIcons.database , color: Color(0xFFEEEEEE),),
                              Gap(23),
                              customText(text: "Database Setup",textsize: 18,fontweight: FontWeight.w500,color: Color(0xFFFFFFFF),),
                              Spacer(),
                              SvgPicture.asset("assets/Home/next.svg")
                            ],
                          ),
                        ),
                      ) ,
                      Gap(32),


                      ///Members
                      GestureDetector(
                        onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyMembers()));
                      },
                        child: Container(
                          height: 48,
                          width: 343,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/Home/SVG_Icon/members.svg"),
                              Gap(23),
                              customText(text: "Members",textsize: 18,fontweight: FontWeight.w500,color: Color(0xFFFFFFFF),),
                              Spacer(),
                              SvgPicture.asset("assets/Home/next.svg")
                            ],
                          ),
                        ),
                      )


                    ],),
                  ),
                ],
              ),
            ),
          ),
          isclicked_info == true ? ShowDialogCominfo(ontap: (){setState(() {
            isclicked_info = false;
          });},):customText(text: ""),
          if (notification)
            Positioned.fill(
              child: Material(
                color: Colors.black.withOpacity(0.5),
                child: BlocProvider(
                  create: (context) =>
                      NotificationBloc(NotificationRepository()),
                  child: ShowNotificationTl(
                    cancel: () {
                      setState(() {
                        notification = false;
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
