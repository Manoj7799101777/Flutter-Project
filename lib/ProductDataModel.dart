class ProductDataModel {
  String? name;
  int? id;
  String? atype;
  String? imageURL;
  String? oldPrice;
  String? price;

  ProductDataModel(
      {this.name,
      this.id,
      this.atype,
      this.imageURL,
      this.oldPrice,
      this.price});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    atype = json['atype'];
    imageURL = json['imageUrl'];
    oldPrice = json['oldPrice'];
    price = json['price'];
  }
}
