import 'package:flutter/material.dart';
import 'package:todo_list/item.dart';

class List extends StatefulWidget{

  String listName;
  int count = 0;

  var _itemsLeft = <Item>[];
  var _itemsDone = <Item>[];

  List({Key key, @required this.listName}) : super(key: key);

  @override
  ListState createState() => ListState();

}

class ListState extends State<List>{


  Widget _buildLeftItemsList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => widget._itemsLeft[index],
      itemCount: widget._itemsLeft.length,
    );
  }

  refreshData(Item item, bool status, bool delete){
    setState(() {
      if(status){
        if(!delete)
        widget._itemsDone.add(item);
        widget._itemsLeft.remove(item);

      }
      else{
        if(!delete)
        widget._itemsLeft.add(item);
        widget._itemsDone.remove(item);
      }

    });
  }

  void add(String name){
    widget._itemsLeft.add(new Item(key: ObjectKey(widget.count.toString()), name: name, notifyParent: refreshData,));
  }

  String textnew = "";

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
                  textnew = text;
                },
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Item Name', hintText: 'eg. Complete Homework'),
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
                setState(() {
                  if(textnew.isNotEmpty){
                    add(textnew);
                    Navigator.pop(context);
                  }

                });
              })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: _buildLeftItemsList(),
          fit: FlexFit.loose,
        )
        ,
      ExpansionTile(
              key: PageStorageKey("hello"),
              title: Text("Completed"),
              children: widget._itemsDone,
        )
        ,

        IconButton(
          icon: Icon(Icons.add), onPressed: () {
            _showDialog();
        },
        )
      ],
    );
  }

}