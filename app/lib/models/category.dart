class Category {
  String categoryName;

  Category({required this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryName: json['categoryName'],
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
      };
}
