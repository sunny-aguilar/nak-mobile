import 'package:flutter/material.dart';

Padding textLayout({required BuildContext context, required Map policyTxt, required Function scrollUp}) {
  const double spacer = 10.0;
  String policyTitle = policyTxt['overview'];
  String policyHeader = policyTxt['header'];
  String summary = policyTxt['summary'];
  List paragraphList = policyTxt['paragraphs'];

  // add text to row and append to Column widget
  List<Widget> rows = [];

  // add page info text
  rows = rows + [
    Row(
      children: <Widget>[
        Text(
          policyTitle,
          style: const TextStyle(
            fontFamily: 'Clarendon',
            fontSize: 36,
            color: Color.fromARGB(255, 49, 49, 49),
          ),
        ),
      ],
    ),
    const SizedBox(
      height: spacer,
    ),
    Row(
      children: <Widget>[
        Expanded(
          child: Text(
            policyHeader,
            style: const TextStyle(
              fontFamily: 'LuloClean',
              fontSize: 10,
              color: Color.fromARGB(255, 49, 49, 49),
            ),
          ),
        ),
      ],
    ),
    const SizedBox(
      height: spacer,
    ),
    Row(
      children: <Widget>[
        Expanded(
          child: Text(
            summary,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: Color.fromARGB(255, 49, 49, 49),
            ),
          ),
        ),
      ],
    ),
    const SizedBox(
      height: spacer,
    ),
  ];

  // add all other paragraphs
  for (final p in paragraphList) {
    // print('P: $p');
    rows.add(
      Row(
          children: <Widget>[
            Expanded(
              child: Text(
                p,
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 14,
                  color: Color.fromARGB(255, 49, 49, 49),
                ),
              ),
            ),
          ],
        ),
    );
    rows.add(
      const SizedBox(
          height: spacer,
      ),
    );
  }

  // append final text
  rows += [
    const Divider(
      color: Color.fromARGB(255, 174, 174, 174),
    ),
    const SizedBox(
      height: spacer,
    ),
     Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_circle_up, size: 30,),
              onPressed: () {
                scrollUp();
              },
            ),
          ),
          // child: Text(
          //   "fin",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontFamily: 'Clarendon',
          //     fontSize: 14,
          //     color: Color.fromARGB(255, 49, 49, 49),
          //   ),
          // ),
        ),
        const SizedBox(height: 70,),
      ],
    )
  ];

  // return completed page text
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: rows,
    ),
  );
}