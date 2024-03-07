class SearchModel {
  final bool status;
  final dynamic message;
  final ProductData data;

  SearchModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'] ?? false,
      message: json['message'],
      data: ProductData.fromJson(json['data']),
    );
  }
}

class ProductData {
  final dynamic currentPage;
  final List<ProductSearch> products;

  ProductData({
    required this.currentPage,
    required this.products,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      currentPage: json['current_page'] ?? 0,
      products: (json['data'] as List<dynamic>)
          .map((e) => ProductSearch.fromJson(e))
          .toList(),
    );
  }
}

class ProductSearch {
  final dynamic id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final String description;
  final List<String> images;
  final bool inFavorites;
  final bool inCart;

  ProductSearch({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  factory ProductSearch.fromJson(Map<String, dynamic> json) {
    return ProductSearch(
      id: json['id'] ?? 0,
      price: json['price'] ?? 0,
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      inFavorites: json['in_favorites'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }
}
