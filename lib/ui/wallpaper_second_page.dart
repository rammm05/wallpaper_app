import 'package:flutter/material.dart';
import 'package:wallpaper_app/ui/wallpaper_home_page.dart';

import '../app_routes.dart';

class WallpaperSecondPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    String category = ModalRoute.of(context)!.settings.arguments!.toString();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffDBEAF1),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: WallpaperHomePage.getWallpapers(query: category),
              builder: (context, snap) {

                if(snap.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }

                if(snap.hasError){
                  return Center(child: Text(snap.error.toString()));
                }

                if(snap.hasData){
                  return snap.data != null && snap.data!.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$category", style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                      ),),


                      Text("${snap.data!.length} wallpaper available", style: TextStyle(
                        fontSize: 20,
                        //fontWeight: FontWeight.bold
                      ),),

                      GridView.extent(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 11,
                          mainAxisSpacing: 11,
                          childAspectRatio: 2/3,


                          children: List.generate(snap.data!.length, (index){
                            //print(category);


                            return InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, AppRoutes.route_apply_page,
                                    arguments: snap.data![index].src.portrait);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(snap.data![index].src.portrait), fit: BoxFit.cover)
                                ),
                              ),
                            );
                          })
                      ),

                    ],
                  )
                      : Center(child: Text("No wallpaper found"));
                }

                return Container();
              }
            ),
          ),
        ),
      ),
    );
  }
}
