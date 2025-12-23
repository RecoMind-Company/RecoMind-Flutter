import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/admin/add%20team%20leader/view/markting_department.dart';
import 'package:recomind/features/admin/add%20team%20leader/view/no_team_leader.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/view/add_department.dart';
import 'package:recomind/features/admin/company%20members%20&%20DB/widget/card_Department.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Model.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Repo.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DepartmentsView extends StatefulWidget {
  const DepartmentsView({super.key});

  @override
  State<DepartmentsView> createState() => _DepartmentsViewState();
}

class _DepartmentsViewState extends State<DepartmentsView> {
  final TeamRepo teamRepo = TeamRepo();
  List<TeamNameModel> teams = [];
  late dynamic lenth ;
  Future<void> getTeams() async {
    try {
      final result = await teamRepo.getTeamNames();
      setState(() {
        teams = result ?? [];
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  @override
  Widget build(BuildContext context) {

    if(teams.isEmpty){
      lenth = 3;
    }else{
      lenth = teams.length;
    }
    return Skeletonizer(
      enabled: teams.isEmpty,
      child: Column(
        children: [
          Gap(32),
          Expanded(
            child: ListView.builder(
              itemCount: lenth,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0 , horizontal: 8),
                  child: CardDepartment(
                    Name: teams.isEmpty?"Marketing":teams[index].name ,
                    ontap: () {},
                    number:teams.isEmpty?"0": teams[index].teamLeadId == null ? "0" : "1",
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDepartment()),
              );
            },
            child: Container(
              height: 44,
              width: 212,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.plus, color: Colors.black),
                  Gap(8),
                  customText(
                    text: "Add Department",
                    fontweight: FontWeight.w400,
                    textsize: 14,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Gap(60),
        ],
      ),
    );
  }
}
