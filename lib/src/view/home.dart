import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Nicolas 1', votes: 5),
    Band(id: '2', name: 'Nicolas 2', votes: 3),
    Band(id: '3', name: 'Nicolas 3', votes: 2),
    Band(id: '4', name: 'Nicolas 4', votes: 6),
    Band(id: '5', name: 'Nicolas 5', votes: 7),
    Band(id: '6', name: 'Nicolas 6', votes: 2),
    Band(id: '7', name: 'Nicolas 7', votes: 4),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Band Name', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:  ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) { 
          return _bandTile(bands[index]);
        }
      ),
      floatingActionButton: FloatingActionButton (
        child: Icon( Icons.add),
        elevation: 1,
        onPressed: () {
          addNewBand();
        },
      ),
   );
  }

  Widget _bandTile(Band banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( DismissDirection direction) {
        print('direction: $direction');
       // todo: llamar el borrado en el backend

      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text( banda.name.substring(0,2)),
              backgroundColor: Colors.blue[100]
            ),
            title: Text(banda.name),
            trailing: Text('${ banda.votes }', style: TextStyle(fontSize: 20)),
            onTap: () {
              print(banda.name);
            },
          ),
    );
  }

  addNewBand() {

    final textControlller = new TextEditingController();
    
    if( Platform.isAndroid ){
      //Android
      return showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text('New band name'),
            content: TextField(
              controller: textControlller,

            ),
            actions: <Widget> [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                textColor: Colors.green,
                onPressed: () => addBandToList(textControlller.text)
             )
            ],
          );
        }
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return  CupertinoAlertDialog(
          title: Text('New Band Name'),
          content: CupertinoTextField(
            controller: textControlller,
          ),
          actions: <Widget> [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textControlller.text)
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context)
            )
          ],
        );
      }
    );
  }

  void addBandToList(String name ){
    if (name.length > 1){
      //Podemos agregar
      print(name);
      this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 1));
      setState(() {});
    }
    Navigator.pop(context);
  }

}