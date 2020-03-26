import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:windmill/main.dart';
import 'package:windmill/pages/manager.dart';
import 'package:windmill/pages/signin.dart';


class workerhome  extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _workerhome();
  }
}

class _workerhome extends State<workerhome> {
  String  site;
  String component;
  String windmillid;
  String _date = "Select a date";
  File sampleImage;
  File sampleImage2;
  String url1;
  String url2;

  final dbref = FirebaseDatabase.instance.reference();
  final formKey=new GlobalKey<FormState>();
  final List<String> sitelist=['chennai','vellore','bangalore','madurai'];
  final List<String> componentlist=['blade','rotor','shaft'];


  Future getImage() async
  {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }
  Future getImagee() async
  {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage2 = tempImage;
    });
  }
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }
  }
  void uploadfeedback() async {
    if (validateAndSave()) {
      final StorageReference postImageRef = FirebaseStorage.instance.ref()
          .child("Imagesguardian");
      var timekey = new DateTime.now();
      final StorageUploadTask uploadTask = postImageRef.child(
          timekey.toString() + ".jpg").putFile(sampleImage);
      var ImageUrl1 = await(await uploadTask.onComplete).ref.getDownloadURL();
      url1 = ImageUrl1.toString();
      final StorageReference postImageRef2 = FirebaseStorage.instance.ref()
          .child("Imagesguardian2");
      final StorageUploadTask uploadTask2 = postImageRef2.child(
          timekey.toString() + ".jpg").putFile(sampleImage2);
      var ImageUrl2 = await(await uploadTask2.onComplete).ref.getDownloadURL();
      url2 = ImageUrl2.toString();
      Firestore.instance
          .collection('maintenance')
          .document(site).collection(_date).add({
        "Windmillid": windmillid,
        "WindmillSite": site,
        "Date": _date,
        "Component": component,
        "Imagebefore": url1,
        "Imageafter": url2
      }).then((result) =>
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return new mh();
              })));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Worker"),
          centerTitle: true,
          leading: new IconButton(icon: new Icon(Icons.arrow_back),onPressed: (){
            signOutGoogle();
            Navigator.push(context,
              MaterialPageRoute(builder: (context)
              {
                return new MyApp();
              }));},)
      ),

      body: Center(
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: new Container(
                padding: const EdgeInsets.all(30.0),
                color: Colors.green[100],
                child: Column(
                    children: <Widget>[
                      new Padding(padding: EdgeInsets.only(
                          top: 60.0, left: 20.0, right: 20.0)),

                      TextFormField(
                        textAlign: TextAlign.center,
                        // decoration: new InputDecoration(labelText: 'Name',contentPadding: const EdgeInsets.all(30.0)),
                        decoration: new InputDecoration(
                          fillColor: Colors.yellow[200],
                          filled: true,
                          labelText: 'Windmill Id',
                          contentPadding: EdgeInsets.fromLTRB(
                              12.0, 12.0, 12.0, 12.0),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(40.0),
                            borderSide: BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(40.0),
                            borderSide: BorderSide(
                                color: Colors.pink, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          return value.isEmpty ? 'Windmill id is required' : null;
                        },
                        onSaved: (value) {
                               return windmillid = value;
                           }
                      ),
                      SizedBox(height: 15.0,),


                      DropdownButton<String>(
                          hint: Text("Select Windmill Site"),
                          value: site ,
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
                              maxTime: DateTime(2030, 12, 31), onConfirm: (date) {
                                print('confirm $date');
                                _date = '${date.year} - ${date.month} - ${date.day}';
                                setState(() {});
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
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

                      DropdownButton<String>(
                          hint: Text("Select Component"),
                          value: component,
                          items: componentlist.map((components) {
                            return DropdownMenuItem(
                              value: components,
                              child: Text('$components'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => component = val)
                      ),

                      SizedBox(height: 15.0,),






                      TextField(
                        textAlign: TextAlign.center,
                        // decoration: new InputDecoration(labelText: 'Name',contentPadding: const EdgeInsets.all(30.0)),
                        decoration: new InputDecoration(
                            fillColor: Colors.yellow[200],
                            //filled: true,
                            labelText: 'Upload before maintenance',
                            contentPadding: EdgeInsets.fromLTRB(
                                12.0, 12.0, 12.0, 12.0),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                  color: Colors.pink, width: 2.0),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.add_a_photo),
                                onPressed: () {
                                  getImage();
                                }
                            )

                        ),
                      //  validator: (value) {
                       //   return value.isEmpty ? 'Name is required' : null;
                        //},
                        //onSaved: (value) {
                        //  return userg1 = value;
                        //},
                      ),
                      SizedBox(height: 5.0,),

                      Image.file(sampleImage, height: 300.0, width: 150.0,),

                      SizedBox(height: 15.0,),

                      TextField(
                        textAlign: TextAlign.center,
                        // decoration: new InputDecoration(labelText: 'Name',contentPadding: const EdgeInsets.all(30.0)),
                        decoration: new InputDecoration(
                            fillColor: Colors.lime[50],
                            //filled: true,
                            labelText: 'Upload after maintenance',
                            contentPadding: EdgeInsets.fromLTRB(
                                12.0, 12.0, 12.0, 12.0),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                              borderSide: BorderSide(
                                  color: Colors.pink, width: 2.0),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.add_a_photo),
                                onPressed: () {
                                  getImagee();
                                }
                            )
                        ),
                      //  validator: (value) {
                        //  return value.isEmpty ? 'Name is required' : null;
                        //},
                       // onSaved: (value) {
                         // return userg2 = value;
                       // },
                      ),
                      SizedBox(height: 5.0,),
                      Image.file(sampleImage2, height: 300.0, width: 150.0,),

                      SizedBox(height: 15.0,),
                      RaisedButton(
                        elevation: 10.0,
                        child: Text("Upload"),
                        textColor: Colors.white,
                        color: Colors.pink,

                        onPressed:
                          uploadfeedback,


                      )
                    ]
                ),
              ),
            )
        ),
      ),
    );
    //);
  }

}