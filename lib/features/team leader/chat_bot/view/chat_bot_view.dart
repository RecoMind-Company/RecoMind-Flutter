import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/Bloc.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/cubit.dart';
import 'package:recomind/features/team%20leader/chat_bot/cubit/state.dart';
import 'package:recomind/features/team%20leader/chat_bot/data/chatbot_model.dart';
import 'package:recomind/features/team%20leader/chat_bot/data/chatbot_repo.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/chatbot_setting.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/recommended_message_widget.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/textfield_send.dart';
import 'package:recomind/shared/widgets/TL_header.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
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

  List<Map<String, String>> messages = [];
  List<ChatBotHistoryModel> historyChats = [];

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    try {
      final data = await repo.getChatHistory();
      setState(() {
        historyChats = data;
      });
    } catch (e) {
      print("Error loading history in View: $e");
    }
  }

  List<TextSpan> _parseMarkdown(String text, Color textColor) {
    List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    int start = 0;

    for (final Match match in regex.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: TextStyle(color: textColor, fontSize: 16),
        ));
      }

      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: TextStyle(color: textColor, fontSize: 16),
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
            _loadChatHistory();
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
                      child: SafeArea(
                        child: Column(
                          children: [
                            const Gap(40),
                            TlHeader(
                              icon: "assets/Team leader svg/List_icon.svg",
                              onTab_setting: () {
                                setState(() => isClickedSetting = true);
                              },
                            ),
                            const Gap(22),
                            if (showRecommendedMessages)
                              Column(
                                children: [
                                  customText(
                                    text: "Hi, How Can I Help You?",
                                    color: AppColor.primaryColor,
                                    textsize: 28,
                                    fontweight: FontWeight.w400,
                                  ),
                                  const Gap(32),
                                  Row(
                                    children: [
                                      RecommendedMessageWidget(
                                          text: "Show sales this month"),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    children: [
                                      RecommendedMessageWidget(
                                          text: "What if we cut costs 10%?"),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    children: [
                                      RecommendedMessageWidget(
                                          text: "Top 3 products performance"),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    children: [
                                      RecommendedMessageWidget(
                                          text:
                                          "Which services generate the highest revenue ?"),
                                    ],
                                  ),
                                  const Gap(12),
                                ],
                              ),
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
                                          margin: const EdgeInsets.symmetric(vertical: 4),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: msg["type"] == "user"
                                                ? const Color(0xFF454A5599)
                                                : AppColor.darkBlue,
                                            borderRadius: msg["type"] == "user"
                                                ? const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                              bottomLeft: Radius.circular(12),
                                            )
                                                : const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                            ),
                                          ),
                                          child: msg["type"] == "user"
                                              ? customText(
                                            text: msg["text"]!,
                                            color: Colors.white,
                                          )
                                              : Builder(
                                            builder: (context) {
                                              final isErrorMsg = msg["text"] == "Something went wrong, please try again.";
                                              final textColor = isErrorMsg ? Colors.redAccent : Colors.white;

                                              return RichText(
                                                text: TextSpan(
                                                  children: _parseMarkdown(msg["text"]!, textColor),
                                                ),
                                              );
                                            },
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
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color(0xFF0E1526),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Skeletonizer(
                                                enabled: true,
                                                effect: const ShimmerEffect(
                                                  baseColor: Color(0xFF1A2C3D),
                                                  highlightColor: Color(0xFF274454),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    text: "Analyzing your question ...",
                                                    color: Colors.white.withOpacity(0.6),
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
                  ),

                  // ✅ الـ Soft Animation المضاف لحركة الـ Side Menu
                  IgnorePointer(
                    ignoring: !isClickedSetting,
                    child: AnimatedOpacity(
                      opacity: isClickedSetting ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      child: AnimatedSlide(
                        offset: isClickedSetting ? Offset.zero : const Offset(0.3, 0.0),
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        child: ChatbotSetting(
                          cancel: () => setState(() => isClickedSetting = false),
                          onNewChat: () {
                            setState(() {
                              messages.clear();
                              showRecommendedMessages = true;
                              isClickedSetting = false;
                            });
                          },
                          historyList: historyChats,
                          onHistoryClick: (selectedHistory) {
                            setState(() {
                              messages.clear();
                              showRecommendedMessages = false;

                              messages.add({"type": "user", "text": selectedHistory.query ?? ""});
                              messages.add({"type": "bot", "text": selectedHistory.responseMessage ?? ""});

                              isClickedSetting = false;
                            });
                          },
                        ),
                      ),
                    ),
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