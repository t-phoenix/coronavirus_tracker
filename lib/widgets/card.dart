import 'package:flutter/material.dart';

class DataCard extends StatefulWidget {
  final String title;
  final int data;
  DataCard({@required this.title, @required this.data});


  @override
  _DataCardState createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.center,
      height: 100,
      width: 330,
      decoration: BoxDecoration(
        color:Color(0xff3b6978),
          //border: Border.all(color: Color(0xff84a9ac), width: 2,  ),
          borderRadius: BorderRadius.circular(25),
          /*gradient: LinearGradient(
            colors: [
              Color(0xff84a9ac),

            ]
          )*/
    ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            height: 70,
            width: 70,
            child: IconButton(
              onPressed: (){},
              icon: widget.title=="Total Positive Cases" ? Icon(Icons.people) :
              widget.title=="Cases Added Today" ? Icon(Icons.add):
              widget.title=="Total Active Cases" ? Icon(Icons.alarm) :
              widget.title=="Total Covid19 Deaths" ? Icon(Icons.people_outline):
              widget.title=="Press Bottom Right Button" ? Icon(Icons.trending_down):
              Icon(Icons.add_circle_outline),

            ),
          ),

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.title, style: TextStyle(color: Colors.black, fontSize:16 , fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                Text(widget.data.toString(), style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
