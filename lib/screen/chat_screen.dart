import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:katha_loop/application/state_management.dart';
import 'package:katha_loop/core/color_scheme.dart';
import 'package:katha_loop/core/styled_widgets.dart';
import 'package:katha_loop/story_generator/story_generator.dart';
import 'package:katha_loop/models/history.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StyledIcon(
          Icons.menu_book_sharp,
        ),
        actions: [
          StyledIcon(
            Icons.circle_outlined,
          ),
        ],
      ),
      backgroundColor: ColorSchemeNew.background,
      body: Stack(
        children: [
          ValueListenableBuilder(
              valueListenable: currentChat,
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return Container();
                }
                return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 70),
                  itemBuilder: (context, index) {
                    chatColors.shuffle();
                    return BubbleSpecialThree(
                      text: value[index].message,
                      isSender: value[index].role == 'USER',
                      color: (value[index].role == 'USER')
                          ? ColorSchemeNew.grape
                          : ColorSchemeNew.grey,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: value.length,
                );
              }),
          MessageBar(
            onSend: (text) async {
              final messages = await StoryGenerator().getStoryContinuation(
                userMessage: text,
                history: currentChat.value,
              );
              currentChat.value = messages;
            },
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: 70,
      ),
    );
  }
}
