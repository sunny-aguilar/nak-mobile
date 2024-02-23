import 'package:flutter/material.dart';

Padding textLayout({required BuildContext context, required txtInfo, required List paragraphs}) {
  const double spacer = 10.0;
  String title = txtInfo['overview'];
  String header = txtInfo['header'];
  String summary = txtInfo['summary'];

  // add text to row and append to Column widget
  List<Widget> rows = [];

  // add page info text
  rows = rows + [
    Row(
      children: <Widget>[
        Text(
          title,
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
            header,
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
  for (final p in paragraphs) {
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

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: rows,
    ),
  );

  // return Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: Column(
  //     children: <Widget>[
  //       Row(
  //         children: <Widget>[
  //           Text(
  //             title,
  //             style: const TextStyle(
  //               fontFamily: 'Clarendon',
  //               fontSize: 36,
  //               color: Color.fromARGB(255, 49, 49, 49),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               header,
  //               style: const TextStyle(
  //                 fontFamily: 'LuloClean',
  //                 fontSize: 10,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               summary,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p1,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p2,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p3,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p4,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p5,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p6,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p7,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p8,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p9,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p10,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p11,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p12,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               p13,
  //               style: const TextStyle(
  //                 fontFamily: 'Georgia',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       const Divider(
  //         color: Color.fromARGB(255, 174, 174, 174),
  //       ),
  //       const SizedBox(
  //         height: spacer,
  //       ),
  //       const Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: Text(
  //               "fin",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontFamily: 'Clarendon',
  //                 fontSize: 14,
  //                 color: Color.fromARGB(255, 49, 49, 49),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(
  //         height: 14.0,
  //       ),
  //     ],
  //   ),
  // );
}

// class TextLayout extends StatelessWidget {
//   final double spacer = 10.0;
//   final String title = conductTxt['overview'] ?? '';
//   final String header = conductTxt['header'] ?? '';
//   final String summary = conductTxt['summary'] ?? '';
//   final String p1 = conductTxt['p1'] ?? '';
//   final String p2 = conductTxt['p2'] ?? '';
//   final String p3 = conductTxt['p3'] ?? '';
//   final String p4 = conductTxt['p4'] ?? '';
//   final String p5 = conductTxt['p5'] ?? '';
//   final String p6 = conductTxt['p6'] ?? '';
//   final String p7 = conductTxt['p7'] ?? '';
//   final String p8 = conductTxt['p8'] ?? '';
//   final String p9 = conductTxt['p9'] ?? '';
//   final String p10 = conductTxt['p10'] ?? '';
//   final String p11 = conductTxt['p11'] ?? '';
//   final String p12 = conductTxt['p12'] ?? '';
//   final String p13 = conductTxt['p13'] ?? '';
//   TextLayout({super.key});

//   @override
//   Widget build(BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Text(
//               title,
//               style: const TextStyle(
//                 fontFamily: 'Clarendon',
//                 fontSize: 36,
//                 color: Color.fromARGB(255, 49, 49, 49),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 header,
//                 style: const TextStyle(
//                   fontFamily: 'LuloClean',
//                   fontSize: 10,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 summary,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p1,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p2,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p3,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p4,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p5,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p6,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p7,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p8,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p9,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p10,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p11,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p12,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 p13,
//                 style: const TextStyle(
//                   fontFamily: 'Georgia',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         const Divider(
//           color: Color.fromARGB(255, 174, 174, 174),
//         ),
//         SizedBox(
//           height: spacer,
//         ),
//         const Row(
//           children: <Widget>[
//             Expanded(
//               child: Text(
//                 "fin",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontFamily: 'Clarendon',
//                   fontSize: 14,
//                   color: Color.fromARGB(255, 49, 49, 49),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 14.0,
//         ),
//       ],
//     ),
//   );
//   }
// }
