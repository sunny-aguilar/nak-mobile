import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/db/db_chat.dart' as db_chat;
import 'package:nak_app/components/utils.dart' as utils;

class ChatMaintenance extends StatefulWidget {
  const ChatMaintenance({super.key});

  @override
  State<ChatMaintenance> createState() => _ChatMaintenanceState();
}

class _ChatMaintenanceState extends State<ChatMaintenance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: const ChatMaintenanceBody(),
    );
  }
}

class ChatMaintenanceBody extends StatefulWidget {
  const ChatMaintenanceBody({super.key});
  @override
  State<ChatMaintenanceBody> createState() => _ChatMaintenanceBodyState();
}

class _ChatMaintenanceBodyState extends State<ChatMaintenanceBody> {
  // chat stat variables
  int totalGcChats = 0;

  void setNewChatListName() {
    DateTime start = DateTime(2024, 05, 01);
    DateTime end = DateTime(2024, 05, 02);
    Duration duration = end.difference(start);
    print('Diff: ${duration.inHours}');
  }

  Future<void> _handleRefresh() async {
    setState(() {});
  }

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 30, width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: RefreshIndicator(
        color: theme.primaryClr,
        backgroundColor: theme.redClr,
        onRefresh: _handleRefresh,
        child: FutureBuilder(
          future: db_chat.ChatSettings().totalChats('general_chat'),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) { _circularProgress(); }
            else if (snapshot.data == null) { _circularProgress(); }
            else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

              List<dynamic> chatList = snapshot.data?['active'];
              int totalChats = chatList.length;
              totalGcChats = totalChats;

              return CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (BuildContext context, int index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Chat Room Stats', style: theme.TextThemes.headlineMedLarge(context),),
                            const SizedBox(height: 20,),
                            Text('General Chat Stats', style: theme.TextThemes.headlineSmall16(context),),
                          ],
                        );
                      }
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GeneralChatOptions(chatRoom: 'general_chat', totalChats: totalChats,))
                                );
                              },
                              leading: CircleAvatar(
                                foregroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                                backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.redClr,
                                child: Text('$totalGcChats', style: theme.TextThemes.headlineSmall(context)),
                              ),
                              title: const Text('Total chat messages'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GeneralChatOptions(chatRoom: 'general_chat', totalChats: totalChats,))
                                );
                              },
                              leading: CircleAvatar(
                                foregroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                                backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.redClr,
                                child: Text('$totalGcChats', style: theme.TextThemes.headlineSmall(context)),
                              ),
                              title: const Text('Total chat messages'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              );
            }
            return _circularProgress();
          }
        ),
      ),
    );
  }
}

class GeneralChatOptions extends StatelessWidget {
  const GeneralChatOptions({super.key, required this.chatRoom, required this.totalChats});
  final String chatRoom;
  final int totalChats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Chat Room Stats', style: theme.TextThemes.headlineMedLarge(context),),
            const SizedBox(height: 12,),
            Text('Archive Chat Process', style: theme.TextThemes.headlineSmall16(context),),
            const Text('Chats will be archived using a timestamp. Any archives will be datestamped with a date stamped and saved in an archive. Monitor Firestore to make sure data is saved properly.',),
            const SizedBox(height: 12,),
            Text('Chat Room Data:', style: theme.TextThemes.headlineSmall16(context),),
            Text('Chat Room: $chatRoom\nTotal Messages: $totalChats\nTimestamp: ${utils.Dates().getDateTime()}'),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: () {
                // archive function
                db_chat.ChatSettings().resetChat();
              },
              style: buttons.chatButton(context, theme.redClr),
              child: const Text('Archive Chat', style: TextStyle(color: theme.primaryClr),),
            ),
          ],
        ),
      ),
    );
  }
}