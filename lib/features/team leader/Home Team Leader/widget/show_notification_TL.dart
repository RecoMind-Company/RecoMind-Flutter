import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_bloc.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_event.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/bloc/not_state.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/data/notification_model.dart';
import 'package:recomind/features/team%20leader/Home%20Team%20Leader/widget/category_notification.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class ShowNotificationTl extends StatefulWidget {
  const ShowNotificationTl({super.key, required this.cancel});

  final Function() cancel;

  @override
  State<ShowNotificationTl> createState() => _ShowNotificationTlState();
}

class _ShowNotificationTlState extends State<ShowNotificationTl> {
  List<String> Category = ["All", "Read", "Unread"];
  int taped = 0;

  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(FetchNotifications());
  }

  List<NotificationModel> _filterNotifications(List<NotificationModel> all) {
    List<NotificationModel> filtered = List.from(all);

    if (taped == 1) {
      filtered = all.where((n) => n.isRead).toList();
    } else if (taped == 2) {
      filtered = all.where((n) => !n.isRead).toList();
    }

    // ترتيب القائمة: الإشعارات غير المقروءة أولاً
    filtered.sort((a, b) {
      if (a.isRead == b.isRead) return 0;
      return a.isRead ? 1 : -1;
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 150),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF060B1B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: List.generate(
                      Category.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: CategoryNotification(
                            data: Category[index],
                            color: index == taped
                                ? AppColor.primaryColor
                                : Colors.white54,
                            onTap: () {
                              setState(() {
                                taped = index;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.cancel,
                    child: const Icon(
                      CupertinoIcons.xmark,
                      color: CupertinoColors.inactiveGray,
                    ),
                  )
                ],
              ),
              const Gap(25),
              BlocBuilder<NotificationBloc, NotificationState>(
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return const Center(
                        child: SwappedShrinkingLoading(
                          size: 30,
                          strokeWidth: 3,
                        ));
                  } else if (state is NotificationLoaded) {
                    final notifications = _filterNotifications(state.notifications);
                    return Column(
                      children: List.generate(
                        notifications.length,
                            (index) {
                          final item = notifications[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (!item.isRead) {
                                    context.read<NotificationBloc>().add(MarkNotificationAsRead(item.id));
                                  }
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: customText(
                                        text: item.message,
                                        color: Colors.white,
                                        fontweight: FontWeight.w500,
                                        textsize: 12,
                                      ),
                                    ),
                                    const Gap(10),
                                    if (!item.isRead)
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: AppColor.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    if (!item.isRead) const Gap(8),
                                  ],
                                ),
                              ),
                              const Gap(17),
                             index == notifications.length-1 ? Container():const Divider(
                                thickness: 1,
                                color: Color(0xFF285863),
                              ),
                              const Gap(17),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (state is NotificationError) {
                    return Text(state.message,
                        style: const TextStyle(color: Colors.red));
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}