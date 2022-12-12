class ChangeFavoriteModel {
  ChangeFavoriteModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ChangeFavoriteModel.fromJson(Map<String, dynamic> json) => ChangeFavoriteModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );
}
