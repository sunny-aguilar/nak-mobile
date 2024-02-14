import 'package:flutter/material.dart';

class RedCard extends StatelessWidget {
  const RedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color.fromARGB(175, 196, 18, 48),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(175, 196, 18, 48), width: 3,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.stacked_bar_chart,
              color: Color.fromARGB(175, 196, 18, 48),
            ),
            title: RichText(
              text: const TextSpan(
                // style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "Red Card",
                    style: TextStyle(
                      color: Color.fromARGB(175, 196, 18, 48),
                      fontSize: 20,
                      fontFamily: "HelveticaNeue",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: const Text(
              "Read the latest state of the fraternity union.",
              style: TextStyle(
                color: Color.fromARGB(175, 196, 18, 48),
                fontSize: 14,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () => {},
                child: const Text(
                  "KEEP READING",
                  style: TextStyle(
                    color: Color.fromARGB(175, 196, 18, 48),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
