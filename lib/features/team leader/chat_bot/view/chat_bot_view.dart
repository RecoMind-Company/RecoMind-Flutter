import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:recomind/core/constants/app_colors.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/chatbot_setting.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/recommended_message_widget.dart';
import 'package:recomind/features/team%20leader/chat_bot/widget/textfield_send.dart';
import 'package:recomind/shared/widgets/TL_header.dart';
import 'package:recomind/shared/widgets/container.dart';
import 'package:recomind/shared/widgets/custom_text.dart';
import 'package:recomind/shared/widgets/textfiekd.dart';


class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  bool IsClickedSetting= false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            Containerwid(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Gap(70),

                  ///header team leader
                  TlHeader(icon: "assets/Team leader svg/List_icon.svg",onTab_setting: (){
                      setState(() {
                        IsClickedSetting = true;
                      });
                  },),
                  Gap(22),

                  ///body
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          ///Subtitle
                          customText(text: "Hi, How Can I Help You?",color: AppColor.primaryColor,textsize: 28,fontweight: FontWeight.w400,),
                          Gap(32),
                          ///recommended
                          Row(
                           children: [
                             RecommendedMessageWidget(text: "  What if we cut costs 10%?  "),
                              Gap(8),
                              RecommendedMessageWidget(text: " Show sales this month "),
                           ],
                                     ),
                          Gap(12),
                          Row(
                            children: [
                              RecommendedMessageWidget(text: "           Top 3 products performance           "),]),
                          Gap(12),
                          Row(
                              children: [
                                RecommendedMessageWidget(text: "        Which services generate the highest revenue ?        "),]),
                        ],
                      ),
                    ),
                  ),


                  ///text field
                  TextfieldSend(
                   onSave: (v){},
                  )
                ],
              ),
            )),
            IsClickedSetting == true ? ChatbotSetting(cancel: (){setState(() {
              IsClickedSetting = false;
            });},):customText(text: "")
          ],
        ),
      ),
    );
  }
}
