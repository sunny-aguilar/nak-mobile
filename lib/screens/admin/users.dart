import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db_ops;
import 'package:nak_app/db/db_user_permissions.dart' as db_users;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});
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
      body: const UserlistBody(),
    );
  }
}


class UserlistBody extends StatefulWidget {
  const UserlistBody({super.key});
  @override
  State<UserlistBody> createState() => _UserlistState();
}

class _UserlistState extends State<UserlistBody> {

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
    );
  }

  ListView _buildUserList(data) {
    return ListView.builder(
      itemCount: data.length,
      prototypeItem: ListTile(
        title: Text(data[0].data()['chapter']),
        subtitle: const Text('User Subtitle'),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {

            Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (BuildContext context) {
                  return FutureBuilder(
                    future: Future.wait([
                      db_users.BlogRights(uid: data[index]['uid']).rightsStatus(),
                      db_users.ChatRights(uid: data[index]['uid']).rightsStatus(),
                    ]),
                    builder: (BuildContext context, snapshot) {
                      if (!snapshot.hasData) { _circularProgress(); }
                      else if (snapshot.data == null) { _circularProgress(); }
                      else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                        String uid = data[index].data()['uid'];
                        bool blogStatus = snapshot.data![0];
                        bool chatStatus = snapshot.data![1];
                        return UserSettingsScreen(
                          uid: uid,
                          blogStatus: blogStatus,
                          chatStatus: chatStatus,
                          username: db_ops.GetUsers().getUserName(),
                        );
                      }
                      return _circularProgress();
                    }
                  );

                }
              ),
            );

          },
          leading: CircleAvatar(
            backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
            child: Text('${data[index]['firstName'][0]}${data[index]['lastName'][0]}'),
          ),
          title: Text('${data[index]['firstName']} ${data[index]['lastName']}'),
          subtitle: Text('${data[index]['chapter']} chapter'),
          trailing: const Icon(Icons.arrow_forward_ios),

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db_ops.GetUsers().getAllUsers(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data.docs;
          return _buildUserList(data);
        }
        else if (snapshot.hasError) {
          return const Center(child: Text('Oh no! An error occurred!'),);
        }
        else {
          return _circularProgress();
        }
      }
    );
  }
}


class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key, required this.uid, required this.blogStatus, required this.chatStatus, required this.username});
  final String uid;
  final bool blogStatus;
  final bool chatStatus;
  final String username;

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool enableBlog = false;
  bool enableChat = false;

  @override
  void initState() {
    super.initState();
    enableBlog = widget.blogStatus;
    enableChat = widget.chatStatus;
  }

  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon> (
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
        //     onPressed: () {
        //       service.ThemeService().switchTheme();
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('User Settings', textAlign: TextAlign.center, style: theme.TextThemes.drawerMenuNT(context),),
            ListTile(
              title: Text('Current User: ${widget.username}'),
            ),
            ListTile(
              title: const Text('Give blog rights:'),

              trailing: Switch(
                thumbIcon: thumbIcon,
                value: enableBlog,
                activeColor: theme.mintClr,
                onChanged: (bool val) {
                  setState(() {
                    enableBlog = val;

                    // add or remove NEB rights
                    if (val) {
                      db_users.BlogRights(uid: widget.uid).addRights();
                    }
                    else if (!val) {
                      db_users.BlogRights(uid: widget.uid).removeRights();
                    }
                  });
                }
              ),

            ),
            ListTile(
              title: const Text('Give chat rights:'),

              trailing: Switch(
                thumbIcon: thumbIcon,
                value: enableChat,
                activeColor: theme.mintClr,
                onChanged: (bool val) {
                  setState(() {
                    enableChat = val;

                    // add or remove NEB rights
                    if (val) {
                      db_users.ChatRights(uid: widget.uid).addRights();
                    }
                    else if (!val) {
                      db_users.ChatRights(uid: widget.uid).removeRights();
                    }
                  });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}