import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedValue;
  List<String> listOfValue = ['1', '2', '3', '4', '5'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(26.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Contact Form'),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_2_outlined),
                      labelText: 'Your Name*',
                      helperText: '*required',
                      // errorText: 'need a name!',
                      // contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    // onChanged: (text) {
                    //   print('Text Length: ${text.characters.length}');
                    // },
                  ),
                  const SizedBox(height: 18,),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Your Email*',
                      helperText: '*required',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18,),
                  DropdownButtonFormField(
                    hint: const Text(
                      'Select an Item',
                      style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                            fontFamily: 'Roboto'
                          ),
                    ),
                    onChanged: (val) {},
                    decoration: const InputDecoration(
                      labelText: 'Nature of Incident',
                      hintText: '*required',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0)
                        ),
                      ),
                    ),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    items: <String>[
                      'Chapter conduct matter',
                      'Hazing matter',
                      'Member conduct matter',
                      'Member well-being concern',
                      'Title IX',
                      'Other concern',
                    ]
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
