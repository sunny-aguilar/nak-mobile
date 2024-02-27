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
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'INCIDENT REPORT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontFamily: 'College',
                    ),
                  ),
                  const Text(
                    'If this is an emergency situation, please call 911 immediately.\n\nPlease use this form to report concerns related to a Nu Alpha Kappa chapter or member. The report can be filed anonymously by omitting the contact information portions. However, omitting the contact information may impede the Fraternity\'s Risk Management Review Committee\'s ability to investigate.\n\nWhile completing this form, please answer each question in as much detail as possible. If you do not have information regarding a question, please so indicate.\n\nIf you are in possession of any emails, text messages, pictures or social media posts (Snapchat, Twitter, Facebook, Instagram, etc) in connection with this report please send them to riskmanagement@nakinc.org with the subject line "Incident Report Form."'
                  ),
                  const SizedBox(height: 18,),
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
                      prefixIcon: Icon(Icons.event_outlined),
                      labelText: 'Date of Incident',
                      helperText: '*required',
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
                        // initialEntryMode: DatePickerEntryMode.input,
                        // initialDatePickerMode: DatePickerMode.year,
                        helpText: 'Date of Incident',
                        cancelText: 'Nevermind',
                        confirmText: 'Confirm',
                        errorFormatText: 'Enter valid date',
                        builder: (BuildContext context, child) => Theme(
                          data: ThemeData(
                            colorScheme: const ColorScheme.light(
                              primary: Colors.black,
                            ),
                          ),
                          child: child!,
                        ),
                      );
                      date!.toIso8601String();
                      String convertedDate = '${date.month.toString().padLeft(2,'0')}-'
                                             '${date.day.toString().padLeft(2,'0')}-'
                                             '${date.year.toString()}';

                      dateCtl.text = convertedDate;
                    }, // onTap
                  ),
                  const SizedBox(height: 18,),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.edit_note_outlined,),
                      labelText: 'Description of Incident*',
                      helperText: '*required',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
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
                      labelText: 'Was a report filed with the University?',
                      helperText: '*required',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0)
                        ),
                      ),
                    ),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    items: <String>[
                      'Yes',
                      'No',
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
                      labelText: 'Did police respond?',
                      helperText: '*required',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0)
                        ),
                      ),
                    ),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    items: <String>[
                      'Yes',
                      'No',
                      "I don't know"
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
                      labelText: 'Would you like to receive a follow-up?',
                      helperText: '*required',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0)
                        ),
                      ),
                    ),
                    dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                    items: <String>[
                      'Yes',
                      'No',
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
                  TextButton(
                    style: ButtonStyle(
                      minimumSize: const MaterialStatePropertyAll<Size>(Size(400, 60),),
                      foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 255, 255, 255)),
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 0, 0)),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.white.withOpacity(0.3);
                          }
                          return null; // Defer to the widget's default.
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Submitting report')),
                        );
                      }
                    },
                    child: const Text('Submit', style: TextStyle(fontSize: 20.0),)
                  ),
                  const SizedBox(height: 58,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}