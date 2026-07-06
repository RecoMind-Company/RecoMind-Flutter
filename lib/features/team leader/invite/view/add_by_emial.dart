import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/invite/view/expired_invite.dart';
import 'package:recomind/shared/widgets/button.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart'; // استيراد مؤشر التحميل الخاص بمشروعك
import 'package:recomind/features/team%20leader/invite/data/invite_repo.dart';

class AddByEmail extends StatefulWidget {
  const AddByEmail({super.key});

  @override
  State<AddByEmail> createState() => _AddByEmialState();
}

class _AddByEmialState extends State<AddByEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TeamInfoRepository _teamInfoRepository = TeamInfoRepository();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

// ✅ دالة إرسال الدعوة والربط مع الـ API المحدثة
  Future<void> _sendInvite() async {
    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter an email address.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _teamInfoRepository.createInvite(email: email);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invitation sent successfully to $email")),
        );

        _emailController.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ExpiredInvite() ,));
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // ✅ تشييك ذكي وسريع: لو الـ API رجع إن المستخدم مسجل بالفعل، بنعرض رسالة نظيفة فوراً
        final errorMessage = e.toString();
        if (errorMessage.contains("already registered") || errorMessage.contains("Already registered")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("This user is already registered!"),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else {
          // رسالة الخطأ العادية لأي مشكلة تانية (مثل الشبكة أو السيرفر)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to send invitation: $e")),
          );
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView( // لحماية الشاشة من الـ Overflow عند ظهور الكيبورد
            child: Column(
              children: [
                const Gap(90),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const Gap(30),
                SvgPicture.asset("assets/Team_Leader/email.svg"),
                const Gap(30),
                const customText(
                  text: "Enter the employee’s email to send the invite code",
                  color: Colors.white,
                  textsize: 18,
                  fontweight: FontWeight.w400,
                ),
                const Gap(30),

                // ✅ ربط الـ textfield بالـ Controller لقراءة البريد الإلكتروني
                textfield(
                  hint: "example@gmail.com",
                  controller: _emailController,
                ),
                const Gap(30),

                // ✅ عرض مؤشر تحميل أو زرار الإرسال بناءً على حالة الـ Request
                _isLoading
                    ? const Center(
                  child: SwappedShrinkingLoading(size: 40, strokeWidth: 4),
                )
                    : button(
                  onPressed: _sendInvite, // ربط الضغطة بالدالة المحدثة
                  color: AppColor.primaryColor,
                  borderColor: AppColor.primaryColor,
                  buttonText: "Send Invite",
                  textColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}