import 'package:bereal_app/styles/colors.dart';
import 'package:bereal_app/styles/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = Provider(((ref) => AppColors().toThemeData()));
final stylesProvider = Provider(((ref) => AppStyle()));
