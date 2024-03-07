import 'package:flutter/material.dart';
import 'package:nak_app/components/mailer.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});
  @override
  State<ContactScreen> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controllers
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _natureCtl = TextEditingController();
  final TextEditingController _urgencyCtl = TextEditingController();
  final TextEditingController _locationCtl = TextEditingController();
  final TextEditingController _dateCtl = TextEditingController();
  final TextEditingController _descCtl = TextEditingController();
  final TextEditingController _uniCtl = TextEditingController();
  final TextEditingController _policeCtl = TextEditingController();
  final TextEditingController _followUpCtl = TextEditingController();
  final Map _formData = {
    'name': '',
    'email': '',
    'nature': '',
    'urgency': '',
    'location': '',
    'date': '',
    'uni': '',
    'police': '',
    'followUp': '',
  };

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _nameCtl.dispose();
    _emailCtl.dispose();
    _natureCtl.dispose();
    _urgencyCtl.dispose();
    _locationCtl.dispose();
    _dateCtl.dispose();
    _descCtl.dispose();
    _uniCtl.dispose();
    _policeCtl.dispose();
    _followUpCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: theme.primaryClr,
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
                  Text(
                    'If this is an emergency situation, please call 911 immediately.\n\nPlease use this form to report concerns related to a Nu Alpha Kappa chapter or member. The report can be filed anonymously by omitting the contact information portions. However, omitting the contact information may impede the Fraternity\'s Risk Management Review Committee\'s ability to investigate.\n\nWhile completing this form, please answer each question in as much detail as possible. If you do not have information regarding a question, please so indicate.\n\nIf you are in possession of any emails, text messages, pictures or social media posts (Snapchat, Twitter, Facebook, Instagram, etc) in connection with this report please send them to riskmanagement@nakinc.org with the subject line "Incident Report Form."',
                    style: theme.TextThemes.headline(context),
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
                    // onChanged: (text) {
                    //   print('Text Length: ${text.characters.length}');
                    // },
                    controller: _nameCtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18,),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Your Email*',
                      helperText: '*required',
                      border: OutlineInputBorder(),
                    ),
                    controller: _emailCtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
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
                    onChanged: (val) {
                      _natureCtl.text = val!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a response';
                      }
                      return null;
                    },
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
                    onChanged: (val) {
                      _urgencyCtl.text = val!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a response';
                      }
                      return null;
                    },
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
                      'Urgent matter',
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
                      prefixIcon: Icon(Icons.event_outlined),
                      labelText: 'Date of Incident',
                      helperText: '*required',
                      border: OutlineInputBorder(),
                    ),
                    controller: _dateCtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
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

                      _dateCtl.text = convertedDate;
                    }, // onTap
                  ),
                  const SizedBox(height: 18,),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      labelText: 'Location of Incident*',
                      helperText: '*required',
                      border: OutlineInputBorder(),
                    ),
                    controller: _locationCtl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
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
                    controller: _descCtl,
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
                    onChanged: (val) {
                      _uniCtl.text = val!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a response';
                      }
                      return null;
                    },
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
                    onChanged: (val) {
                      _policeCtl.text = val!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a response';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.local_police_outlined),
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
                    onChanged: (val) {
                      _followUpCtl.text = val!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a response';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.local_phone_outlined),
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
                      // store form field data into MAP
                      _formData['name'] = _nameCtl.text;
                      _formData['email'] = _emailCtl.text;
                      _formData['nature'] = _natureCtl.text;
                      _formData['urgency'] = _urgencyCtl.text;
                      _formData['date'] = _dateCtl.text;
                      _formData['location'] = _locationCtl.text;
                      _formData['desc'] = _descCtl.text;
                      _formData['uni'] = _uniCtl.text;
                      _formData['police'] = _policeCtl.text;
                      _formData['followUp'] = _followUpCtl.text;

                      // send email if validation passes
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Submitting report...')),
                        );
                        sendEmail(context, _formData);
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