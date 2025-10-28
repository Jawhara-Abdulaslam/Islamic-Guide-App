
import 'package:flutter/material.dart';

class Responsive
{
  static late MediaQueryData _madiaQueryData;
  static late double widthscreen;
  static late double hightscreen;
  static Orientation ?_orientation;


  void init(BuildContext context)
  {
    _madiaQueryData=MediaQuery.of(context);
    widthscreen=_madiaQueryData.size.width;
    hightscreen=_madiaQueryData.size.height;
    _orientation=_madiaQueryData.orientation;
  }
}
double getHscreen(double higtscreen)//20
{
  return(higtscreen / 667 ) *
      Responsive.hightscreen;

}
double getWscreen(double wigtscreen)//20
{
  return(wigtscreen / 375 ) *
      Responsive.widthscreen;

}
double getFontSize(double FontSize)//20
{
  return(FontSize / 375 ) *
      Responsive.widthscreen;

}


