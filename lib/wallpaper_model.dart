class SrcModel {
  String landscape;
  String large;
  String large2x;
  String medium;
  String original;
  String portrait;
  String small;
  String tiny;

  SrcModel({
    required this.landscape,
    required this.large,
    required this.large2x,
    required this.medium,
    required this.original,
    required this.portrait,
    required this.small,
    required this.tiny,
  });

  ///from json
  factory SrcModel.fromJson(Map<String, dynamic> json){
    return SrcModel(
        landscape: json["landscape"],
        large: json["large"],
        large2x: json["large2x"],
        medium: json["medium"],
        original: json["original"],
        portrait: json["portrait"],
        small: json["small"],
        tiny: json["tiny"]
    );
  }
}

class PhotosModel {
  String alt;
  String avg_color;
  int height;
  int id;
  bool liked;
  String photographer;
  int photographer_id;
  String photographer_url;
  SrcModel src;
  String url;
  int width;

  PhotosModel({
    required this.alt,
    required this.avg_color,
    required this.height,
    required this.id,
    required this.liked,
    required this.photographer,
    required this.photographer_id,
    required this.photographer_url,
    required this.src,
    required this.url,
    required this.width,
  });

  ///from json
  factory PhotosModel.fromJson(Map<String, dynamic> json){
    return PhotosModel(
        alt: json["alt"],
        avg_color: json["avg_color"],
        height: json["height"],
        id: json["id"],
        liked: json["liked"],
        photographer: json["photographer"],
        photographer_id: json["photographer_id"],
        photographer_url: json["photographer_url"],
        src: SrcModel.fromJson(json["src"]),
        url: json["url"],
        width: json["width"]
    );
  }



}

class DataModel {
  String next_page;
  List<PhotosModel> photos;
  int total_results;

  DataModel({
    required this.next_page,
    required this.photos,
    required this.total_results,
  });

  //from json
  factory DataModel.fromJson(Map<String, dynamic> json){

    List<PhotosModel> mPhotos = [];
    for(Map<String, dynamic> eachPhoto in json["photos"]){
      mPhotos.add(PhotosModel.fromJson(eachPhoto));
    }

    return DataModel(
        next_page: json["next_page"],
        photos: mPhotos,
        total_results: json["total_results"]
    );
  }

}



