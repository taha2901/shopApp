class CategoryModel {
  final bool status;
  final CategoryData data;

  CategoryModel({
    required this.status,
    required this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json['status'] ?? false,
      data: CategoryData.fromJson(json['data']),
    );
  }
}

class CategoryData {
  final int currentPage;
  final List<Category> categories;

  CategoryData({
    required this.currentPage,
    required this.categories,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    List<dynamic> categoriesList = json['data'];
    return CategoryData(
      currentPage: json['current_page'] ?? 0,
      categories: categoriesList.map((e) => Category.fromJson(e)).toList(),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'] ?? "",
    );
  }
}
