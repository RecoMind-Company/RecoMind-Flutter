import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/view/company_plans.dart';
import 'package:recomind/root.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/task_update_event.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/task_update_bloc.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/bloc_update_state.dart';

import '../../dashboard/widget/add_members.dart';

class GeneratedPlanScreen extends StatefulWidget {
  final PlanResponse plan;

  const GeneratedPlanScreen({super.key, required this.plan});

  @override
  State<GeneratedPlanScreen> createState() => _GeneratedPlanScreenState();
}

class _GeneratedPlanScreenState extends State<GeneratedPlanScreen> {
  int _selectedModuleIndex = 0;
  bool _isDispatchedLoading = false;
  final PlanRepository _planRepository = PlanRepository();

  void _showCalendarPicker(
      BuildContext context, TextEditingController controller) {
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF060B1B),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: focusedDay,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selected, focused) {
                  setModalState(() {
                    selectedDay = selected;
                    focusedDay = focused;
                  });
                },
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                      color: Color(0xFF7DD9FF), shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(
                      color: Colors.white24, shape: BoxShape.circle),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white54),
                ),
                headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon:
                    Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                    Icon(Icons.chevron_right, color: Colors.white),
                    titleTextStyle:
                    TextStyle(color: Colors.white, fontSize: 16)),
              ),
              const Gap(20),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                      context: context, initialTime: selectedTime);
                  if (picked != null) {
                    setModalState(() => selectedTime = picked);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: const Color(0xFF131A2A),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(selectedTime.format(context),
                        style:
                        const TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
              const Gap(20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.text =
                    "${selectedDay.toString().split(' ')[0]} ${selectedTime.format(context)}";
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7DD9FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text("Save",
                      style: TextStyle(color: Color(0xFF060B1B))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditTaskBottomSheet(BuildContext context, PlanTask task) {
    final TextEditingController titleController = TextEditingController(text: task.title);
    final TextEditingController descController = TextEditingController(text: task.description);
    final TextEditingController startController = TextEditingController(text: task.startDate);
    final TextEditingController deadlineController = TextEditingController(text: task.deadlineDate);

    // ✅ تهيئة القائمة بالـ User ID الحالي للتاسك إن وجد لتجنب إرسال قائمة فارغة
    List<String> selectedUserIds = task.suggestedOwner.userId.isNotEmpty
        ? [task.suggestedOwner.userId]
        : [];

    final taskBloc = context.read<TaskUpdateBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider.value(
        value: taskBloc,
        child: BlocListener<TaskUpdateBloc, TaskUpdateState>(
          listener: (context, state) {
            if (state is TaskUpdateSuccess) {
              setState(() {
                task.title = titleController.text;
                task.description = descController.text;
                task.startDate = startController.text.split(' ')[0];
                task.deadlineDate = deadlineController.text.split(' ')[0];
              });
              Navigator.pop(modalContext);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task Updated Successfully")));
            }
            else if (state is TaskDeleteSuccess) {
              setState(() {
                for (var module in widget.plan.modules) {
                  module.tasks.removeWhere((t) => t.taskId == task.taskId);
                }
              });

              Navigator.pop(modalContext);

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Task Deleted Successfully"), backgroundColor: Colors.red));

              setState(() {});
            }
            else if (state is TaskUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${state.error}"), backgroundColor: Colors.redAccent));
            }
          },
          child: StatefulBuilder(
            builder: (context, setBottomSheetState) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF060B1B),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<TaskUpdateBloc>().add(DeleteTaskRequested(task.taskId));
                          },
                          child: const Icon(CupertinoIcons.trash_fill, color: Colors.redAccent),
                        ),
                        IconButton(
                            onPressed: () => Navigator.pop(modalContext),
                            icon: const Icon(Icons.close, color: Colors.white)),
                      ],
                    ),
                    const Text("Task Name", style: TextStyle(color: Color(0xFFACACAC))),
                    const Gap(8),
                    TextFormField(
                        controller: titleController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFF131A2A),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
                    const Gap(16),
                    const Text("- Add Details", style: TextStyle(color: Color(0xFF7DD9FF))),
                    const Gap(8),
                    TextFormField(
                        controller: descController,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Type here",
                            hintStyle: const TextStyle(color: Colors.white30),
                            filled: true,
                            fillColor: const Color(0xFF131A2A),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
                    const Gap(16),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (dialogContext) => Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                            child: const EditMembersDialogContent(),
                          ),
                        ).then((result) {
                          if (result is List<String>) {
                            setBottomSheetState(() {
                              selectedUserIds = result;
                            });
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/Team_Leader/group_peaple.svg"),
                          const Gap(8),
                          Expanded(
                            child: Text(
                              selectedUserIds.isNotEmpty
                                  ? "${selectedUserIds.length} Members Selected"
                                  : "Assign To",
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                        ],
                      ),
                    ),
                    const Gap(8),
                    Center(
                        child: Text("🕒 Duration : ${task.durationDays} Days",
                            style: const TextStyle(color: Color(0xFF7DD9FF), fontWeight: FontWeight.bold))),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(child: _buildEditableDateField(context, "Start Date", startController)),
                        const Gap(12),
                        Expanded(child: _buildEditableDateField(context, "Deadline", deadlineController)),
                      ],
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // ✅ إرسال البيانات متوافقة مع الـ API متضمنة قائمة الـ userIds
                          final request = UpdateTaskRequest(
                            title: titleController.text,
                            description: descController.text,
                            startDate: startController.text.split(' ')[0],
                            deadLine: deadlineController.text.split(' ')[0],
                            status: 0,
                            userIds: selectedUserIds, // ✅ تم التمرير بنجاح هنا
                          );
                          context.read<TaskUpdateBloc>().add(UpdateTaskRequested(task.taskId, request));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7DD9FF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        child: const Text("Save Changes", style: TextStyle(color: Color(0xFF060B1B))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableDateField(
      BuildContext context, String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFFACACAC), fontSize: 12)),
        const Gap(8),
        GestureDetector(
          onTap: () => _showCalendarPicker(context, controller),
          child: AbsorbPointer(
            child: TextFormField(
                controller: controller,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF131A2A),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12))),
          ),
        ),
      ],
    );
  }

  Future<void> _handleApproveAndDispatch() async {
    if (widget.plan.planId == null || widget.plan.planId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Invalid Plan ID")));
      return;
    }
    setState(() {
      _isDispatchedLoading = true;
    });
    try {
      await _planRepository.approvePlan(planId: widget.plan.planId!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Plan Approved & Dispatched Successfully!"),
          backgroundColor: Colors.green));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => root(initialPage: 2)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to dispatch plan: ${e.toString()}"),
          backgroundColor: Colors.redAccent));
    } finally {
      if (mounted) {
        setState(() {
          _isDispatchedLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PlanTask> tasks = [];
    if (_selectedModuleIndex == 0) {
      for (var module in widget.plan.modules) {
        tasks.addAll(module.tasks);
      }
    } else {
      final currentModule = widget.plan.modules.isNotEmpty &&
          (_selectedModuleIndex - 1) < widget.plan.modules.length
          ? widget.plan.modules[_selectedModuleIndex - 1]
          : null;
      tasks = currentModule?.tasks ?? [];
    }

    int totalDuration = 0;
    for (var task in tasks) {
      totalDuration += task.durationDays;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Center(
                  child: customText(
                      text: "Generated Plan",
                      color: Colors.white,
                      textsize: 28,
                      fontweight: FontWeight.w400)),
              const Gap(30),
              const Text('Plan Name',
                  style: TextStyle(
                      color: Color(0xFFACACAC),
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              const Gap(8),
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFF131A2A),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(widget.plan.planTitle ?? "Custom AI Plan",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
              const Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedModuleIndex = 0;
                            });
                          },
                          child: _buildFilterChip("All Plan",
                              isSelected: _selectedModuleIndex == 0))),
                  ...List.generate(widget.plan.modules.length, (index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedModuleIndex = index + 1;
                              });
                            },
                            child: _buildFilterChip(
                                widget.plan.modules[index].moduleName,
                                isSelected:
                                (index + 1) == _selectedModuleIndex)));
                  }),
                ]),
              ),
              const Gap(24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('${tasks.length} Tasks Suggested',
                    style: const TextStyle(
                        color: Color(0xFFACACAC), fontSize: 13)),
                Row(children: [
                  const Icon(Icons.access_time,
                      color: Color(0xFFACACAC), size: 14),
                  const Gap(4),
                  const Text('Duration : ',
                      style: TextStyle(color: Color(0xFFACACAC), fontSize: 13)),
                  Text('$totalDuration Days',
                      style: const TextStyle(
                          color: Color(0xFF7DD9FF),
                          fontSize: 13,
                          fontWeight: FontWeight.bold))
                ]),
              ]),
              const Gap(16),
              tasks.isNotEmpty
                  ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  separatorBuilder: (context, index) => const Gap(16),
                  itemBuilder: (context, index) =>
                      _buildTaskCard(task: tasks[index]))
                  : const Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text("No tasks available for this module.",
                          style: TextStyle(color: Colors.white54)))),
              const Gap(20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Color(0xFF060B1B),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            boxShadow: [
              BoxShadow(color: Colors.white10, blurRadius: 15, spreadRadius: 2)
            ]),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
              onPressed:
              _isDispatchedLoading ? null : _handleApproveAndDispatch,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7DD9FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0),
              child: _isDispatchedLoading
                  ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: SwappedShrinkingLoading(size: 30, strokeWidth: 3))
                  : const customText(
                  text: "Approve & Dispatch",
                  fontweight: FontWeight.w400,
                  textsize: 18,
                  color: Color(0xFF060B1B))),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF132337) : const Color(0xFF1F2634),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: const Color(0xFF7DD9FF), width: 1.5)
              : null),
      child: Text(label,
          style: TextStyle(
              color: isSelected
                  ? const Color(0xFF7DD9FF)
                  : const Color(0xFFACACAC),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400)),
    );
  }

  Widget _buildTaskCard({required PlanTask task}) {
    final hasOwner = task.suggestedOwner.userId.isNotEmpty;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFF131A2A),
          borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(task.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500))),
              const Gap(10),
              Row(children: const [
                Gap(10)
              ]),
            ]),
        if (task.description.isNotEmpty) ...[
          const Gap(6),
          Text(task.description,
              style: const TextStyle(color: Color(0xFFACACAC), fontSize: 13))
        ],
        const Gap(12),
        if (hasOwner)
          Row(children: [
            const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF1F2634),
                child: Icon(Icons.person, color: Colors.white54, size: 18)),
            const Gap(10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          task.suggestedOwner.userId.split('-').skip(1).isNotEmpty
                              ? task.suggestedOwner.userId.split('-').skip(1).first
                              : task.suggestedOwner.userId,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          overflow: TextOverflow.ellipsis),
                      Text(task.suggestedOwner.jobTitle,
                          style: const TextStyle(
                              color: Color(0xFFACACAC), fontSize: 12),
                          overflow: TextOverflow.ellipsis),
                      const Gap(8),
                    ])),
            const Gap(30),
            GestureDetector(
                onTap: () {
                  _showEditTaskBottomSheet(context, task);
                  debugPrint("✏️ Edit button pressed for Task ID: ${task.taskId}");

                },
                child: const Icon(Icons.edit, color: Colors.grey, size: 25)),
          ])
        else
          Row(children: [
            _buildStackedAvatar(0),
            _buildStackedAvatar(12),
            _buildStackedAvatar(24),
            const Gap(8),
            Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                    color: Color(0xFF242D3D), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Text('+3',
                    style: TextStyle(
                        color: Color(0xFFACACAC),
                        fontSize: 11,
                        fontWeight: FontWeight.bold))),
            const Gap(8),
            GestureDetector(
                onTap: () => _showEditTaskBottomSheet(context, task),
                child: const Icon(Icons.edit, color: Colors.grey, size: 25)),
          ]),
        const Gap(14),
        Row(children: [
          const Icon(Icons.access_time, color: Color(0xFFACACAC), size: 14),
          const Gap(6),
          Text('Suggested Duration : ${task.durationDays} Days',
              style: const TextStyle(color: Color(0xFFACACAC), fontSize: 12))
        ]),
        const Gap(12),
        Row(children: [
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Date',
                        style: TextStyle(color: Color(0xFFACACAC), fontSize: 11)),
                    const Gap(6),
                    Container(
                        height: 34,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xFF1F2634),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(task.startDate,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11))))
                  ])),
          const Gap(12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Deadline',
                        style: TextStyle(color: Color(0xFFACACAC), fontSize: 11)),
                    const Gap(6),
                    Container(
                        height: 34,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xFF1F2634),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(task.deadlineDate,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 11))))
                  ])),
        ]),
      ]),
    );
  }

  Widget _buildStackedAvatar(double leftMargin) {
    return Container(
        margin: EdgeInsets.only(left: leftMargin == 0 ? 0 : 4),
        child: const CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFF060B1B),
            child: CircleAvatar(
                radius: 13,
                backgroundColor: Color(0xFF1F2634),
                backgroundImage:
                AssetImage('assets/Team_Leader/user_avatar.png'))));
  }
}