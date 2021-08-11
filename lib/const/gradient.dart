import 'package:flutter/material.dart';

const mainBgColor = Color(0xFFd8ae50);
const darkColor = Color(0xFF134b8e);
const midColor = Color(0xFFd8ae50);
const lightColor = Color(0xFFd8ae50);
const darkRedColor = Color(0xFFFA695C);
const lightRedColor = Color(0xFFFD685A);
const primaryColor = Color(0xFF134b8e);

const farletzaGradient = LinearGradient(
  colors: <Color>[darkColor, midColor, lightColor],
  stops: [0.0, 0.6, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const redGradient = LinearGradient(
  colors: <Color>[darkRedColor, lightRedColor],
  stops: [0.0, 1.0],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const USER_IMAGE =
    'https://cdn4.iconfinder.com/data/icons/people-avatar-flat-1/64/girl_chubby_beautiful_people_woman_lady_avatar-512.png';
