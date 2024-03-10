import 'package:flutter/material.dart';
import 'package:nak_app/ui/theme.dart' as theme;

/// Adds the content to the resource screen (text)
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
          style: theme.TextThemes.resourceTitle(context),
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
            style: theme.TextThemes.resourceHeadline(context),
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
            style: theme.TextThemes.resourceBody(context),
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
                style: theme.TextThemes.resourceBody(context),
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
      color: theme.greyClr,
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
        ),
        const SizedBox(height: 70,),
      ],
    )
  ];

  // return completed page text
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: rows,
    ),
  );
}