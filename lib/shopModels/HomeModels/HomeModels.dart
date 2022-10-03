class HomeModel{
  bool status;
  HomeDataModel data;
HomeModel.fromJson(Map<String, dynamic> json)
{
  status=json['status'];
  data=HomeDataModel.fromJson(json['data']);
}
}
class HomeDataModel
{
  List<BannerModel> banners=[];
  List<productsModel> products=[];
  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element){
      banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((element){
      products.add(productsModel.fromjson(element));
    });
  }
}
class BannerModel{
 int id;
 String image;
  BannerModel.fromjson(Map<String,dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}
class productsModel{

  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;
  productsModel.fromjson(Map<String,dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
  }
}