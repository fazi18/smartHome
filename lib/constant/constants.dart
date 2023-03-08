import 'dart:math';

import 'package:flutter/material.dart';

double degToRad(double deg) => deg * (pi / 180.0);

num normalize(value, min, max) => ((value - min) / (max - min));

const Color kScaffoldBackgroundColor = Color(0xFFF3FBFA);
const double kDiameter = 230;
const double kMinDegree = 20;
const double kMaxDegree = 100;
