import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:katha_loop/application/state_management.dart';
import 'package:katha_loop/core/color_scheme.dart';
import 'package:katha_loop/core/styled_widgets.dart';
import 'package:katha_loop/story_generator/story_generator.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: StyledIcon(
          Icons.menu_book_sharp,
        ),
        title:
            Text('Katha Loop', style: TextStyle(color: ColorSchemeNew.primary)),
        actions: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/logo.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        foregroundColor: ColorSchemeNew.secondary,
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
            messageBarColor: Colors.transparent,
            sendButtonColor: ColorSchemeNew.secondary,
          ),
        ],
      ),
      bottomSheet: SizedBox(
        height: 70,
      ),
    );
  }
}
