import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/team%20leader/dashboard/data/add_member_model.dart';
import 'package:recomind/features/team%20leader/dashboard/data/add_task.dart';
import 'package:recomind/features/team%20leader/dashboard/widget/add_members.dart';
import 'package:recomind/features/team%20leader/dashboard/widget/add_to_plan.dart';
import 'package:recomind/features/team%20leader/dashboard/data/plan_model.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';

void showAddTaskDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: AddTaskDialogContent(),
    ),
  );
}

class AddTaskDialogContent extends StatefulWidget {
  const AddTaskDialogContent({Key? key}) : super(key: key);

  @override
  State<AddTaskDialogContent> createState() => _AddTaskDialogContentState();
}

class _AddTaskDialogContentState extends State<AddTaskDialogContent> {
  final AddTaskToPlanRepository _addTaskToPlanRepository = AddTaskToPlanRepository();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime _startDate = DateTime.now();
  DateTime _deadline = DateTime.now().add(const Duration(days: 1));

  bool isDetailsTaped = false;
  bool isLoading = false;

  ShortPlanDto? _selectedPlan;
  List<String>? _selectedUserIds; // تم تغيير النوع هنا ليستقبل قائمة الـ IDs المرجعة مباشرة

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _deadline,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
              style: TextButton.styleFrom(foregroundColor: const Color(0xFF67D8F8)),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _deadline = picked;
        }
      });
    }
  }

  Future<void> _submitTask() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task name')),
      );
      return;
    }

    if (_selectedPlan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a plan first')),
      );
      return;
    }

    if (_selectedUserIds == null || _selectedUserIds!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please assign this task to at least one member')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // تنسيق التاريخ بصيغة ISO 8601 المتوافقة مع الـ JSON المطلوب (ينتهي بـ Z)
    String formattedStartDate = "${_startDate.toIso8601String()}Z";
    String formattedDeadline = "${_deadline.toIso8601String()}Z";

    final requestModel = AddTaskRequestModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty ? _titleController.text.trim() : _descriptionController.text.trim(),
      startDate: formattedStartDate,
      deadLine: formattedDeadline,
      userIds: _selectedUserIds!, // إرسال الـ List<String> مباشرة
      planId: _selectedPlan!.planId,
      moduleId: null,
      status: 0,
      priority: 0,
    );

    final response = await _addTaskToPlanRepository.addTaskToPlan(requestModel);

    if (mounted) {
      setState(() {
        isLoading = false;
      });

      if (response is AddTaskToPlanResponseModel) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Task added to plan successfully!')),
        );
        Navigator.pop(context);
      } else if (response is ApiError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFF161C2C), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Add Task", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white)),
            ],
          ),
          const Gap(24),
          const Text("Task Name", style: TextStyle(color: Color(0xFF8F9BB3), fontSize: 14)),
          const Gap(8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: const Color(0xFF161C2C), borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: "Add Task name", hintStyle: TextStyle(color: Color(0xFF535D6E)), border: InputBorder.none),
            ),
          ),
          const Gap(16),
          isDetailsTaped == false
              ? GestureDetector(
            onTap: () {
              setState(() {
                isDetailsTaped = true;
              });
            },
            child: Row(
              children: const [
                Icon(Icons.add, color: Color(0xFF67D8F8)),
                Gap(8),
                Text("Add Description", style: TextStyle(color: Color(0xFF67D8F8), fontWeight: FontWeight.w500)),
              ],
            ),
          )
              : Container(
            height: 160,
            decoration: BoxDecoration(
              color: const Color(0xFF141A29),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              controller: _descriptionController,
              maxLines: null,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              decoration: const InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(color: Color(0xFF56627C), fontSize: 15),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
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
                // استقبال الـ List<String> المرجعة من صفحة الأعضاء بنجاح
                if (result is List<String>) {
                  setState(() {
                    _selectedUserIds = result;
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
                    (_selectedUserIds != null && _selectedUserIds!.isNotEmpty)
                        ? "${_selectedUserIds!.length} Members Selected"
                        : "Assign To",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ],
            ),
          ),
          const Gap(16),
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (dialogContext) => Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const EditPlanDialogContent(),
                ),
              ).then((result) {
                if (result is ShortPlanDto) {
                  setState(() {
                    _selectedPlan = result;
                  });
                }
              });
            },
            child: Row(
              children: [
                SvgPicture.asset("assets/Team_Leader/plan_icon.svg"),
                const Gap(8),
                Expanded(
                  child: Text(
                    _selectedPlan != null ? _selectedPlan!.planName : "Add To Plan",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ],
            ),
          ),
          const Gap(24),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: _buildDateInput("Start Date", DateFormat('yyyy-MM-dd').format(_startDate)),
                ),
              ),
              const Gap(16),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: _buildDateInput("Deadline", DateFormat('yyyy-MM-dd').format(_deadline)),
                ),
              ),
            ],
          ),
          const Gap(32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: isLoading ? null : _submitTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67D8F8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: isLoading
                  ? const SwappedShrinkingLoading(size: 30,strokeWidth: 3,)
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(CupertinoIcons.add_circled, color: Colors.black, fontWeight: FontWeight.bold),
                  Gap(5),
                  Text("Add Task", style: TextStyle(color: Color(0xFF0C1221), fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInput(String label, String formattedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF8F9BB3), fontSize: 14)),
        const Gap(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(color: const Color(0xFF161C2C), borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formattedDate, style: const TextStyle(color: Colors.white, fontSize: 13)),
              const Icon(Icons.calendar_today_outlined, color: Color(0xFF8F9BB3), size: 20),
            ],
          ),
        ),
      ],
    );
  }
}