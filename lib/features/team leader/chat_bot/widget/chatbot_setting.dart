import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/chat_bot/data/chatbot_model.dart';
import 'package:recomind/shared/widgets/custom_text.dart';

class ChatbotSetting extends StatelessWidget {
  const ChatbotSetting({
    super.key,
    required this.cancel,
    required this.onNewChat,
    required this.historyList,
    required this.onHistoryClick,
  });

  final Function() cancel;
  final Function() onNewChat;
  final List<ChatBotHistoryModel> historyList;
  final Function(ChatBotHistoryModel) onHistoryClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.15), // خلفية ناعمة خفيفة
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // بلور ناعم للخلفية
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            width: 260,
            height: double.infinity,
            color: AppColor.darkBlue,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(40),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onNewChat,
                        child: Container(
                          height: 45,
                          width: 130,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit, color: AppColor.darkBlue, size: 20),
                              const Gap(4),
                              customText(
                                text: "New Chat",
                                fontweight: FontWeight.w500,
                                textsize: 14,
                                color: AppColor.darkBlue,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: cancel,
                        child: const Icon(
                          CupertinoIcons.xmark,
                          color: Colors.white,
                          size: 26,
                        ),
                      )
                    ],
                  ),
                  const Gap(24),
                  TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.search, size: 22),
                      suffixIconColor: Colors.white.withOpacity(0.5),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                          color: Color(0xFFB8ADAD),
                          fontFamily: "Poppins",
                          fontSize: 14),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                    ),
                  ),
                  const Gap(24),
                  customText(
                    text: "Recent Chats",
                    color: Colors.white.withOpacity(0.6),
                    textsize: 14,
                    fontweight: FontWeight.w600,
                  ),
                  const Gap(12),
                  Expanded(
                    child: historyList.isEmpty
                        ? Center(
                      child: customText(
                        text: "No recent history",
                        color: Colors.grey,
                        textsize: 13,
                      ),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: historyList.length,
                      itemBuilder: (context, index) {
                        final historyItem = historyList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () => onHistoryClick(historyItem),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF03294A).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.chat_bubble,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Text(
                                      historyItem.query ?? "Empty Query",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}