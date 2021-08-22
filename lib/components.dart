import 'package:flutter/material.dart';
import 'package:webzent/internet_speed_test.dart';
import 'package:webzent/payment_gateway.dart';
import 'package:webzent/pop_up.dart';
import 'package:webzent/user_list.dart';
import 'package:webzent/user_name.dart';

class Components extends StatefulWidget {
  const Components({Key key}) : super(key: key);

  @override
  _ComponentsState createState() => _ComponentsState();
}

class _ComponentsState extends State<Components> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => InternetSpeedTesting()));
                  },
                  child: Container(
                    height:50,
                    width:100,
                      color: Colors.blue[400], child: Text('Internet speed',style:TextStyle(color:Colors.white)))),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PaymentGateway()));
                  },
                  child: Container(
                    height:50,
                     width:100,
                      color: Colors.blue[400], child: Text('Payment gateway',style:TextStyle(color:Colors.white)))),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => UserList()));
                  },
                  child: Container(
                    height:50,
                    width:100,
                      color: Colors.blue[400], child: Text('User List',style:TextStyle(color:Colors.white)))),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => UserName()));
                  },
                  child: Container(
                    height:50,
                     width:100,
                      color: Colors.blue[400], child: Text('Get Name',style:TextStyle(color:Colors.white)))),
             
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Dialogs.feedback(context);
                  },
                  child: Container(
                    height:50,
                    width:100,
                      color: Colors.blue[400], child: Text('Enter Name',style:TextStyle(color:Colors.white)))),
            ],
          ),
        ),
      ),
    );
  }
}
