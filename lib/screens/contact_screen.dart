import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  // DATETIME CONTROLLER
  TextEditingController dateCtl = TextEditingController();
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
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    onChanged: (val) {},
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.checklist),
                      labelText: 'Nature of Incident',
                      helperText: '*required',
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
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18,),
                  DropdownButtonFormField(
                    hint: const Text(
                      'Select an Item',
                      style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    onChanged: (val) {},
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.checklist),
                      labelText: 'Urgency of Incident',
                      helperText: '*required',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0)
                        ),
                      ),
                    ),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    items: <String>[
                      'Urgen matter',
                      'Normal concern',
                    ]
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18,),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      labelText: 'Location of Incident*',
                      helperText: '*required',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18,),
                  TextFormField(
                    controller: dateCtl,
                    decoration: const InputDecoration(
                      labelText: 'Date of Incident',
                      hintText: '*required',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? date = DateTime.now();
                      FocusScope.of(context).requestFocus(FocusNode());
                      date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1988),
                        lastDate: DateTime(2088),
                      );
                      date!.toIso8601String();
                      String convertedDate = '${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}-${date.year.toString()}';

                      dateCtl.text = convertedDate;
                    },
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