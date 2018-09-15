import 'package:flutter/material.dart';
import 'package:todo_list/list.dart';
import 'package:todo_list/item.dart';

class AllLists extends StatefulWidget{
  @override
  _AllListsState createState() => _AllListsState();
}

class _AllListsState extends State<AllLists>{

  List currList = new List(listName:"Default",);
  var lists = <List>[];
  
  var listNames = <DropdownMenuItem>[];
  var names = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lists.add(currList);
    listNames.add(DropdownMenuItem(value:"Default",child:Text("Default")));
    names.add("Default");
  }


  String _selectedType = "Default";


  @override
  Widget build(BuildContext context) {

    return
      Column(
        children: <Widget>[
          Expanded(
            child: currList,
          )
          ,
          DropdownButton(hint: Text(_selectedType), items: listNames, onChanged: (val){
            int index = names.indexOf(val);
            setState(() {
              _selectedType = val;
              currList = lists[index];
            });
          },)
          ,
          FlatButton(
            child: const Text('ADD LISTS'),
            onPressed: (){_showDialog();},
          )
        ],
      );
  }

  void add(String listname){
    listNames.add(DropdownMenuItem(value:listname,child:Text(listname)));
    currList = new List(listName: listname,);
    lists.add(currList);
    names.add(listname);
  }
  String textnew2 = "";

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                onChanged: (String text){
                  textnew2 = text;
                },
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'List Name', hintText: 'eg. Shopping List'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('ADD'),
              onPressed: () {

                  if(textnew2.isNotEmpty){
                    setState(() {
                      add(textnew2);
                      _selectedType = textnew2;
                    });

                    Navigator.pop(context);}

              })
        ],
      ),
    );
  }

}