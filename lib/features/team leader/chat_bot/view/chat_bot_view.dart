import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/Bloc.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/cubit.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/state.dart';
import 'package:recomind/features/team%20leader/chat_bot/data/chatbot_repo.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/chatbot_setting.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/recommended_message_widget.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/textfield_send.dart';
import 'package:recomind/shared/widgets/TL_header.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  _ChatBotViewState createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  bool showRecommendedMessages = true;
  bool isClickedSetting = false;
  TextEditingController controller = TextEditingController();
  ChatbotRepo repo = ChatbotRepo();

  // قائمة الرسائل (المستخدم + البوت)
  List<Map<String, String>> messages =
  []; // { "type": "user"/"bot", "text": "..." }

  // دالة مساعدة لتحويل النص المحتوي على نجوم إلى أجزاء RichText (Bold / Regular)
  List<TextSpan> _parseMarkdown(String text) {
    List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    int start = 0;

    for (final Match match in regex.allMatches(text)) {
      // إضافة النص العادي قبل النجوم
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ));
      }
      // إضافة النص اللي جوه النجوم كـ Bold
      spans.add(TextSpan(
        text: match.group(1),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ));
      start = match.end;
    }

    // إضافة أي نص متبقي في نهاية السطر
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBotBloc(repo),
      child: BlocConsumer<ChatBotBloc, ChatBotState>(
        listener: (context, state) {
          if (state is ChatBotLoaded) {
            setState(() {
              messages.add({"type": "bot", "text": state.response});
            });
          } else if (state is ChatBotError) {
            setState(() {
              messages.add({"type": "bot", "text": state.message});
            });
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Stack(
                children: [
                  Containerwid(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          Gap(70),
                          TlHeader(
                            icon: "assets/Team leader svg/List_icon.svg",
                            onTab_setting: () {
                              setState(() => isClickedSetting = true);
                            },
                          ),
                          Gap(22),
                          // Recommended messages فوق
                          if (showRecommendedMessages)
                            Column(
                              children: [
                                customText(
                                  text: "Hi, How Can I Help You?",
                                  color: AppColor.primaryColor,
                                  textsize: 28,
                                  fontweight: FontWeight.w400,
                                ),
                                Gap(32),
                                Row(
                                  children: [
                                    RecommendedMessageWidget(
                                        text: "  What if we cut costs 10%?  "),
                                    Gap(8),
                                    RecommendedMessageWidget(
                                        text: " Show sales this month "),
                                  ],
                                ),
                                Gap(12),
                                Row(
                                  children: [
                                    RecommendedMessageWidget(
                                        text:
                                        "           Top 3 products performance           "),
                                  ],
                                ),
                                Gap(12),
                                Row(
                                  children: [
                                    RecommendedMessageWidget(
                                        text:
                                        "        Which services generate the highest revenue ?        "),
                                  ],
                                ),
                                Gap(12),
                              ],
                            ),
                          // الرسائل Scrollable تحت
                          Expanded(
                            child: SingleChildScrollView(
                              reverse: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var msg in messages)
                                    Align(
                                      alignment: msg["type"] == "user"
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: msg["type"] == "user"
                                              ? const Color(0xFF454A5599)
                                              : AppColor.darkBlue,
                                          borderRadius: msg["type"] == "user"
                                              ? const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                            bottomLeft:
                                            Radius.circular(12),
                                          )
                                              : const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                            bottomRight:
                                            Radius.circular(12),
                                          ),
                                        ),
                                        // تعديل هنا: إذا كانت الرسالة من البوت نستخدم RichText لدعم الـ Bold
                                        child: msg["type"] == "user"
                                            ? customText(
                                          text: msg["text"]!,
                                          color: Colors.white,
                                        )
                                            : RichText(
                                          text: TextSpan(
                                            children: _parseMarkdown(msg["text"]!),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (state is ChatBotLoading)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: const Color(0xFF0E1526),
                                        ),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Skeletonizer(
                                              enabled: true,
                                              effect: const ShimmerEffect(
                                                baseColor: Color(0xFF1A2C3D),
                                                highlightColor: Color(0xFF274454),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: customText(text: "  1                                                                           1 "),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: customText(text: "  1                                                                           1 "),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: customText(text: "1                                   1"),
                                                  ),
                                                  const Gap(8),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                customText(
                                                  text:
                                                  "Analyzing your question ...",
                                                  color:
                                                  Colors.white.withOpacity(0.6),
                                                  textsize: 15,
                                                  fontweight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                          TextfieldSend(
                            sendMessage: () {
                              if (controller.text.trim().isEmpty) return;

                              setState(() {
                                messages.add({
                                  "type": "user",
                                  "text": controller.text.trim()
                                });
                                showRecommendedMessages = false;
                              });

                              // ارسال الرسالة للـ Bloc
                              context.read<ChatBotBloc>().add(
                                  SendMessageEvent(controller.text.trim()));

                              controller.clear();
                            },
                            controller: controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isClickedSetting)
                    ChatbotSetting(
                      cancel: () => setState(() => isClickedSetting = false),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}