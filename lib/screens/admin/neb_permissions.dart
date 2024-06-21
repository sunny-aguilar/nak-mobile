import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/db/db_neb_permissions.dart' as db_neb;
import 'package:nak_app/services/theme_service.dart' as service;

class NebPermissionsScreen extends StatefulWidget {
  const NebPermissionsScreen({super.key});
  @override
  State<NebPermissionsScreen> createState() => _AddNebScreenState();
}

class _AddNebScreenState extends State<NebPermissionsScreen> {
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
      body: const UserListBody(),
    );
  }
}


class UserListBody extends StatefulWidget {
  const UserListBody({super.key});
  @override
  State<UserListBody> createState() => _UserListBodyState();
}

class _UserListBodyState extends State<UserListBody> {

  Future<void> _handleRefresh() async {
    setState(() {});
  }

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.greyClr,
        ),
      ),
    );
  }

  RefreshIndicator _buildUserList(data) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      backgroundColor: theme.lightGrey,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        prototypeItem: ListTile(
          title: Text(data[0].data()['chapter']),
          subtitle: const Text('User Subtitle', ),
        ),
        itemBuilder: (context, index) {
          Map<String, dynamic> userData = {};
          userData['firstName'] = data[index]['firstName'];
          userData['lastName'] = data[index]['lastName'];
          userData['uid'] = data[index]['uid'];
          userData['isActive'] = data[index]['isActive'];
          userData['nebStatus'] = data[index]['isNEB'];
          userData['adminStatus'] = data[index]['isAdmin'].contains('admin');
          userData['superAdminStatus'] = data[index]['isAdmin'].contains('superAdmin');

          return ListTile(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) {
                    return NebSettingsScreen(
                      username: '${userData['firstName']} ${userData['lastName']}',
                      uid: userData['uid'],
                      nebStatus: userData['nebStatus'],
                      adminStatus: userData['adminStatus'],
                      superAdminStatus: userData['superAdminStatus'],
                    );
                  },
                ),
              );

            },
            // tileColor: theme.greyClr,
            leading: CircleAvatar(
              backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
              child: Text('${data[index].data()['firstName'][0]}${data[index].data()['lastName'][0]}'),
            ),
            // title: Text('${data[index].data()['firstName']} ${data[index].data()['lastName']}'),
            title: Row(
              children: [
                Icon(Icons.circle, color: userData['nebStatus'] ? theme.mintClr : theme.pinkClr, size: 16,),
                Icon(Icons.circle, color: userData['adminStatus'] ? theme.mintClr : theme.pinkClr, size: 16,),
                Icon(Icons.circle, color: userData['superAdminStatus'] ? theme.mintClr : theme.pinkClr, size: 16,),
                Text(' ${data[index].data()['firstName']} ${data[index].data()['lastName']}')
              ],
            ),
            subtitle: Text('${data[index].data()['chapter']} chapter - ${data[index].data()['email']}', overflow: TextOverflow.ellipsis,),
            trailing: const Icon(Icons.arrow_forward_ios),

          );
        }
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.GetUsers().getAllUsers(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data.docs;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('NEB Permissions', style: theme.TextThemes.headlineMedLarge(context)),
              ),
              _buildUserList(data),
            ],
          );
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


// Route that displays switches for the user
class NebSettingsScreen extends StatefulWidget {
  const NebSettingsScreen({
    super.key,
    required this.username,
    required this.uid,
    required this.nebStatus,
    required this.adminStatus,
    required this.superAdminStatus
  })
  ;
  final String username;
  final String uid;
  final bool nebStatus;
  final bool adminStatus;
  final bool superAdminStatus;
  @override
  State<NebSettingsScreen> createState() => _NebSettingsScreenState();
}

class _NebSettingsScreenState extends State<NebSettingsScreen> {
  bool enabledNEB = false;
  bool enabledAdmin = false;
  bool enabledSuperAdmin = false;

  @override
  void initState() {
    super.initState();
    enabledNEB = widget.nebStatus;
    enabledAdmin = widget.adminStatus;
    enabledSuperAdmin = widget.superAdminStatus;
  }

  final WidgetStateProperty<Icon?> thumbIcon = WidgetStateProperty.resolveWith<Icon> (
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
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
            Text('NEB User Settings', textAlign: TextAlign.center, style: theme.TextThemes.drawerMenuNT(context),),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text(widget.username),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Make NEB Member:'),
              trailing: Switch(
                thumbIcon: thumbIcon,
                value: enabledNEB,
                activeColor: theme.mintClr,
                onChanged: (bool value) {
                  setState(() {
                    enabledNEB = value;

                    // add or remove NEB rights
                    if (value) {
                      db_neb.NebRights(uid: widget.uid).addRights();
                    }
                    else if (!value) {
                      db_neb.NebRights(uid: widget.uid).removeRights();
                    }

                  });
                },
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Make Admin:'),
              trailing: Switch(
                thumbIcon: thumbIcon,
                value: enabledAdmin,
                activeColor: theme.mintClr,
                onChanged: (bool value) {
                  setState(() {
                    enabledAdmin = value;

                    // add or remove admin rights
                    if (value) {
                      db_neb.AdminRights(uid: widget.uid).addRights();
                    }
                    else if (!value) {
                      db_neb.AdminRights(uid: widget.uid).removeRights();
                    }
                  });
                },
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Make Super Admin:'),
              trailing: Switch(
                thumbIcon: thumbIcon,
                value: enabledSuperAdmin,
                activeColor: theme.mintClr,
                onChanged: (bool value) {
                  setState(() {
                    enabledSuperAdmin = value;

                    // add or remove admin rights
                    if (value) {
                      db_neb.SuperAdminRights(uid: widget.uid).addRights();
                    }
                    else if (!value) {
                      db_neb.SuperAdminRights(uid: widget.uid).removeRights();
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}