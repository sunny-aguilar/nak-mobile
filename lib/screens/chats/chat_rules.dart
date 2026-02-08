import 'package:flutter/material.dart';
import 'package:nak_app/db/db_chat.dart' as db;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;

class ChatRules extends StatefulWidget {
  const ChatRules({super.key});
  @override
  State<ChatRules> createState() => _ChatRulesState();
}

class _ChatRulesState extends State<ChatRules> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatRulesBody(),
    );
  }
}

class ChatRulesBody extends StatefulWidget {
  const ChatRulesBody({super.key});
  @override
  State<ChatRulesBody> createState() => _ChatRulesBodyState();
}

class _ChatRulesBodyState extends State<ChatRulesBody> {
  bool chatEnabled = false;

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 10, width: 10,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.greyClr,
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {} );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      backgroundColor: theme.redClr,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          // Status Indicator Card
          FutureBuilder(
            future: db.Chat().canChat(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(child: _circularProgress()),
                    ),
                  ),
                );
              }
              
              if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                bool canChat = snapshot.data!;
                chatEnabled = canChat;
                
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    color: canChat ? theme.azureClr : theme.orangeClr,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        children: [
                          Icon(
                            canChat ? Icons.check_circle_outline : Icons.warning_amber_rounded,
                            size: 32,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            canChat ? 'Chat Privileges Active' : 'Chat Privileges Suspended',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            canChat
                              ? 'Your chat privileges are in good standing.'
                              : 'Your chat privileges have been suspended.\nContact neb@nakinc.org for assistance.',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(child: _circularProgress()),
                  ),
                ),
              );
            }
          ),
          const SizedBox(height: 24),
          
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Chat Rules',
              style: theme.TextThemes.headlineMed(context),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          
          // Core Rules Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Community Standards',
                      style: theme.TextThemes.headlineSmall(context),
                    ),
                    const SizedBox(height: 12),
                    _buildRuleItem('Be friendly. Be polite. Be considerate.'),
                    _buildRuleItem('Do not type in all caps.'),
                    _buildRuleItem('Do not verbally abuse, harrass, attack, embarrass, or threaten anyone else in the chat room, no matter what they might say to you.'),
                    _buildRuleItem('Do not use obscene, offensive, or sexually explicit language.'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Status Information Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Understanding Your Status',
                      style: theme.TextThemes.headlineSmall(context),
                    ),
                    const SizedBox(height: 12),
                    _buildStatusIndicatorRow(theme.azureClr, 'Active Status', 'Your chat privileges are in good standing.'),
                    const SizedBox(height: 12),
                    _buildStatusIndicatorRow(theme.orangeClr, 'Suspended Status', 'Your chat privileges have been suspended.\nContact neb@nakinc.org for assistance.'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Warning Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 2,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.red.shade900
                  : Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.red.shade200
                          : theme.redClr,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Failure to follow any of these rules will result in you getting banned from chat.',
                        style: theme.TextThemes.chatWarning(context).copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.red.shade100
                              : Colors.red.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Action Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                if (chatEnabled) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1500),
                      content: Text('Verifying chat privileges...')
                    ),
                  );
                  Navigator.pushNamed(
                    context,
                    '/chat'
                  );
                }
                else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Chat Disabled', textAlign: TextAlign.center,),
                        content: const Text('Chat privileges are disabled.', textAlign: TextAlign.center,),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: buttons.buttonStyleRed(context),
                            child: const Text('Dismiss'),
                          ),
                        ],
                      );
                    }
                  );
                }
              },
              style: buttons.chatButton(context, theme.redClr),
              child: const Text('Start Chatting', style: TextStyle(color: theme.primaryClr),),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String ruleText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: theme.redClr, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              ruleText,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicatorRow(Color statusColor, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}