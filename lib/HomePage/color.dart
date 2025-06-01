import 'package:flutter/material.dart';

// Base class for theme colors
class AppColors {
  final Map<String, Color> colors;

  AppColors(this.colors);

  // Getter for each color property dynamically
  Color get primary => colors['primary']!;
  Color get secondary => colors['secondary']!;
  Color get tertiary => colors['tertiary']!;
  Color get quaternary => colors['quaternary']!;
  Color get background => colors['background']!;
  Color get Icon => colors['Icon']!;
  Color get IconNotActive => colors['IconNotActive']!;
  Color get primaryText => colors['primaryText']!;
  Color get secondaryText => colors['secondaryText']!;
  Color get tertiaryText => colors['tertiaryText']!;
  Color get QuaternaryText => colors['QuaternaryText']!;
  Color get QuinaryText => colors['QuinaryText']!;
  Color get NotificationPing => colors['NotificationPing']!;
  Color get MenuActive => colors['MenuActive']!;
  Color get MenuNotActive => colors['MenuNotActive']!;
  Color get CompanyDesc => colors['CompanyDesc']!;
  Color get NotificationHeader => colors['NotificationHeader']!;
  Color get NotificationBody => colors['NotificationBody']!;
  Color get BoxShadow => colors['BoxShadow']!;
  Color get SearchHint => colors['SearchHint']!;
  Color get ProfileDecoration => colors['ProfileDecoration']!;
  Color get ActiveUsersBackground => colors['ActiveUsersBackground']!;
  Color get ActiveUsersProgress => colors['ActiveUsersProgress']!;

  Color get SearchField => colors['searchField']!;


  Color get PiechartColor1 => Colors.red;
  Color get PiechartColor2 => Colors.blue;
  Color get PiechartColor3 => Colors.green;
  Color get PiechartColor4 => Colors.purple;
  Color get PiechartColor5 => Colors.pink;
  Color get PiechartColor6 => Colors.purpleAccent;
  Color get PiechartColor7 => Colors.deepOrange;
  Color get PiechartColor8 => Colors.lime;
  Color get success => Colors.green;
  Color get fail => Colors.redAccent;


}

// Provider.of<AppColors>(context).appColors.background,

// Dark theme colors
// class AppColorsDark extends AppColors {
//   AppColorsDark()
//       : super({
//     'primary': Colors.white.withOpacity(0.05),
//     'background': Colors.black,
//     // 'secondary': Colors.white.withOpacity(0.018),
//     'secondary': Colors.white.withOpacity(0.018),
//     'tertiary': Colors.white.withOpacity(0.05),
//     'quaternary': Colors.white.withOpacity(0.1),
//     'Icon': Colors.white70,
//     'IconNotActive': Colors.white30,
//     'primaryText': Colors.white,
//     'secondaryText': Colors.white60,
//     'tertiaryText': Colors.white70,
//     'QuaternaryText': Colors.white30,
//     'QuinaryText': Colors.white12,
//     'NotificationPing': Colors.red, //Notification
//     'MenuActive': Colors.white70, //Menu
//     'MenuNotActive': Colors.white54, //Menu
//     'CompanyDesc': Colors.white60, //Company Description
//     'NotificationHeader': Colors.white54, //Notification
//     'NotificationBody': Colors.white38, //Notification
//     'BoxShadow': Colors.black26, //Search Box
//     'SearchHint': Colors.white54, //Search Hint
//     'ProfileDecoration': Colors.blue.withOpacity(0.5), //Profile Decoration
//     'ActiveUsersBackground': Colors.grey.shade900,
//     'ActiveUsersProgress': Colors.blue.shade900,
//
//   });
// }

class AppColorsDark extends AppColors {
  AppColorsDark()
      : super({
    'primary': Color(0xFF131313),
    'background': Colors.black,
    'secondary': Color(0xFF1A1A1A),
    'tertiary': Color(0xFF1A1A1A),
    'quaternary': Color(0xFF424243),
    'Icon': Colors.white70,
    'IconNotActive': Colors.white30,

    'primaryText': Colors.white,
    'secondaryText': Colors.white60,
    'tertiaryText': Colors.white70,
    'QuaternaryText': Colors.white30,
    'QuinaryText': Colors.white12,
    'NotificationPing': Colors.red, //Notification
    'MenuActive': Colors.white70, //Menu
    'MenuNotActive': Colors.white54, //Menu
    'CompanyDesc': Colors.white60, //Company Description
    'NotificationHeader': Colors.white54, //Notification
    'NotificationBody': Colors.white38, //Notification
    'BoxShadow': Colors.black26, //Search Box
    'SearchHint': Colors.white54, //Search Hint
    'ProfileDecoration': Color(0xFF3D62EE), //Profile Decoration
    'ActiveUsersBackground': Colors.grey.shade900,
    'ActiveUsersProgress': Colors.blue.shade900,

    'searchField': Color(0xFF1A1A1A),

  });
}
// Provider.of<AppColors>(context).appColors.background

// Light theme colors
class AppColorsLight extends AppColors {
  AppColorsLight()
      : super({
    'primary': Color(0xFFF3F3F3),
    'background': Colors.white,
    'secondary': Color(0xFFFFFFFF),
    'tertiary': Colors.white.withOpacity(0.05),
    'quaternary': Color(0xFFDBDCDD),

    'Icon': Colors.black54,
    'IconNotActive': Colors.black45,

    'primaryText': Colors.black,
    // 'secondaryText': Colors.black87,
    'secondaryText': Color(0x94131313),
    'tertiaryText': Colors.black54,
    'QuaternaryText': Colors.black45,
    'QuinaryText': Colors.black12,

    'NotificationPing': Colors.red, //Notification
    'MenuActive': Colors.black, //Menu
    'MenuNotActive': Colors.black87, //Menu
    'CompanyDesc': Colors.black54, //Company Description
    'NotificationHeader': Colors.black54, //Notification
    'NotificationBody': Colors.black38, //Notification
    'BoxShadow': Colors.white24, //Search Box
    'SearchHint': Colors.black54, //Search Hint
    'ProfileDecoration': Color(0xFF00B6EE), //Profile Decoration
    'ActiveUsersBackground': Colors.grey.shade500, //ActiveUsers
    'ActiveUsersProgress': Colors.blue.shade500, //ActiveUsers


    'searchField': Color(0xFFFFFFFF),

  });
}


// class AppColorsLight extends AppColors {
//   AppColorsLight()
//       : super({
//     'primary': Colors.white,
//     'background': Colors.white.withOpacity(0.018),
//     'secondary': Colors.white,
//     'tertiary': Colors.white24,
//
//     'Icon': Colors.black54,
//     'IconNotActive': Colors.black45,
//
//     'primaryText': Colors.black,
//     'secondaryText': Colors.black87,
//     'tertiaryText': Colors.black87,
//     'QuaternaryText': Colors.black45,
//     'QuinaryText': Colors.black12,
//
//     'NotificationPing': Colors.red, //Notification
//     'MenuActive': Colors.black87, //Menu
//     'MenuNotActive': Colors.black54, //Menu
//     'CompanyDesc': Colors.black54, //Company Description
//     'NotificationHeader': Colors.black54, //Notification
//     'NotificationBody': Colors.black38, //Notification
//     'BoxShadow': Colors.white24, //Search Box
//     'SearchHint': Colors.black54, //Search Hint
//     'ProfileDecoration': Colors.blue.withOpacity(0.5), //Profile Decoration
//     'ActiveUsersBackground': Colors.grey.shade500,
//     'ActiveUsersProgress': Colors.blue.shade500,
//   });
// }