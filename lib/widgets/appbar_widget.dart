import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  final Function() func;
  final MaterialPageRoute materialPageRoute;

  const CustomAppBar(
      {Key? key,
      required this.color,
      required this.image,
      required this.title,
      required this.func,
      required this.materialPageRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: GoogleFonts.lato(
            textStyle: TextStyle(
                color: color, fontWeight: FontWeight.w600, fontSize: 16)),
      ),
      leading: IconButton(
        icon: Image.asset(
          image,
        ),
        onPressed: func,
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              //_formKey.currentState.reset();
              Navigator.pushReplacement(context, materialPageRoute);
            },
            icon: Icon(
              Icons.restore,
              color: color,
            ))
      ],
    );
  }
}
