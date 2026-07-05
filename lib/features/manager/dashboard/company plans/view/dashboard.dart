import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/manager/dashboard/Departments/view/department.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/view/add_plan.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/view/company_plans.dart';
import 'package:recomind/features/team%20leader/dashboard/bloc/user_task_bloc.dart';
import 'package:recomind/features/team%20leader/dashboard/bloc/user_task_event.dart';
import 'package:recomind/features/team%20leader/dashboard/view/teamwork_view.dart';
import 'package:recomind/features/team%20leader/dashboard/data/team_work_repo.dart';

class CompanyPlansScreen extends StatefulWidget {
  const CompanyPlansScreen({super.key});

  @override
  State<CompanyPlansScreen> createState() => _CompanyPlansScreenState();
}

class _CompanyPlansScreenState extends State<CompanyPlansScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedFilterIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(12),
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFF67D8F8),
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: const Color(0xFF67D8F8),
                  unselectedLabelColor: const Color(0xFF8E9AA6),
                  labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'sans-serif'),
                  unselectedLabelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'sans-serif'),
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('My Work'))),
                    Tab(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('Team Work'))),
                  ],
                ),
                const Gap(20),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocProvider(
                        create: (context) => UserTasksBloc(UserTaskRepository())..add(FetchUserTasks()),
                        child: const MyWorkContent(),
                      ),
                      CompanyPlans(selectedFilterIndex: _selectedFilterIndex,),
                    ],
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}