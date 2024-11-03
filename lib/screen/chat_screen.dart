import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:katha_loop/application/state_management.dart';
import 'package:katha_loop/core/color_scheme.dart';
import 'package:katha_loop/core/styled_widgets.dart';
import 'package:katha_loop/gemini_integration/story_generator.dart';
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
          ListView.separated(
            itemBuilder: (context, index) => Container(
              color: ColorSchemeNew.primary,
              height: 200,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: 10,
          ),
          MessageBar(
            onSend: (text) async {
              final messages = await StoryGenerator().getStoryContinuation(
                userMessage: text,
                history: currentChat.value,
              );

              print(messages.toString());
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
