import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/team%20leader/dashboard/data/add_member_model.dart';
import 'package:recomind/features/team%20leader/dashboard/data/add_member_repo.dart';
// تأكد من استيراد ملف الـ Model وملف الـ Repository بشكل صحيح هنا
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart'; // أو أي Loading مخصص لديك

void showEditMembersDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) => const Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24), // تضمن بقاء النافذة صغيرة وفي المنتصف
      child: EditMembersDialogContent(),
    ),
  );
}

class EditMembersDialogContent extends StatefulWidget {
  const EditMembersDialogContent({Key? key}) : super(key: key);

  @override
  State<EditMembersDialogContent> createState() => _EditMembersDialogContentState();
}

class _EditMembersDialogContentState extends State<EditMembersDialogContent> {
  final TeamRepository _teamRepository = TeamRepository();
  static List<TeamMemberModel> members = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTeamMembers();
  }

  Future<void> _loadTeamMembers() async {
    final result = await _teamRepository.getTeamMembersFullData();

    if (mounted) {
      result.fold(
            (failure) {
          setState(() {
            _isLoading = false;
            _errorMessage = failure.message;
          });
        },
            (membersList) {
          setState(() {
            _isLoading = false;
            members = membersList;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B), // لون الخلفية الداكن العميق من الصورة
        borderRadius: BorderRadius.circular(28), // حواف دائرية ناعمة وكبيرة للنافذة الطائرة
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // لجعل النافذة صغيرة وتتمدد فقط حسب المحتوى
        children: [
          Container(
            width: 120,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(24),

          // هيدر العنوان "Edit Members" مع السهم الجانبي
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const Text(
                "Edit Members",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(flex: 1),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const Gap(20),

          // 💡 عرض حالة التحميل أو الخطأ أو القائمة الفعلية دون المساس بالتصميم
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: SwappedShrinkingLoading(size: 40, strokeWidth: 4),
              ),
            )
          else if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign:TextAlign.center ,
                ),
              ),
            )
          else if (members.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    "No members found",
                    style: TextStyle(color: Color(0xFF56627C), fontSize: 14),
                  ),
                ),
              )
            else
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4, // تحديد أقصى ارتفاع مسموح به لمنع تمدد النافذة بشكل مفرط
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(), // تفعيل السكرول فقط عند كثرة الموظفين لتظل النافذة طائرة ومنظمة
                    padding: EdgeInsets.zero,
                    itemCount: members.length,
                    separatorBuilder: (context, index) => const Gap(14),
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return _buildMemberCard(
                        index: index,
                        name: member.userName ?? "Unknown",
                        role: member.jobTitle ?? "Employee",
                        isSelected: member.isSelected,
                      );
                    },
                  ),
                ),
              ),
          const Gap(24),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                // 💡 التعديل هنا: استخراج الـ User IDs فقط من العناصر المحددة وتمريرها مباشرة كـ List<String>
                List<String> selectedUserIds = members
                    .where((m) => m.isSelected && m.userId != null)
                    .map((m) => m.userId!)
                    .toList();
                Navigator.pop(context, selectedUserIds);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7DE6FF), // نفس درجة اللون السماوي بالصورة بالظبط
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Done",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard({
    required int index,
    required String name,
    required String role,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          members[index].isSelected = !members[index].isSelected;
        });
        print(members[index].userId);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF111726),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: const Color(0xFF2B5C8F), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: const Color(0xFF2B5C8F),
                  shape: BoxShape.circle,
                  image:  DecorationImage(image: AssetImage("assets/Team_Leader/man.png"),)
              ),
            ),
            const Gap(14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    role,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            isSelected
                ? Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFF4AC2E6), width: 2), // حواف الـ Checkbox الأزرق
              ),
              child: const Icon(
                Icons.check,
                size: 16,
                color: Color(0xFF4AC2E6),
              ),
            )
                : Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0), // المربع المصمت المائل للبياض في حالة عدم الاختيار
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}