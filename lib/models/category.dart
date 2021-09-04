class Category {
  int? categoryID;
  String? categoryName;
  String? categoryDesc;
  int? parent;
  Image? image;

  Category({
    this.categoryID,
    this.categoryDesc,
    this.categoryName,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    categoryDesc = json['categoryDesc'];
    parent = json['parent'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
}

class Image {
  String? url;

  Image({
    this.url,
  });

  Image.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}
