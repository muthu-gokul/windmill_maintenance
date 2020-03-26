import 'package:flutter/material.dart';
import 'package:windmill/pages/workers.dart';
import 'package:windmill/pages/manager.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Windmill',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0,),
            new RaisedButton(
              child: Text("Worker"),
               elevation: 5.0,
                 onPressed: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> LoginPage(title: 'worker')
                ));}

            ),
            SizedBox(height: 25.0,),

            new RaisedButton(
              child: Text("Manager"),

                 onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> LoginPage(title: 'manager',)
                  ));}
            ),


          ],
        ),
      ),
    );
  }
}
