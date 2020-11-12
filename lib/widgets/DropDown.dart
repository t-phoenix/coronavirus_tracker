import 'package:flutter/material.dart';


class DropDown extends StatefulWidget {

  final ValueChanged<String> onChanged;
  final List<String> title;
  DropDown({Key key, @required this.title, this.onChanged}): super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String _selectedItem;

  String getSelectedItem(){
    return _selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 80,
      width: 150,
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text("Select Country", style: TextStyle(color: Colors.white),),
          value: _selectedItem,
          //isDense: true,
          onChanged: (String newValue){
            setState(() {
              _selectedItem = newValue;
            });
            widget.onChanged(newValue);
          },
          dropdownColor: Color(0xff3b6978),

          items: widget.title.map((String user) {
            return new DropdownMenuItem<String>(
              value: user,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  alignment: Alignment.center,
                  child: new Text(
                    user,
                    style: TextStyle(color: Colors.white),
                  )
              ),
            );
          }).toList(),
        ),
      ),
    );


  }
}
