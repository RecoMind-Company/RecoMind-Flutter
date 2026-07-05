import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/data/sub_Model.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/data/subscription_repo.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/view/complete.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/widget/button_plan.dart';
import 'package:recomind/features/auth/sign%20up%20views/plan%20&%20complete/widget/card.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  int selectedIndex = -1;
  late Future<List<SubscriptionModel>> _subscriptionsFuture;

  @override
  void initState() {
    super.initState();
    // جلب البيانات من الـ Repository
    _subscriptionsFuture = SubscriptionRepository().getAllSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Containerwid(
        child: FutureBuilder<List<SubscriptionModel>>(
          future: _subscriptionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}", style: const TextStyle(color: Colors.white)));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No plans available", style: TextStyle(color: Colors.white)));
            }

            final subscriptions = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(80),
                  SizedBox(
                    width: 345,
                    child: customText(
                        text: "Choose Your Plan",
                        textsize: 28,
                        color: const Color(0xffEEEEEE)),
                  ),
                  const Gap(20),
                  // عرض الاشتراكات ديناميكياً
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: subscriptions.length,
                    separatorBuilder: (context, index) => const Gap(40),
                    itemBuilder: (context, index) {
                      final plan = subscriptions[index];

                      // تحديد النصوص الثابتة بناءً على نوع الخطة (للحفاظ على منطقك الأصلي)
                      String cam1 = "", cam2 = "", cam3 = "", cam4 = "", cam5 = "";

                      if (plan.planName == "Starter") {
                        cam1 = "Dashboards & Reports";
                        cam2 = "Basic AI Insights";
                        cam3 = "Tasks & Notifications";
                        cam4 = "AI Assistant (Limited)";
                      } else if (plan.planName == "Professional") {
                        cam1 = "Everything in Starter";
                        cam2 = "AI Recommendations";
                        cam3 = "Validation & Simulation";
                        cam4 = "Plans → Tasks Automation";
                        cam5 = "Unlimited AI Assistant";
                      } else if (plan.planName == "Enterprise") {
                        cam1 = "Everything in Professional";
                        cam2 = "Voice AI Assistant";
                        cam3 = "Advanced Analytics";
                        cam4 = "API Integrations";
                        cam5 = "Priority Support";
                      }

                      return Card_pr(
                        isSelected: selectedIndex == index,
                        onTap: () => setState(() => selectedIndex = index),
                        // العنوان القادم من الـ API
                        title: plan.planName,
                        // السعر والـ billingCycle القادمان من الـ API
                        price: "\$${plan.price} / ${plan.billingCycle}",
                        cam_1: cam1,
                        cam_2: cam2,
                        cam_3: cam3,
                        cam_4: cam4,
                        cam5: cam5,
                      );
                    },
                  ),
                  const Gap(50),
                  // في صفحة Plan.dart - تحديث دالة ButtonPlan
                  ButtonPlan(
                    onTap: () async {
                      if (selectedIndex != -1) {
                        final selectedPlan = subscriptions[selectedIndex];

                        try {
                          // 1. إظهار مؤشر تحميل للمستخدم
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => const Center(child: SwappedShrinkingLoading(strokeWidth: 5,size: 50,))
                          );

                          // 2. إرسال طلب PUT إلى الـ API باستخدام الـ id
                          await SubscriptionRepository().assignSubscription(selectedPlan.id);

                          if (context.mounted) Navigator.pop(context);

                          if (context.mounted) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const completesetup()) // استبدل NextPage
                            );
                          }

                        } catch (e) {
                          if (context.mounted) Navigator.pop(context);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to assign plan: ${e.toString()}")),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select a plan first!")),
                        );
                      }
                    },
                  ),
                  const Gap(50),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}