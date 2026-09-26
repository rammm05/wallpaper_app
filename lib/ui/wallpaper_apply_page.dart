import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';

class WallpaperApplyPage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    String selectedImg = ModalRoute.of(context)!.settings.arguments!.toString();



    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 40),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(selectedImg),fit: BoxFit.cover)
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: bottomBtns(),
        ),
      ),
    );
  }

  ///...bottomBtns
  Widget bottomBtns(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(11)
              ),
              child: Icon(CupertinoIcons.italic, color: Colors.white,),
            ),
            SizedBox(height: 5,),
            Text("Info", style: TextStyle(
                color: Colors.white
            ),)
          ],
        ),
        SizedBox(width: 30,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(11)
              ),
              child: Icon(Icons.save_alt, color: Colors.white,),
            ),
            SizedBox(height: 5,),
            Text("Save", style: TextStyle(
                color: Colors.white
            ),)
          ],
        ),
        SizedBox(width: 30,),
        Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(11)
              ),
              child: Icon(Icons.brush, color: Colors.white,),
            ),
            SizedBox(height: 5,),
            Text("Apply", style: TextStyle(
                color: Colors.white
            ),)
          ],
        )
      ],
    );
  }

}
