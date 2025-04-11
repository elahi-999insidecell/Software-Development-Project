class CartModel {
  int? id;
  String? name;

  int? price;

  String? img;
  int? quantity;
  String? time;
  bool? isExist;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.time,
    this.quantity,
    this.isExist,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    price = json['price'];

    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExist = json['isexist'];
  }
}
