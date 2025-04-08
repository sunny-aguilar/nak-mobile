import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/screens/directory/directory_model.dart' as db;

class EditBro extends StatelessWidget {
  const EditBro({super.key, required this.broLineNumber, required this.broData, required this.chapterID});
  final String broLineNumber;
  final Map<String, dynamic> broData;
  final String chapterID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 38,
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
      body: EditBroData(chapterID: chapterID, broLineNumber: broLineNumber,),
    );
  }
}

class EditBroData extends StatefulWidget {
  const EditBroData({super.key, required this.chapterID, required this.broLineNumber});
  final String chapterID;
  final String broLineNumber;
  @override
  State<EditBroData> createState() => _EditBroDataState();
}

class _EditBroDataState extends State<EditBroData> {
  final _editDirectoryFormKey = GlobalKey<FormState>();
  TextEditingController _nameCtl = TextEditingController();
  TextEditingController _classCtl = TextEditingController();
  TextEditingController _numberCtl = TextEditingController();

  late Map chapterData = {};
  late Map<String, dynamic> broData = {};
  late String userName = '';

  void initializeTextFields() async {
    db.Directory().chapterDataMap(widget.chapterID).then((val) {
      chapterData = val;
      broData = chapterData['brother'][widget.broLineNumber];
      _nameCtl = TextEditingController(text: broData['name']);
      _classCtl = TextEditingController(text: broData['className']);
      _numberCtl = TextEditingController(text: broData['lineNumber'].toString());
      setState(() {});
    });
  }

  void getUserName() async {
    db.Directory().getUserData().then((val) {
      userName = '${val['firstName']} ${val['lastName']}';
    });
  }

  String getTimeStamp() {
    final now = DateTime.now();
    String formatter = DateFormat('yMMMd').format(now);
    return formatter;
  }

  @override
  void initState() {
    super.initState();
    initializeTextFields();
    getUserName();
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _classCtl.dispose();
    _numberCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('User: $userName');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Form(
            key: _editDirectoryFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20,),
                Text('Edit a Bro'),
                const SizedBox(height: 10,),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    helperText: 'Edit the bro\'s name'
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
                    if ((val == null || val.isEmpty) && val.runtimeType != num) {
                      return 'Please enter a line number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),

                TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: Text('Submit Edits'),
                  onPressed: () {
                    // show snackbar
                    if (_editDirectoryFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitting the edits...'),),
                      );
                      // go back to previous screen
                      Navigator.pop(context);

                      // save edited bro data
                      Map<String, dynamic> data = {};
                      data['name'] = _nameCtl.text.trim();
                      data['className'] = _classCtl.text.trim();
                      data['lineNumber'] = _numberCtl.text.trim();
                      data['modifiedBy'] = userName;
                      data['modifiedDate'] = getTimeStamp();
                      db.Directory().editBrother(data, widget.chapterID);
                    }
                  },
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}