import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:katha_loop/application/state_management.dart';
import 'package:katha_loop/core/responsive_utils.dart';
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
    
    return Scaffold(
      appBar: _buildAppBar(theme),
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
              child: _buildChatArea(theme),
            ),
            
            // Loading indicator
            if (_isLoading) _buildLoadingIndicator(theme),
            
            // Message input area
            _buildMessageInput(theme),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      leading: AccessibilityHelper.makeAccessible(
        semanticLabel: 'Menu book icon',
        child: StyledIcon(
          Icons.menu_book_rounded,
          color: theme.colorScheme.primary,
        ),
      ),
      title: AccessibilityHelper.makeAccessible(
        semanticLabel: 'Katha Loop app title',
        child: Text(
          'Katha Loop',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: context.isMobile ? 24 : 28,
          ),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: context.isMobile ? 16 : 24),
          width: context.isMobile ? 40 : 48,
          height: context.isMobile ? 40 : 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            image: const DecorationImage(
              image: AssetImage('assets/logo.jpg'),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: AccessibilityHelper.makeAccessible(
            semanticLabel: 'App logo',
            child: const SizedBox.shrink(),
          ),
        ),
      ],
      backgroundColor: theme.colorScheme.surface.withOpacity(0.8),
      elevation: 0,
    );
  }

  Widget _buildChatArea(ThemeData theme) {
    return ValueListenableBuilder(
      valueListenable: currentChat,
      builder: (context, value, child) {
        if (value.isEmpty) {
          return _buildEmptyState(theme);
        }
        
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
        
        final maxWidth = context.isDesktop ? 800.0 : double.infinity;
        
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: context.isMobile ? AppSpacing.md : AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              itemBuilder: (context, index) {
                final message = value[index];
                final isUser = message.role == 'USER';
                
                return _buildMessageBubble(theme, message.message, isUser);
              },
              separatorBuilder: (context, index) => 
                  const SizedBox(height: AppSpacing.md),
              itemCount: value.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(ThemeData theme, String text, bool isUser) {
    final bubbleMargin = context.isMobile 
        ? context.screenWidth * 0.2 
        : context.screenWidth * 0.15;
    
    return Container(
      margin: EdgeInsets.only(
        left: isUser ? bubbleMargin : 0,
        right: isUser ? 0 : bubbleMargin,
      ),
      child: AccessibilityHelper.makeAccessible(
        semanticLabel: isUser 
            ? 'Your message: $text' 
            : 'AI response: $text',
        child: BubbleSpecialThree(
          text: text,
          isSender: isUser,
          color: isUser
              ? theme.colorScheme.primary.withOpacity(0.1)
              : theme.colorScheme.surfaceVariant,
          textStyle: TextStyle(
            color: isUser
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontSize: context.isMobile ? 16 : 18,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AccessibilityHelper.makeAccessible(
        semanticLabel: 'AI is generating your story',
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
            const SizedBox(width: AppSpacing.md),
            Text(
              'Crafting your story...',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(ThemeData theme) {
    final maxWidth = context.isDesktop ? 800.0 : double.infinity;
    
    return Container(
      padding: EdgeInsets.all(context.isMobile ? AppSpacing.md : AppSpacing.lg),
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
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: AccessibilityHelper.makeAccessible(
            semanticLabel: 'Message input area',
            hint: 'Type your story prompt and send',
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
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to generate story: $e'),
                        backgroundColor: theme.colorScheme.error,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
              messageBarColor: Colors.transparent,
              sendButtonColor: theme.colorScheme.primary,
              messageBarHintText: 'Type your story prompt...',
              messageBarHintStyle: TextStyle(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                fontSize: context.isMobile ? 14 : 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.isMobile ? AppSpacing.xl : AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AccessibilityHelper.makeAccessible(
              semanticLabel: 'Empty chat state icon',
              child: Container(
                width: context.isMobile ? 120 : 150,
                height: context.isMobile ? 120 : 150,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.isMobile ? 60 : 75),
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: context.isMobile ? 60 : 75,
                  color: theme.colorScheme.primary.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AccessibilityHelper.makeAccessible(
              semanticLabel: 'Start Your Story Adventure heading',
              child: Text(
                'Start Your Story Adventure',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: context.isMobile ? 24 : 28,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AccessibilityHelper.makeAccessible(
              semanticLabel: 'Instructions to start creating stories',
              child: Text(
                'Type a message below to begin creating\nyour messed up story with AI!',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                  fontSize: context.isMobile ? 16 : 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: AccessibilityHelper.makeAccessible(
                semanticLabel: 'Story starter suggestions',
                child: Column(
                  children: [
                    Icon(
                      Icons.tips_and_updates_outlined,
                      color: theme.colorScheme.primary,
                      size: context.isMobile ? 24 : 28,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Try starting with:\n"Once upon a time..." or "In a world where..."',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                        fontSize: context.isMobile ? 14 : 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
