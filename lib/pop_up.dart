import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Dialogs extends StatelessWidget {
 
  //alert dialog of confirmation
  static Future<void> feedback(BuildContext context) {
     TextEditingController name=TextEditingController();
    if (context == null) {
      return null;
    }

    return showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {},
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.4),
        barrierLabel: '',
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  contentPadding: EdgeInsets.only(left: 25, right: 25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  content: Container(
                    height: 500,
                    width: 300,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Enter your name',
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: name,
                                decoration:
                                    InputDecoration.collapsed(hintText: ""),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.30,
                              child: RaisedButton(
                                child: new Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.green,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                onPressed: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('name', name.text);
                                Future.delayed(const Duration(seconds: 1), () {
    Navigator.pop(context);
    });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
        transitionDuration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
