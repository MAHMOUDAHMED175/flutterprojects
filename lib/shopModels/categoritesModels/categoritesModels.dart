class CategoriesModels{

  bool status;
  CategoriesDataModels data;


  CategoriesModels.fromJson(Map<String,dynamic> json){

    status=json['status'];
    data=CategoriesDataModels.fromJson(json['data']);
  }
}
class CategoriesDataModels{
  int current_page;
  List<DataModel> data=[];
  CategoriesDataModels.fromJson(Map<String,dynamic> json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel{
  int id;
  String name;
  String image;
  DataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}