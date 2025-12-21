import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/Cubit/company_setup_3_cubit.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/Cubit/company_setup_3_state.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/data/team_Repo.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/view/company_setup_4.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/enter_department.dart';
import 'package:recomind/features/auth/sign%20up%20views/company%20setup/widgets/header_all_company.dart';
import 'package:recomind/features/auth/sign%20up%20views/teams/widget/department_card.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class CompanySetup3 extends StatefulWidget {
  const CompanySetup3({super.key});

  @override
  State<CompanySetup3> createState() => _CompanySetup3State();
}

class _CompanySetup3State extends State<CompanySetup3> {
  final TextEditingController controller = TextEditingController();
  final int Pagenumber = 2;


  @override
  void initState() {
    super.initState();
  }

  void addTeam() {
    if (controller.text.trim().isEmpty) return;

    context.read<CompanySetup3Cubit>().addTeam(
      controller.text.trim(),
    );

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0077A8),
              Color(0xFF003B57),
              Color(0xFF060B1B),
            ],
            stops: [0.0001, 0.02, 0.20],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            HeaderAllCompany(Pagenumber: Pagenumber),
            const Gap(32),

            /// Title
            customText(
              text: "Add Department to Company",
              color: Colors.white,
              textsize: 16,
              fontweight: FontWeight.w400,
            ),
            const Gap(8),

            /// Add Department Field
            EnterDepartment(
              Controller: controller,
              isLoading: false,
              onTap: addTeam,
            ),
            const Gap(24),



            /// Departments List
            BlocConsumer<CompanySetup3Cubit, CompanySetup3State>(
              listener: (context, state) {
                if (state is CompanySetup3Error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CompanySetup3Loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (state is CompanySetup3Success) {

                  return GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero, // مهم جدًا
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.teams.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,        // عنصرين في السطر
                      crossAxisSpacing: 20,      // مسافة أفقية
                      mainAxisSpacing: 12,       // مسافة رأسية
                      childAspectRatio: 2.8, // تحكمي في ارتفاع الكارت
                    ),
                    itemBuilder: (context, index) {
                      final team = state.teams[index];
                      return DepartmentCard(
                        name: team.name,
                        onTap: () {
                          context.read<CompanySetup3Cubit>().deleteTeam(team.id);
                        },
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),

            Gap(24),
            /// Next Button
            button(
              color: AppColor.primaryColor,
              buttonText: "Next",
              textColor: Colors.black,
              borderColor: AppColor.primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CompanySetup4(),
                  ),
                );
              },
            ),

            const Gap(16),

            /// Back Button
            button(
              color: const Color(0xFF060B1B),
              buttonText: "Back",
              textColor: AppColor.primaryColor,
              borderColor: AppColor.primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
