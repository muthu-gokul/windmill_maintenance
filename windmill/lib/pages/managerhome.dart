import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:windmill/pages/customCard.dart';

import '../main.dart';

class managerhome  extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _managerhome();
  }
}
class Userr {
  final String date;
  final String site;

  const Userr(
      {
        this.date,
        this.site
      }
      );
}
class _managerhome extends State<managerhome> {
  String _date = "Select a date";
  String site;
  final formKey = new GlobalKey<FormState>();
  final List<String> sitelist = ['chennai', 'vellore', 'bangalore', 'madurai'];

  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Page'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return new MyApp();
                }));
          },)),
      body: Center(
        //child: Form(
        //  key: formKey,
          child: SingleChildScrollView(
            child: new Container(
              padding: const EdgeInsets.all(30.0),
              color: Colors.green[100],
              child: Column(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(
                        top: 60.0, left: 20.0, right: 20.0)),


                    DropdownButton<String>(
                        hint: Text("Select Windmill Site"),
                        value: site,
                        items: sitelist.map((sitee) {
                          return DropdownMenuItem(
                            value: sitee,
                            child: Text('$sitee'),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => site = val)
                    ),
                    SizedBox(height: 15.0,),

                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            showTitleActions: true,
                            minTime: DateTime(2000, 1, 1),
                            maxTime: DateTime(2030, 12, 31),
                            onConfirm: (date) {
                              print('confirm $date');
                              _date =
                              '${date.year} - ${date.month} - ${date.day}';
                              setState(() {});
                            },
                            currentTime: DateTime.now(),
                            locale: LocaleType.en);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Colors.teal,
                                      ),
                                      Text(
                                        " $_date",
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "  Change",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                    SizedBox(height: 20.0,),

                    RaisedButton(
                      elevation: 10.0,
                      child: Text("Search"),
                      textColor: Colors.white,
                      color: Colors.pink,

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SeecondScreen( value:Userr(
                                      site: site, date: _date)),
                            ));
                      },
                    )
                  ]
              ),
            ),
          )
      ),
      //  ),
    );
  }
}







class SeecondScreen  extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SeecondScreen();
  }
  final Userr value ;
  SeecondScreen({Key key, this.value}) : super(key: key);
}
class _SeecondScreen extends State<SeecondScreen> {
  String rno;
  String site;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: Text("Results"),
          centerTitle: true,
          leading: new IconButton(icon: new Icon(Icons.arrow_back),onPressed: (){Navigator.push(context,
              MaterialPageRoute(builder: (context)
              {
                return new MyApp();
              }));},),
        ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream:Firestore.instance
                  .collection('maintenance')
                  .document(widget.value.site).collection(widget.value.date)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(

                          windmillid: document['Windmillid'],
                          site: document['WindmillSite'],
                          date: document['Date'],
                          component: document['Component'],
                          url1: document['Imagebefore'],
                          url2: document['Imageafter'],

                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),);
  }
}
