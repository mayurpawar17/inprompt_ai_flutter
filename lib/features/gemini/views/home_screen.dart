import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inprompt_ai_flutter/core/utils/helper_method.dart';
import 'package:inprompt_ai_flutter/features/gemini/data/model/message.dart';

import '../../../core/utils/app_colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../widgets/custom_chip.dart';
import '../widgets/message_bubble.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GeminiScreen> {
  final TextEditingController _input = TextEditingController();

  //for customChips
  void _sendMessage(String text) {
    final message = text.trim();
    if (message.isEmpty) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDark
          ? AppColors.darkPrimary
          : AppColors.primaryColor,
      appBar: AppBar(
        leadingWidth: 64,
        // important for spacing
        leading: Padding(
          padding: const EdgeInsets.only(left: 8), // your padding
          child: Builder(
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  color: context.isDark
                      ? AppColors.darkSecondary
                      : AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(50), // smooth corners
                  border: Border.all(
                    color: context.isDark ? Colors.grey : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    color: context.isDark ? Colors.white : Colors.black,
                    size: 22,
                  ),
                ),
              );
            },
          ),
        ),
        backgroundColor: context.isDark
            ? AppColors.darkPrimary
            : AppColors.primaryColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: context.isDark
                    ? AppColors.darkSecondary
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(50), // smooth corners
                border: Border.all(
                  color: context.isDark ? Colors.grey : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // context.read<GptBloc>().add(
                      //   CreateConversationEvent(),
                      // );
                    },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            //message list
            Expanded(
              child: true
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'InPrompt AI',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: context.isDark
                                ? AppColors.whiteColor
                                : AppColors.darkPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            CustomChip(
                              // icon: Icons.flash_on_rounded,
                              text: "💬 Common HR questions",
                              isDark: context.isDark,
                              onTap: () => _sendMessage("Common HR questions"),
                            ),
                            CustomChip(
                              text: "🎯 Start mock interview",
                              isDark: context.isDark,
                              onTap: () =>
                                  _sendMessage("🎯 Start mock interview"),
                            ),
                            CustomChip(
                              text: "🧠 Tell me about yourself",
                              isDark: context.isDark,
                              onTap: () =>
                                  _sendMessage("🧠 Tell me about yourself"),
                            ),
                            CustomChip(
                              text: "❓ Why should we hire you?",
                              isDark: context.isDark,
                              onTap: () =>
                                  _sendMessage("❓ Why should we hire you?"),
                            ),
                          ],
                        ),
                      ],
                    )
                  : ListView.builder(
                      // controller: _scroll,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        // if (index >= conv.messages.length) {
                        //   return TypingIndicator();
                        // }
                        return MessageBubble(
                          message: Message(
                            id: '1',
                            text: "hellow",
                            time: DateTime.now(),
                            isUser: true,
                          ),
                          // animate:
                          //     !conv.messages[index].isUser &&
                          //     index == conv.messages.length - 1,
                          onTextChanged: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              // _scrollToBottom();
                              // _autoScrollIfNeeded();
                            });
                          },
                        );
                      },
                    ),
            ),

            //input composer - only show if not in error state
            _buildComposer(context),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      backgroundColor: isDark ? AppColors.darkPrimary : AppColors.primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            // NEW CHAT BUTTON
            ListTile(
              trailing: IconButton(
                onPressed: () {
                  // context.read<GptBloc>().add(CreateConversationEvent());
                  Navigator.pop(context);
                },

                icon: Icon(Icons.add),
              ),
              title: const Text(
                'InPrompt AI',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            //conversation list
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  // final c = state.conversations[index];
                  return GestureDetector(
                    onLongPressStart: (details) {
                      // showContextMenuAtPosition(
                      //   context,
                      //   details.globalPosition,
                      //   index,
                      // );
                    },
                    child: ListTile(
                      title: Text(
                        'hello',
                        // c.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.whiteColor
                              : AppColors.darkPrimary,
                        ),
                      ),
                      // selected: index == state.selectedConversationIndex,
                      selectedTileColor: Colors.grey.withOpacity(0.1),

                      onTap: () {
                        // context.read<GptBloc>().add(
                        //   SelectConversationEvent(index),
                        // );
                        Navigator.pop(context);
                      },

                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.delete,
                      //     size: 20,
                      //     color: isDark
                      //         ? AppColors.whiteColor
                      //         : AppColors.darkPrimary,
                      //   ),
                      //   onPressed: () {
                      //     context.read<GptBloc>().add(
                      //       DeleteConversationEvent(index),
                      //     );
                      //   },
                      // ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComposer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSecondary : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(50),
            border: isDark
                ? Border.all(
                    color: isDark
                        ? Colors.grey.withOpacity(0.25)
                        : Colors.grey.withOpacity(0.35),
                    width: 1,
                  )
                : Border(),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _input,
                  minLines: 1,
                  maxLines: 6,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    hintText: "Ask InPrompt AI",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      // fontSize: 15,
                      // color: isDark ? Colors.white : Colors.black,
                      color: Colors.grey.shade500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(width: 6),

              //send button
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: isDark
                        ? AppColors.whiteColor
                        : AppColors.darkPrimary,
                    shape: const CircleBorder(),
                  ),
                  icon: Icon(
                    Icons.arrow_upward,
                    color: isDark
                        ? AppColors.darkPrimary
                        : AppColors.whiteColor,
                  ),
                  onPressed: () {
                    final text = _input.text.trim();
                    if (text.isEmpty) return;

                    _input.clear();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
