import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isSelected;
 final ImageIcon ixcon;
  final Function onTap;
  final Function onPressed;
  final String x;
  const TabItem({Key key, this.x,this.ixcon,this.text, this.icon, this.isSelected, this.onTap,this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 6, 8, 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(icon, color: isSelected ? Colors.blue[800] : Colors.grey,size: 30,),
            Text(text, style: TextStyle(
                color: isSelected ? Colors.blue[800] : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13
            ),)
          ],
        ),
      ),
     //onTap: onTap,
      onPressed:onPressed ,
    );
  }
}
