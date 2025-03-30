import 'package:flutter/material.dart';

// curved Style
const CurvedBackground kcurvedBackground = CurvedBackground();

class CurvedBackground extends StatelessWidget {
  final double height;
  final Widget? child;

  const CurvedBackground({
    Key? key,
    this.height = 200, // Default height
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomCurveClipper(),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.green.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        if (child != null) Positioned.fill(child: child!),
      ],
    );
  }
}

class CustomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

const TextStyle Kheaderstyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

final ButtonStyle kOutlineButtonStyle = OutlinedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  side: const BorderSide(color: Colors.black),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
);

class CategoryButton extends StatelessWidget {
  final String label;
  final Color color;

  CategoryButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // FIXED: Updated primary color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}
