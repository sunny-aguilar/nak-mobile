import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db_ops;
import 'package:nak_app/db/db_users.dart' as db_users;
import 'package:nak_app/services/theme_service.dart' as service;

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});
  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
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
      body: const Userlist(),
    );
  }
}


class Userlist extends StatefulWidget {
  const Userlist({super.key});
  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db_ops.GetUsers().getAllUsers(),
      builder: (BuildContext context, snapshot) {

        if (!snapshot.hasData) { _circularProgress(); }
        else if (snapshot.data == null) { _circularProgress(); }
        else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

          final data = snapshot.data.docs;
          final count = snapshot.data.docs.length;

          return ListView.builder(
            itemCount: count,
            prototypeItem: const ListTile(
              title: Text('UserName'),
              subtitle: Text('Chapter'),
            ),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) {
                        return UserSettingsScreen(uid: data[index]['uid'],);
                      }
                    ),
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<Widget>(
                  //     builder: (BuildContext context) {
                  //       return FutureBuilder(
                  //         future: db_users.BlogRights(uid: data[index]['uid']).rightsStatus(),
                  //         builder: (BuildContext context, snapshot) {
                  //           if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                  //             return UserSettingsScreen(uid: data[index]['uid'],);
                  //           }
                  //           return _circularProgress();
                  //         }
                  //       );
                  //     }
                  //   ),
                  // );

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
        return _circularProgress();

      }
    );
  }
}


class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key, required this.uid});
  final String uid;
  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool enableChat = false;

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 12, width: 12,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          color: theme.redClr,
          backgroundColor: theme.greyClr,
        ),
      ),
    );
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
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('User Settings', textAlign: TextAlign.center, style: theme.TextThemes.drawerMenuNT(context),),
            ListTile(
              title: const Text('Give blog rights:'),
              // trailing: FutureBuilder(
              //   future: db_users.BlogRights(uid: widget.uid).rightsStatus(),
              //   builder: (BuildContext context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
              //       return Switch(
              //         thumbIcon: thumbIcon,
              //         value: enableChat,
              //         activeColor: theme.mintClr,
              //         onChanged: (bool val) {
              //           setState(() {
              //             enableChat = val;

              //             // add or remove NEB rights
              //             if (val) {
              //               db_users.BlogRights(uid: widget.uid).addRights();
              //             }
              //             else if (!val) {
              //               db_users.BlogRights(uid: widget.uid).removeRights();
              //             }
              //           });
              //         }
              //       );
              //     }
              //     // return _circularProgress();
              //     return const Icon(Icons.access_alarm);
              //   }
              // ),
              trailing: Switch(
                thumbIcon: thumbIcon,
                value: enableChat,
                activeColor: theme.mintClr,
                onChanged: (bool val) {
                  setState(() {
                    enableChat = val;

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
          ],
        ),
      ),
    );
  }
}