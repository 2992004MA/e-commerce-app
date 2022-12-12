class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  dynamic? message;
  Data? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status,
    "message": message,
    "data": data == null ? null : data!.toMap(),
  };
}

class Data {
  Data({
    this.banners,
    this.products,
    this.ad,
  });

  List<Banner>? banners;
  List<Product>? products;
  String? ad;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    banners: json["banners"] == null ? null : List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    ad: json["ad"] == null ? null : json["ad"],
  );

  Map<String, dynamic> toMap() => {
    "banners": banners == null ? null : List<dynamic>.from(banners!.map((x) => x.toMap())),
    "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toMap())),
    "ad": ad == null ? null : ad,
  };
}

class Banner {
  Banner({
    this.id,
    this.image,
    this.category,
    this.product,
  });

  int? id;
  String? image;
  dynamic? category;
  dynamic? product;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    category: json["category"],
    product: json["product"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "image": image == null ? null : image,
    "category": category,
    "product": product,
  };
}

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  int? id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] == null ? null : json["id"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    oldPrice: json["old_price"] == null ? null : json["old_price"].toDouble(),
    discount: json["discount"] == null ? null : json["discount"],
    image: json["image"] == null ? null : json["image"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    inFavorites: json["in_favorites"] == null ? null : json["in_favorites"],
    inCart: json["in_cart"] == null ? null : json["in_cart"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "price": price == null ? null : price,
    "old_price": oldPrice == null ? null : oldPrice,
    "discount": discount == null ? null : discount,
    "image": image == null ? null : image,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "in_favorites": inFavorites == null ? null : inFavorites,
    "in_cart": inCart == null ? null : inCart,
  };
}
