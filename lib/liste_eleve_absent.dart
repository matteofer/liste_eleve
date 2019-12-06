import 'package:flutter/material.dart';

import 'liste_eleve.dart';

bool isLoaded = false;
List<Eleves> eleves = [];


var elevesAbsents = List<Eleves>();

class ListeAbsents extends StatelessWidget {

  String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Elèves absents'),
        titleSpacing: 10.0,
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => Home())
              );
            }
        ),
        centerTitle: false,
        elevation: 20.0,
        backgroundColor: Colors.blueGrey,
      ),
      body: new Center(
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot eleves){
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: elevesAbsents.length,
                itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(elevesAbsents[index].nom),
                    );
                },
              );
          },
        ),
      ),
    );
  }
}