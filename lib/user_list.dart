import 'package:flutter/material.dart';
import 'package:webzent/providers.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  const UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
 
  var apiData = [];
  bool loadingState = true;
  apicall() {
    Provider.of<Users>(context, listen: false).getUsers().then((value) {
      apiData = value;
      setState(() {
        loadingState = false;
      });
      print(value);
    });
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      
        appBar: AppBar(
        ),
        backgroundColor: Colors.white,
        body: loadingState
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: apiData.length,
                      itemBuilder: (_, i) => GestureDetector(
                            onTap: () {},
                            child: GestureDetector(
                             
                              child: Container(
                                child: Card(
                                  color: Colors.white,
                                  elevation: 1,
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Container(
                                    width: mq.size.width * 0.6,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: <Widget>[
                                        Text(apiData[i]['userId'].toString()),
                                        Text(apiData[i]['id'].toString()),
                                        Text(apiData[i]['title']),
                                        Text(apiData[i]['body']),
                                      
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                ),
              ));
  }
}
