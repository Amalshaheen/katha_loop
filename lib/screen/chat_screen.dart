import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katha_loop/application/state_management.dart';
import 'package:katha_loop/core/color_scheme.dart';
import 'package:katha_loop/core/styled_widgets.dart';
import 'package:katha_loop/story_generator/story_generator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        leading: StyledIcon(
          Icons.menu_book_rounded,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          'Katha Loop',
          style: theme.textTheme.headlineMedium,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/logo.jpg'),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
        ],
        backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceVariant.withOpacity(0.3),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          children: [
            // Chat messages area
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: currentChat,
                builder: (context, value, child) {
                  if (value.isEmpty) {
                    return _buildEmptyState(theme);
                  }
                  
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                  
                  return ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    itemBuilder: (context, index) {
                      final message = value[index];
                      final isUser = message.role == 'USER';
                      
                      return Container(
                        margin: EdgeInsets.only(
                          left: isUser ? size.width * 0.2 : 0,
                          right: isUser ? 0 : size.width * 0.2,
                        ),
                        child: BubbleSpecialThree(
                          text: message.message,
                          isSender: isUser,
                          color: isUser
                              ? theme.colorScheme.primary.withOpacity(0.1)
                              : theme.colorScheme.surfaceVariant,
                          textStyle: TextStyle(
                            color: isUser
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurfaceVariant,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemCount: value.length,
                  );
                },
              ),
            ),
            
            // Loading indicator
            if (_isLoading)
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Crafting your story...',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            
            // Message input area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: MessageBar(
                onSend: (text) async {
                  if (text.trim().isEmpty) return;
                  
                  setState(() {
                    _isLoading = true;
                  });
                  
                  try {
                    final messages = await StoryGenerator().getStoryContinuation(
                      userMessage: text,
                      history: currentChat.value,
                    );
                    currentChat.value = messages;
                  } catch (e) {
                    // Handle error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to generate story: $e'),
                        backgroundColor: theme.colorScheme.error,
                      ),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                messageBarColor: Colors.transparent,
                sendButtonColor: theme.colorScheme.primary,
                messageBarHintText: 'Type your story prompt...',
                messageBarHintStyle: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 60,
                color: theme.colorScheme.primary.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Start Your Story Adventure',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Type a message below to begin creating\nyour messed up story with AI!',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.tips_and_updates_outlined,
                    color: theme.colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try starting with:\n"Once upon a time..." or "In a world where..."',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
