import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

class AddNebScreen extends StatefulWidget {
  const AddNebScreen({super.key});
  @override
  State<AddNebScreen> createState() => _AddNebScreenState();
}

class _AddNebScreenState extends State<AddNebScreen> {
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

  CircularProgressIndicator _circularProgress() {
    return const CircularProgressIndicator(
      strokeWidth: 5,
      color: theme.redClr,
      backgroundColor: theme.greyClr,
    );
  }

  ListView _buildUserList(data) {
    // List<String> items = List<String>.generate(2, (i) => 'Item $i');
    // print('Runtime: $data');
    // print('Len: ${data.length}');
    // print('Element: ${data[0].data()}');
    // print('Chapter: ${data[0].data()['chapter']}');
    return ListView.builder(
      itemCount: data.length,
      prototypeItem: ListTile(
        title: Text(data[0].data()['chapter']),
        subtitle: const Text('Subtitle'),
      ),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<Widget>(builder: (BuildContext context) {
                return const NebSettingsScreen();
              }),
            );
          },
          // tileColor: theme.greyClr,
          leading: CircleAvatar(
            backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
            child: Text('${data[index].data()['firstName'][0]}${data[index].data()['lastName'][0]}'),
          ),
          title: Text('${data[index].data()['firstName']} ${data[index].data()['lastName']}'),
          subtitle: Text('${data[index].data()['chapter']} chapter'),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.GetUsers().getAllUsers(),
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


class NebSettingsScreen extends StatefulWidget {
  const NebSettingsScreen({super.key});
  @override
  State<NebSettingsScreen> createState() => _NebSettingsScreenState();
}

class _NebSettingsScreenState extends State<NebSettingsScreen> {
  bool enabledNEB = false;
  bool enabledAdmin = false;
  bool enabledSuperAdmin = false;

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
            Text('User Settings', textAlign: TextAlign.center, style: theme.TextThemes.drawerMenu(context),),
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