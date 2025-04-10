import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/screens/directory/directory_model.dart' as db;


class AddBro extends StatefulWidget {
  const AddBro({super.key, required this.chapterID});
  final String chapterID;
  @override
  State<AddBro> createState() => _AddBroState();
}

class _AddBroState extends State<AddBro> {
  final _addDirectoryFormKey = GlobalKey<FormState>();
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _classCtl = TextEditingController();
  final TextEditingController _numberCtl = TextEditingController();

  late Map userData = {};

  void getUserName() async {
    db.Directory().getUserData().then((val) {
      userData['modifiedBy'] = '${val['firstName']} ${val['lastName']}';
      userData['modifiedDate'] = getTimeStamp();
      userData['uid'] = val['uid'];
    });
  }

  String getTimeStamp() {
    final now = DateTime.now();
    String formatter = DateFormat('yMMMd').format(now);
    return formatter;
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _classCtl.dispose();
    _numberCtl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 38,
        // title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        title: Text('Add A Bro', style: theme.TextThemes.collegeText(context)),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _addDirectoryFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20,),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      helperText: 'Enter the bro\'s name'
                    ),
                    controller: _nameCtl,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Class',
                      helperText: 'Crossing class'
                    ),
                    controller: _classCtl,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter a crossing class';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Line number',
                      helperText: 'Line number'
                    ),
                    controller: _numberCtl,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (int.tryParse(val!) == null) {
                        return 'Please enter a line number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),

                  TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: Text('Add Bro'),
                  onPressed: () {
                    // show snackbar
                    if (_addDirectoryFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitting the edits...'),),
                      );

                      // save edited bro data
                      Map<String, dynamic> data = {};
                      data['name'] = _nameCtl.text.trim();
                      data['className'] = _classCtl.text.trim();
                      data['lineNumber'] = _numberCtl.text.trim();
                      data['modifiedBy'] = userData;
                      db.Directory().addBrother(data, widget.chapterID);

                      // go back to previous screen
                      Navigator.pop(context);
                    }
                  },
                ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}