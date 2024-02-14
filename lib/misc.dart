
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 196, 18, 48),
                Color.fromARGB(255, 241, 241, 241),
                Color.fromARGB(255, 200, 183, 131),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
        ),
        Container(
          width: 420,
          height: 60,
          color: const Color.fromARGB(255, 200, 183, 131),
        ),
        Transform.rotate(
          angle: 0.2,
          // alignment: Alignment.topLeft,
          child: Container(
            width: 400,
            height: 60,
            color: const Color.fromARGB(255, 200, 183, 131),
          ),
        ), 
        Transform.rotate(
          angle: 0.4,
          // alignment: Alignment.topLeft,
          child: Container(
            width: 400,
            height: 60,
            color: const Color.fromARGB(255, 241, 241, 241),
          ),
        ), 
        Transform.rotate(
          angle: 0.6,
          // alignment: Alignment.topLeft,
          child: Container(
            width: 420,
            height: 60,
            color: const Color.fromARGB(255, 196, 18, 48),
          ),
        ),
      ],
    );
  }
}




class BirthDayCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    double sideRadius = 30.0;
    double midPoint = size.height * (3/5);
    double cornerRadius = 20.0;

    path.moveTo(0, cornerRadius);
    path.lineTo(0, (midPoint - sideRadius));

    //LEFT ARC
    path.quadraticBezierTo(
        sideRadius, midPoint - sideRadius, 
        sideRadius, midPoint
    );
    path.quadraticBezierTo(
        sideRadius, midPoint + sideRadius,
        0, midPoint + sideRadius
    );

    path.lineTo(0, size.height - cornerRadius);

    //BottomLeft
    path.quadraticBezierTo(
        0, size.height,
        cornerRadius, size.height
    );

    path.lineTo(size.width - cornerRadius, size.height);

    //BottomRight
    path.quadraticBezierTo(
        size.width, size.height,
        size.width, size.height - cornerRadius
    );

    path.lineTo(size.width, (midPoint + sideRadius));

    //RIGHT ARC
    path.quadraticBezierTo(
        (size.width - sideRadius), (midPoint + sideRadius),
        (size.width - sideRadius), (midPoint)
    );
    path.quadraticBezierTo(
        (size.width - sideRadius), (midPoint - sideRadius),
        size.width, midPoint - sideRadius
    );

    path.lineTo(size.width, cornerRadius);

    //TopRight
    path.quadraticBezierTo(
        size.width, 0,
        size.width - cornerRadius, 0
    );

    path.lineTo(cornerRadius, 0);

    //TopLeft
    path.quadraticBezierTo(
        0, 0,
        0, cornerRadius
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

