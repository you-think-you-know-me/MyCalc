import 'package:flutter/material.dart';


const COLOR_PRIMARY=Color.fromARGB(255, 14, 66, 109);
const COLOR_PRIMARYdark=Color.fromARGB(255, 17, 40, 80);


ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  appBarTheme: AppBarTheme(backgroundColor: COLOR_PRIMARY,),
  elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(COLOR_PRIMARY),
     )
  ),
  drawerTheme: DrawerThemeData(backgroundColor: COLOR_PRIMARY,),
  switchTheme: SwitchThemeData(trackColor: MaterialStateProperty.all(Colors.white),
  thumbColor: MaterialStateProperty.all(Colors.black),
  ),


  );


ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
   primaryColor: COLOR_PRIMARYdark,
   appBarTheme: AppBarTheme(backgroundColor: COLOR_PRIMARYdark,),
  elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(COLOR_PRIMARYdark),
        )
      ),
  drawerTheme: DrawerThemeData(backgroundColor: COLOR_PRIMARYdark),
  switchTheme: SwitchThemeData(trackColor: MaterialStateProperty.all(Colors.black),
  thumbColor: MaterialStateProperty.all(Colors.white),
  ),

   );
