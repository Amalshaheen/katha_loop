import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: StyledIcon(
          Icons.menu_book_sharp,
        ),
        title: Text('Katha Loop',
            style: GoogleFonts.rubikWetPaint(
                fontSize: 30, color: Color.fromARGB(255, 4, 34, 80))),
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
      backgroundColor: ColorSchemeNew.blue,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorSchemeNew.blue,
              ColorSchemeNew.blue,
              ColorSchemeNew.blue,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
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
                            ? Colors.white.withOpacity(0.75)
                            : Colors.white,
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
      ),
      bottomSheet: SizedBox(
        height: 70,
      ),
    );
  }
}
