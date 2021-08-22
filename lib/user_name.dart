import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserName extends StatefulWidget {
  const UserName({ Key key }) : super(key: key);
  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
  var nameText;
   getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       nameText = prefs.getString('name') ?? '';
    });
   }
   @override
  void initState() {
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Center(child: Text(nameText),),
      ),
    );
  }
}