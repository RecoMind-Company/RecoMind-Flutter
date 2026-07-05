import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/dashboard/bloc/user_task_bloc.dart';
import 'package:recomind/features/team%20leader/dashboard/bloc/user_task_event.dart';
import 'package:recomind/features/team%20leader/dashboard/bloc/user_task_state.dart';
import 'package:recomind/features/team%20leader/dashboard/data/team_work_model.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  DateTime _selectedDate = DateTime.now();
  List<UserTaskModel> _filteredTasks = [];
  List<UserTaskModel> _allTasks = [];

  @override
  void initState() {
    super.initState();
    context.read<UserTasksBloc>().add(FetchUserTasks());
  }

  void _updateFilter(List<UserTaskModel> allTasks, DateTime day) {
    if (!mounted) return;
    setState(() {
      _allTasks = allTasks;
      _selectedDate = day;
      _filteredTasks = allTasks.where((task) {
        DateTime start = DateTime.parse(task.startDate);
        return start.year == day.year &&
            start.month == day.month &&
            start.day == day.day;
      }).toList();
    });
  }

  Future<void> _showCalendarDialog() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2026, 12, 31),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF67D8F8),
              onPrimary: Colors.black,
              surface: Color(0xFF111625),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF67D8F8)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _updateFilter(_allTasks, picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserTasksBloc, UserTasksState>(
      listener: (context, state) {
        if (state is UserTasksLoaded) {
          _updateFilter(state.tasks, _selectedDate);
        }
      },
      child: Column(
        children: [
          /// ==========================================
          /// 📅 Date Picker Row
          /// ==========================================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    color: Colors.white, size: 18),
                const Gap(8),
                Text(DateFormat('d MMMM yyyy').format(_selectedDate),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                    onPressed: _showCalendarDialog,
                    icon: const Icon(Icons.date_range,
                        color: Color(0xFF67D8F8))),
              ],
            ),
          ),

          /// ==========================================
          /// 🗓️ Horizontal Days Scroller
          /// ==========================================
          SizedBox(
            height: 65,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: DateTime(
                  _selectedDate.year, _selectedDate.month + 1, 0)
                  .day,
              itemBuilder: (context, index) {
                DateTime date = DateTime(
                    _selectedDate.year, _selectedDate.month, index + 1);
                bool isSelected = _selectedDate.day == date.day &&
                    _selectedDate.month == date.month &&
                    _selectedDate.year == date.year;
                return GestureDetector(
                  onTap: () => _updateFilter(_allTasks, date),
                  child: Container(
                    width: 65,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B313E),
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(
                          color: AppColor.primaryColor, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('E').format(date),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        const Gap(4),
                        Text("${date.day}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        const Gap(4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.red
                                      : Colors.transparent,
                                  shape: BoxShape.circle),
                            ),
                            const Gap(2),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColor.primaryColor
                                      : Colors.transparent,
                                  shape: BoxShape.circle),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const Gap(10),

          /// ==========================================
          /// 📝 Tasks List Builder
          /// ==========================================
          Expanded(
            child: BlocBuilder<UserTasksBloc, UserTasksState>(
              builder: (context, state) {
                if (state is UserTasksLoading) {
                  return const Center(
                      child: SwappedShrinkingLoading(
                        size: 50,
                        strokeWidth: 5,
                      ));
                }
                if (_filteredTasks.isEmpty) {
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/Team_Leader/cup.svg",
                            height: 169,
                          ),
                          const Gap(15),
                          customText(
                            text: "All caught up for today!",
                            fontweight: FontWeight.w700,
                            textsize: 16,
                            color: AppColor.primaryColor,
                          ),
                          const Gap(3),
                          customText(
                            text:
                            "Your to-do list is sparkling clean.\n Time to recharge for tomorrow.",
                            fontweight: FontWeight.w400,
                            textsize: 16,
                            color: Colors.white,
                          ),
                          const Gap(60)
                        ],
                      ));
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 80), // بادينج إضافي بالأسفل عشان الكروت متختفيش ورا الزرار الثابت
                  itemCount: _filteredTasks.length,
                  separatorBuilder: (_, __) => const Gap(12),
                  itemBuilder: (_, index) =>
                      _buildTaskCard(_filteredTasks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(UserTaskModel task) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141A2B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${task.title}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFFB1B1B1)),
                ),
                Text("${task.description}",
                    style: const TextStyle(color: Color(0xFF8F9BB3), fontSize: 12)),
                const Gap(12),
                Container(
                  width: 263,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF212636),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                          radius: 8, backgroundColor: Colors.redAccent),
                      const Gap(8),
                      Text("Deadline: ${task.deadline.substring(0, 10)}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}