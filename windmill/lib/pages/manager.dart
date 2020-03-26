import 'package:flutter/material.dart';
import 'package:windmill/main.dart';
import 'package:windmill/pages/signin.dart';



class mh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Alert Page"
          ),

          leading: new IconButton(icon: new Icon(Icons.arrow_back),onPressed: (){
            signOutGoogle();
            Navigator.push(context,
                MaterialPageRoute(builder: (context)
                {
                  return new MyApp();
                }));},)
      ),
      body: Center(
        child: Text(
          "Uploaded Successfully",
          style: TextStyle(fontSize: 36),
        ),
      ),
    );
  }
}
