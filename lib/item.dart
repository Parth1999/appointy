///This is a single to-do list item

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

final _rowHeight = 60.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 4);

class Item extends StatefulWidget {
  //Name of the item in a list, cannot be changed
  final String name;

  //Whether that item is completed or not, can change completed state
  bool complete = false;

  bool showDeleteButton = false;

  final Function(Item item, bool status, bool delete) notifyParent;
  Item({@required Key key, @required this.name, @required this.notifyParent}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: () {
            setState(() {
              widget.showDeleteButton = !widget.showDeleteButton;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  //Initial Value is false
                  value: widget.complete,
                  onChanged: (bool newStatus) {
                    setState(() {
                      widget.complete = newStatus;
                      widget.showDeleteButton = false;
                      widget.notifyParent(widget, newStatus, false);
                    });
                  },
                ),
                Expanded(
                  child: Text(widget.name,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        decoration: (widget.complete
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                      )),
                ),
                AnimatedOpacity(
                  opacity: (widget.showDeleteButton ? 1.0 : 0.0),
                  duration: Duration(milliseconds: 200),
                  child: (widget.showDeleteButton
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.redAccent,
                          tooltip: 'Delete',
                          onPressed: () {
                            widget.notifyParent(widget, !widget.complete, true);
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.redAccent,
                          splashColor: Colors.transparent, onPressed: () {},
                        )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
