class SearchModel {
  SearchModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  dynamic? message;
  Data? data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<SearchData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic? nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<SearchData>.from(json["data"].map((x) => SearchData.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toMap())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class SearchData {
  SearchData({
    this.id,
    this.price,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  int? id;
  double? price;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    id: json["id"] == null ? null : json["id"],
    price: json["price"] == null ? null : json["price"].toDouble(),
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
    "image": image == null ? null : image,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "in_favorites": inFavorites == null ? null : inFavorites,
    "in_cart": inCart == null ? null : inCart,
  };
}
