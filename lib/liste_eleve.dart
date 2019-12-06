import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'main.dart';

import 'liste_eleve_absent.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return new _Home();
  }
}


Future<List<Eleves>> _getUsers() async {
  if (isLoaded == false) {
    var data = await http.get("http://www.json-generator.com/api/json/get/bTwkchSMQy?indent=2");
    var jsonData = json.decode(data.body);
    for(var i in jsonData){
      Eleves eleve = Eleves(i["nom"], i["email"], false);
      eleves.add(eleve);
    }
    isLoaded = true;
  }
  return eleves;
}

class _Home extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: new AppBar(
        title: new Text('ELEVES EPSI B2G1'),
        titleSpacing: 10.0,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.list),
              onPressed: (){
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => ListeAbsents())
                );
              }
          )
        ],
        centerTitle: false,
        elevation: 20.0,
        backgroundColor: Colors.black26,
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: FutureBuilder(
                future: _getUsers(),
                builder: (BuildContext context, AsyncSnapshot eleve){
                  if(eleve.data == null){
                    return Container(
                        child: Center(
                            child: Text("Loading...")
                        )
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: eleve.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(eleve.data[index].nom),
                          subtitle: Text(eleve.data[index].email),
                          trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new IconButton(
                                  icon: Icon(eleve.data[index].absent ? Icons.clear : Icons.check,
                                      color: eleve.data[index].absent ? Colors.red : Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      if(eleve.data[index].absent == true) {
                                        eleve.data[index].absent = false;
                                        elevesAbsents.remove(eleve.data[index]);
                                      }
                                      else {
                                        eleve.data[index].absent = true;
                                        elevesAbsents.add(eleve.data[index]);
                                      }
                                    });
                                  },
                                ),
                              ]),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),


      ),
    );

  }

}



class Eleves {
  final String nom;
  final String email;
  bool absent;
  Eleves(this.nom, this.email, this.absent);
}
