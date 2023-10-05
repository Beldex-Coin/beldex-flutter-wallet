import 'package:flutter/material.dart';
void displaySnackBar(BuildContext context, String text){
final _height = MediaQuery.of(context).size.height*0.30/3;
ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                           margin: EdgeInsets.only(bottom:_height,
                                                           left: _height,
                                                           right: _height
                                                           ),
                                                            elevation:0, //5,
                                                            behavior: SnackBarBehavior.floating,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15.0) //only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                                                            ),
                                                            content: Text(text,style: TextStyle(color: Color(0xffffffff),fontWeight:FontWeight.w700,fontSize:15) ,textAlign: TextAlign.center,),
                                                            backgroundColor: Color(0xff0BA70F), //.fromARGB(255, 46, 113, 43),
                                                            duration: Duration(
                                                                milliseconds: 1500),
                                                          ));
}