import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/wallpaper_model.dart';

import '../app_constants.dart';
import '../app_routes.dart';
import 'package:http/http.dart' as http;


class WallpaperHomePage extends StatelessWidget{

  Future<List<PhotosModel>> getBestOfTheDay() async {

    String url = "https://api.pexels.com/v1/curated";

    http.Response res = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization" : "8hfgKxEMkZ05rZzWsYdsdKcOGPnpqFJZrDyapMUaOPFCKXG1WM1E3qNh"
        });

    if(res.statusCode == 200){
      dynamic data = jsonDecode(res.body);
      DataModel dataModel = DataModel.fromJson(data);
      return dataModel.photos;
    } else {
      return [];
    }



  }

  static Future<List<PhotosModel>> getWallpapers({required String query}) async {
    String url = "https://api.pexels.com/v1/search?query=$query";
    http.Response res = await http.get(Uri.parse(url), headers: {
      "Authorization" : "8hfgKxEMkZ05rZzWsYdsdKcOGPnpqFJZrDyapMUaOPFCKXG1WM1E3qNh"
    });

    if(res.statusCode == 200){
      dynamic data = jsonDecode(res.body);
      DataModel dataModel = DataModel.fromJson(data);
      return dataModel.photos;
    } else {
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 50, left: 25, right: 25 , bottom: 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
                colors: [
              Color(0xffDBEAF1),
              Colors.white
            ])
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                findWall(),
                SizedBox(height: 20,),
                bestOfDayTxt(),
                SizedBox(height: 10,),
                listBestOfDay(context),
                SizedBox(height: 20,),
                colorToneTxt(),
                SizedBox(height: 10,),
                listColorTone(context),
                SizedBox(height: 20,),
                categoriesTxt(),
                SizedBox(height: 10,),
                gridCategories(context),
              ],
            ),
          ),
        ),
      )
    );
  }

  ///...textfield find wallpapers part1
  Widget findWall(){
    return TextField(
      /*maxLines: 1,
      minLines: 1,
      expands: true,*/
      style: TextStyle(
          fontSize: 20
      ),
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.all(8),
          hint: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Find wallpaper...",style: TextStyle(
                color: Colors.grey,
                fontSize: 20
            ),),
          ),
          suffixIcon: Icon(Icons.search_outlined, color: Colors.grey, size: 35,),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none
          )
      ),
    );
  }
  ///...bestOfMonthTxt part2
  Widget bestOfDayTxt(){
    return Text("Best of the day" , style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
    ),);
  }

  ///...listBestOfMonth part3
  Widget listBestOfDay(BuildContext context){
    return Container(
      width: double.infinity,
      height: 250,
      child: FutureBuilder(
          future: getBestOfTheDay(), builder: (context, snap){

            if(snap.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            if(snap.hasError){
              return Center(child: Text(snap.error.toString()),);
            }

            if (snap.hasData) {
              return snap.data != null && snap.data!.isNotEmpty ?
              ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: snap.data!.length,
                  itemBuilder: (context, index){

                    PhotosModel currWallpaper = snap.data![index];

                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.route_apply_page, arguments: currWallpaper.src.portrait);
                          },
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                image: DecorationImage(
                                    image: NetworkImage(currWallpaper.src.portrait),
                                    fit: BoxFit.cover)
                            ),
                          ),
                        ),
                        SizedBox(width: 10,)
                      ],
                    );
                  })
                  :
              Center(child: Text("No wallpapers found"));
            }

            return Container();

      }),
    );
  }

  ///...colorToneTxt part4
  Widget colorToneTxt(){
    return Text("The color tone" , style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
    ),);
  }

  ///...ListColorTone part5
  Widget listColorTone(BuildContext context){
    return Container(
      width: double.infinity,
      height: 50,
      //color: Colors.red,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AppConstants.colorList.map((element){
          return Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, AppRoutes.route_second_page, arguments: element.keys.first);
                },
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      color: element.values.first,
                      borderRadius: BorderRadius.circular(11)
                  ),
                ),
              ),
              SizedBox(width: 10,)
            ],
          );

        }
        ).toList(),

      ),
    );
  }

  ///...categoriesTxt part6
  Widget categoriesTxt(){
    return Text("Categories" , style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold
    ),);
  }

  ///...GridCategories part7
  Widget gridCategories(BuildContext context){


    return GridView.extent(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        maxCrossAxisExtent: 200,
        crossAxisSpacing: 11,
        mainAxisSpacing: 11,
        childAspectRatio: 16/9,


        children: List.generate(AppConstants.category.length, (index){

          return FutureBuilder(
            future: getWallpapers(query: AppConstants.category[index]),
            builder: (context, snap) {

              if(snap.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }

              if(snap.hasError){
                return Center(child: Text(snap.error.toString()));
              }

              if(snap.hasData){
                return snap.data != null && snap.data!.isNotEmpty ? InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.route_second_page, arguments: AppConstants.category[index]);
                  },
                  child: Container(
                    width: 100,
                    height: 2,

                    decoration: BoxDecoration(
                      //color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(snap.data![0].src.landscape), fit: BoxFit.cover)

                    ),
                    child: Center(child: Text(AppConstants.category[index], style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),)),
                  ),
                ) : Text("No wallpapers Found");
                }


              return Container();

            }
          );
        })
    );
  }


}