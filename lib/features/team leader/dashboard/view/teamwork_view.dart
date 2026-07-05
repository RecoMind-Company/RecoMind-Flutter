import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/team%20leader/dashboard/view/porposals.dart';
import 'package:recomind/features/team%20leader/dashboard/widget/add_task.dart';
import 'package:recomind/features/team%20leader/dashboard/view/teamwork_all.dart'; // تأكد أن هذا يحتوي على TasksListView

class MyWorkContent extends StatefulWidget {
  const MyWorkContent({super.key});

  @override
  State<MyWorkContent> createState() => _MyWorkContentState();
}

class _MyWorkContentState extends State<MyWorkContent> {
  String _currentTab = "direct";

  String _selectedPlanCategory = "Incoming Plans";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15),
                  child: Row(
                    children: [
                      // زر Direct Tasks التفاعلي
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentTab = "direct";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            // يتغير اللون ليصبح نشطاً (داكن) أو شفافاً بناءً على التحديد
                            color: _currentTab == "direct"
                                ? const Color(0xFF1E3142)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                            border: _currentTab != "direct"
                                ? Border.all(color: const Color(0xFF535D6E))
                                : null,
                          ),
                          child: const Text(
                            "Direct Tasks",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                      const Gap(12),

                      // 💡 القائمة المنسدلة المخصصة المطابقة لصورة image_ffc3f7.png
                      Theme(
                        data: Theme.of(context).copyWith(
                          popupMenuTheme: PopupMenuThemeData(
                            color: const Color(0xFF0F1524),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                          ),
                        ),
                        child: PopupMenuButton<String>(
                          offset: const Offset(0, 50),
                          onSelected: (String value) {
                            setState(() {
                              _selectedPlanCategory = value;
                              _currentTab = "plans"; // عند اختيار أي عنصر من القائمة، نتحول لقسم الـ plans
                            });
                          },
                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            _buildPopupMenuItem("All", hasDot: true),
                            _buildPopupMenuItem("Directives", hasDot: true),
                            _buildPopupMenuItem("Proposals", hasDot: false),
                            _buildPopupMenuItem("Archive", hasDot: false),
                          ],
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  // يتغير تفاعل لون الزر إذا كان هو المختار حالياً
                                  color: _currentTab == "plans"
                                      ? const Color(0xFF1E3142)
                                      : Colors.transparent,
                                  border: _currentTab != "plans"
                                      ? Border.all(color: const Color(0xFF535D6E))
                                      : null,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      _selectedPlanCategory,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    const Gap(8),
                                    const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.white, size: 20),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 12,
                                top: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF67D8F8),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ==========================================
                /// 🖥️ شرط التبديل الديناميكي لعرض المحتوى الرئيسي
                /// ==========================================
                Expanded(
                  child: _currentTab == "direct"
                      ? const TasksListView() // عرض السكرول والأيام والمهام العادية
                      : (_selectedPlanCategory == "Proposals"
                      ? const ProposalsContentView() // عرض صفحة المقترحات بدقة تفاصيلها
                      : Center(
                    child: Text(
                      "$_selectedPlanCategory Content",
                      style: const TextStyle(color: Colors.white),
                    ),
                  )),
                ),
              ],
            ),
          ),

          /// ==========================================
          /// ➕ الزرار العائم ثابت هنا في الشاشة الأم
          /// ==========================================
          Positioned(
            right: 20,
            bottom: 20,
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  showAddTaskDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF67D8F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  elevation: 4,
                ),
                icon: const Icon(Icons.add_circle_outline,
                    color: Color(0xFF060B1B), size: 20),
                label: const Text(
                  'Add Task',
                  style: TextStyle(
                    color: Color(0xFF060B1B),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title, {required bool hasDot}) {
    bool isCurrent = _selectedPlanCategory == title && _currentTab == "plans";

    return PopupMenuItem<String>(
      value: title,
      height: 48,
      child: Container(
        width: 160,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isCurrent ? const Color(0xFF1E293B) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasDot)
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                    color: Color(0xFF67D8F8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF67D8F8),
                        blurRadius: 10,
                        spreadRadius: 0.5,
                      )
                    ]
                ),
              ),
          ],
        ),
      ),
    );
  }
}