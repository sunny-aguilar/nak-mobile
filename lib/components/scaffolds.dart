import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:nak_app/screens/admin/users.dart' as users;
import 'package:nak_app/ui/theme.dart' as theme;

// return a floating action button for users who are admins
class ScaffoldType {
  SizedBox nonadminUser(context) {
    return const SizedBox.shrink();
  }

  FloatingActionButton adminUser(context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/newBlog');
      },
      foregroundColor: theme.primaryClr,
      backgroundColor: theme.redClr,
      label: const Text('Blog'),
      icon: const Icon(Icons.add),
    );
  }
}


// return the Super Admin floating action button
class SpeedDialButton extends StatelessWidget {
  const SpeedDialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 28.0),
      foregroundColor: theme.primaryClr,
      backgroundColor: theme.redClr,
      overlayColor: theme.blackClr,
      buttonSize: const Size(56.0, 56.0),
      visible: true,
      curve: Curves.bounceInOut,
      spacing: 8.0,
      spaceBetweenChildren: 10.0,
      childrenButtonSize: const Size(76.0, 56.0),
      children: [
        SpeedDialChild(
          child: const Icon(Icons.create_rounded),
          onTap: () { Navigator.pushNamed(context, '/newBlog'); },
          // backgroundColor: theme.primaryClr,
          label: 'New Blog'
        ),
        SpeedDialChild(
          child: const Icon(Icons.edit),
          onTap: () { Navigator.pushNamed(context, '/editBlog'); },
          // backgroundColor: theme.primaryClr,
          label: 'Edit Blogs'
        ),
        SpeedDialChild(
          child: const Icon(Icons.person_add),
          onTap: () { Navigator.pushNamed(context, '/addNEB'); },
          // backgroundColor: theme.primaryClr,
          label: 'NEB Permissions'
        ),
        SpeedDialChild(
          child: const Icon(Icons.person),
          onTap: () {
            // see how this navigator varies from 'pushNamed()'
            Navigator.push(
              context,
              MaterialPageRoute( builder: (BuildContext context) => const users.AllUsers(), ),
            );
          },
          // backgroundColor: theme.primaryClr,
          label: 'Permissions'
        ),
        SpeedDialChild(
          child: const Icon(CupertinoIcons.bubble_left_bubble_right_fill),
          onTap: () {
            Navigator.pushNamed(context, '/chatMaintenance');
          },
          label: 'Chat Maintenance'
        ),
      ],
    );
  }
}