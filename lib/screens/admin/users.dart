import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;
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
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.greyClr,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.GetUsers().getAllUsers(),
      builder: (BuildContext context, snapshot) {

        if (!snapshot.hasData) { _circularProgress(); }
        else if (snapshot.data == null) { _circularProgress(); }
        else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

          final data = snapshot.data.docs;
          final count = snapshot.data.docs.length;
          print('data: ${data[0].data()}');

          return ListView.builder(
            itemCount: count,
            prototypeItem: const ListTile(
              title: Text('UserName'),
              subtitle: Text('Chapter'),
            ),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
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