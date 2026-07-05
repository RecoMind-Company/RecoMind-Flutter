import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/network/api_error.dart'; // تأكد من المسار الصحيح للـ ApiError
import 'package:recomind/features/admin/profile/view/edit_view.dart';
import 'package:recomind/features/admin/profile/view/setting_view.dart';
import 'package:recomind/features/admin/profile/widget/show_logout_dialog.dart';
import 'package:recomind/features/auth/log%20in%20views/log%20in/view/log_in.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

import '../../../auth/sign up views/review setup/widget/edit_button.dart';
import '../data/profile_model.dart'; // قم بتعديل المسار بناءً على مكان ملف الموديل
import '../data/profile_repo.dart';  // قم بتعديل المسار بناءً على مكان ملف الريبو

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isLogout = false;

  // ✨ إدارة حالة البيانات والتحميل
  bool isLoading = false;
  final ProfileRepository _profileRepository = ProfileRepository();
  UserProfileModel? userProfile;

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // ✨ جلب البيانات فور فتح الصفحة
  }

  Future<void> fetchProfileData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final result = await _profileRepository.getUserProfile();

      setState(() {
        userProfile = result;
        isLoading = false;
      });
    } on ApiError catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060B1B),
      body: Stack(
        children: [
          isLoading
              ? const Center(child: SwappedShrinkingLoading(size: 50,strokeWidth: 5,))
              : userProfile == null
              ? const Center(
            child: Text(
              "No Profile Data Available",
              style: TextStyle(color: Colors.white),
            ),
          )
              : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(70),
                  Row(
                    children: [
                      const Gap(8),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                            size: 35,
                          )),
                      const Gap(105),
                      customText(
                        text: "Profile",
                        color: Colors.white,
                        fontweight: FontWeight.w400,
                        textsize: 28,
                      )
                    ],
                  ),
                  const Gap(39),

                  /// Premium
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    height: 29,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF293F51),
                              Color(0xFF4C77A1),
                            ]),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Image.asset("assets/star.png"),
                        const Gap(4),
                        customText(
                          text: "You’re on Premium plan enjoy all report types",
                          textsize: 12,
                          fontweight: FontWeight.w400,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  const Gap(32),

                  /// edit button && image
                  SizedBox(
                    height: 101,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EditButton(ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditView(initialProfile: userProfile),
                            ),
                          ).then((value) {
                            if (value == true) {
                              fetchProfileData();
                            }
                          });
                        }),
                        const Spacer(),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0xFF151B29),
                          child: Icon(Icons.person,size: 70,color: Colors.white54,),
                        )
                      ],
                    ),
                  ),
                  const Gap(22),

                  /// personal info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Personal Info",
                        fontweight: FontWeight.w400,
                        textsize: 24,
                        color: Colors.white,
                      ),
                      const Gap(12),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, color: Color(0xFFB9B8B8)), // تم تعديل الأيقونة لتلائم الـ Name
                          const Gap(10),
                          // ✨ الاسم الحقيقي ديناميكي
                          Expanded(
                            child: customText(
                              text: "Name :  ${userProfile!.name}",
                              textsize: 16,
                              fontweight: FontWeight.w400,
                              color: const Color(0xFFB9B8B8),
                            ),
                          )
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          const Icon(Icons.work_outline, color: Color(0xFFB9B8B8)), // ✨ إضافة أيقونة للـ Job Title
                          const Gap(10),
                          // ✨ المسمى الوظيفي ديناميكي
                          Expanded(
                            child: customText(
                              text: "Job Title :  ${userProfile!.jobTitle}",
                              textsize: 16,
                              fontweight: FontWeight.w400,
                              color: const Color(0xFFB9B8B8),
                            ),
                          )
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, color: Color(0xFFB9B8B8)),
                          const Gap(10),
                          // ✨ الإيميل ديناميكي
                          Expanded(
                            child: customText(
                              text: "Email :  ${userProfile!.email}",
                              textsize: 16,
                              fontweight: FontWeight.w400,
                              color: const Color(0xFFB9B8B8),
                            ),
                          )
                        ],
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.phone, color: Color(0xFFB9B8B8)),
                          const Gap(10),
                          // ✨ الهاتف ديناميكي
                          Expanded(
                            child: customText(
                              text: "Phone :  ${userProfile!.phone}",
                              textsize: 16,
                              fontweight: FontWeight.w400,
                              color: const Color(0xFFB9B8B8),
                            ),
                          )
                        ],
                      ),
                      const Gap(30),
                      const Divider(
                        color: Color(0xFF498495),
                        thickness: 1,
                      ),
                      const Gap(20),

                      /// setting
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingView()));
                        },
                        child: SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              const Icon(Icons.settings, color: Color(0xFFB9B8B8), size: 30),
                              const Gap(23),
                              customText(
                                text: "Settings",
                                textsize: 16,
                                fontweight: FontWeight.w400,
                                color: const Color(0xFFB9B8B8),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Gap(10),

                      /// Logout
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLogout = true;
                          });
                        },
                        child: SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              const Icon(Icons.logout, color: Color(0xFFF76969), size: 30),
                              const Gap(23),
                              customText(
                                text: "Logout",
                                textsize: 16,
                                fontweight: FontWeight.w400,
                                color: const Color(0xFFF76969),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          // حوار تسجيل الخروج
          if (isLogout)
            ShowLogoutDialog(
              ontap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Loginview()),
                      (Route<dynamic> route) => false,
                );
              },
              cancel: () {
                setState(() {
                  isLogout = false;
                });
              },
            ),
        ],
      ),
    );
  }
}