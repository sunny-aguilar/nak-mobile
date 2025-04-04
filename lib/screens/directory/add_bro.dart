import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class AddBro extends StatelessWidget {
  const AddBro({super.key, required this.broData});
  final Map<String, dynamic> broData;

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
      body: EditBroData(broData: broData,),
    );
  }
}


class EditBroData extends StatefulWidget {
  const EditBroData({super.key, required this.broData});
  final Map<String, dynamic> broData;
  @override
  State<EditBroData> createState() => _EditBroDataState();
}

class _EditBroDataState extends State<EditBroData> {
  final _editDirectoryFormKey = GlobalKey<FormState>();
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _classCtl = TextEditingController();

  @override
  void dispose() {
    _nameCtl.dispose();
    _classCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Text('Add or Edit a Bro'),
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
                  controller: _classCtl,
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if ((val == null || val.isEmpty) && val.runtimeType != num) {
                      return 'Please enter a line number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),


              ],
            ),
          ),
        ],
      ),
    );
  }
}