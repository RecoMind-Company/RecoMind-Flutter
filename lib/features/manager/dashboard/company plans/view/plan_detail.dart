import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/widget/plan_comments.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class PlanDetailsScreen extends StatefulWidget {
  final String planName;
  final String status;
  final String planId;

  const PlanDetailsScreen({
    super.key,
    required this.planName,
    required this.status,
    required this.planId,
  });

  @override
  State<PlanDetailsScreen> createState() => _PlanDetailsScreenState();
}

class _PlanDetailsScreenState extends State<PlanDetailsScreen> {
  final PlanRepository _planRepository = PlanRepository();

  final List<TaskModel> _allTasks = [];
  bool _isLoadingAll = false;
  String _globalError = '';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      _isLoadingAll = true;
      _globalError = '';
      _allTasks.clear();
    });

    try {
      final tasks = await _planRepository.fetchTasksByModule(
        planId: widget.planId,
        moduleId: '',
      );
      setState(() {
        _allTasks.addAll(tasks);
        _isLoadingAll = false;
      });
    } catch (error) {
      setState(() {
        _isLoadingAll = false;
        if (error is ApiError) {
          _globalError = error.message;
        } else {
          _globalError = error.toString();
        }
      });
    }
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return '10 Feb 11:00 pm';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return DateFormat('dd MMM hh:mm a').format(dateTime);
    } catch (_) {
      return dateTimeStr;
    }
  }

  String get _mainStartDate {
    if (_allTasks.isEmpty) return '10 Feb 11:00 pm';
    final sorted = List<TaskModel>.from(_allTasks)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));
    return _formatDateTime(sorted.first.startDate);
  }

  String get _mainDeadline {
    if (_allTasks.isEmpty) return '10 Feb 11:00 pm';
    final sorted = List<TaskModel>.from(_allTasks)
      ..sort((a, b) => a.deadLine.compareTo(b.deadLine));
    return _formatDateTime(sorted.last.deadLine);
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    if (widget.status == 'Action Required' || widget.status == 'action_required') {
      statusColor = const Color(0xFFE05353);
      statusIcon = Icons.warning_amber_rounded;
    } else if (widget.status == 'Pending' || widget.status == 'draft') {
      statusColor = const Color(0xFFD4E313);
      statusIcon = Icons.access_time_filled_rounded;
    } else {
      statusColor = const Color(0xFF3CD182);
      statusIcon = Icons.check_circle_outline_rounded;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF090E1D),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, color: statusColor, size: 22),
                      const Gap(8),
                      Text(
                        widget.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: SvgPicture.asset("assets/Team leader svg/chat.svg"),
                    onPressed: () {
                      showChatDialog(context,widget.planId);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141A2B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.planName,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Expanded(child: _buildDateTile('Start Date', _mainStartDate)),
                        const Gap(12),
                        Expanded(child: _buildDateTile('Deadline', _mainDeadline)),
                      ],
                    ),
                    const Gap(16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141A2B),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/Team leader svg/peaple.svg"),
                          const Gap(8),
                          customText(
                            text: '${_allTasks.length} Tasks Included',
                            color: const Color(0xFFEEEEEE),
                            textsize: 14,
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Progress', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 15)),
                        Text(
                          widget.status == 'Action Required' || widget.status == 'action_required' ? '0%' : widget.status == 'Pending' || widget.status == 'draft' ? '0%' : '0%',
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Gap(10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: widget.status == 'Action Required' || widget.status == 'action_required' ? 0.0 : widget.status == 'Pending' || widget.status == 'draft' ? 0 : 0.0,
                        backgroundColor: const Color(0xFF1E2538),
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        minHeight: 12,
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
                      ),
                    ),
                    const Gap(28),
                    if (_isLoadingAll)
                      const Center(child: Padding(padding: EdgeInsets.all(24), child: SwappedShrinkingLoading(size: 30, strokeWidth: 3)))
                    else if (_globalError.isNotEmpty)
                      Center(child: Text(_globalError, style: const TextStyle(color: Colors.red, fontSize: 14)))
                    else if (_allTasks.isEmpty)
                        const Center(child: Text("No tasks available for this plan.", style: TextStyle(color: Colors.white54, fontSize: 14)))
                      else
                        ..._allTasks.map((task) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildTaskCard(task, widget.status, statusColor),
                          );
                        }),
                    const Gap(40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTile(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFFEEEEEE), fontSize: 14)),
        const Gap(6),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF141A2B),
            borderRadius: BorderRadius.circular(25),
          ),
          child: customText(text: date, color: const Color(0xFFEEEEEE), textsize: 16, fontweight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildTaskCard(TaskModel task, String status, Color statusColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF141A2B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (status == 'Action Required' || status == 'action_required' || task.priority == 'High') ...[
                Icon(Icons.error_outline_rounded, color: statusColor, size: 18),
                const Gap(8),
              ],
              const Icon(
                Icons.assignment_outlined,
                color: Color(0xFF8E9AA6),
                size: 20,
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const customText(text: 'Progress', color: Color(0xFF8E9AA6), textsize: 16),
              Text(
                task.status == 'to_do' ? '0%' : '0%',
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: task.status == 'to_do' ? 0.0 : 0,
              backgroundColor: const Color(0xFF1E2538),
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              minHeight: 15,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
            ),
          ),
          const Gap(16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const customText(text: 'Start Date', color: Color(0xFFBEBEBE), textsize: 14),
                    const Gap(4),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(color: const Color(0xFF232938), borderRadius: BorderRadius.circular(25)),
                      child: customText(text: _formatDateTime(task.startDate), color: const Color(0xFFEEEEEE), textsize: 13),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const customText(text: 'Deadline', color: Color(0xFFBEBEBE), textsize: 14),
                    const Gap(4),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      decoration: BoxDecoration(color: const Color(0xFF232938), borderRadius: BorderRadius.circular(25)),
                      child: customText(text: _formatDateTime(task.deadLine), color: const Color(0xFFEEEEEE), textsize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}