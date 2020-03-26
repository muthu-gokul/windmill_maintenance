import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
 // CustomCard({@required this.course, this.mark});
 // User _user=User();
 // final course;
 // final mark;
  CustomCard({@required this.windmillid, this.site,this.date,this.component,this.url1,this.url2});

  final windmillid;
  final site;
  final date;
  final component;
  final url1;
  final url2;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10.0,
        margin: EdgeInsets.all(15.0),
        color: Colors.teal[100],
        child: Container(
            padding: const EdgeInsets.only(top: 5.0),

            child: Column(
              children: <Widget>[
                new Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children:<Widget>[
                      new Text('windmill id: $windmillid'),
                  //    new Text(_user.displayName),
                      //SizedBox(width: 10.0,),
                      new Text('Location: $site')
                    ]
                ),
                SizedBox(height: 5.0,),
                new Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children:<Widget>[
                      new Text('Date: $date'),
                      //    new Text(_user.displayName),
                      //SizedBox(width: 10.0,),
                      new Text('Component: $component')
                    ]
                ),
                SizedBox(height: 5.0,),
                new Row(
                  children: <Widget>[
                    new Text("Image before Maintenance")
                  ],
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[

                      new Image.network(url1,height:150,fit: BoxFit.fill,),

                      SizedBox(height: 7.0,),                      //    new Text(_user.displayName),
                      //SizedBox(width: 10.0,),
                    ]
                ),
                SizedBox(height: 5.0,),
                new Row(
                  children: <Widget>[
                    Text("Image after Maintenance")
                  ],
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                      new Image.network(url2,height:150,fit: BoxFit.fill,),

                      SizedBox(height: 7.0,),                      //    new Text(_user.displayName),
                      //SizedBox(width: 10.0,),
                    ]
                ),

              ],
            )));
  }
}