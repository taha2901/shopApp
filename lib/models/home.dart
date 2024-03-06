class HomeModel {
  final bool status;
  final HomeDataModel data;

  HomeModel({
    required this.status,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      status: json['status'] ?? false,
      data: HomeDataModel.fromJson(json['data']),
    );
  }
}

class HomeDataModel {
  final List<Banner> banners;
  final List<Product> products;

  HomeDataModel({
    required this.banners,
    required this.products,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> bannersList = json['banners'];
    List<dynamic> productsList = json['products'];

    return HomeDataModel(
      banners: bannersList.map((e) => Banner.fromJson(e)).toList(),
      products: productsList.map((e) => Product.fromJson(e)).toList(),
    );
  }
}

class Banner {
  final int id;
  final String image;

  Banner({
    required this.id,
    required this.image,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'] ?? 0,
      image: json['image'] ?? "",
    );
  }
}

class Product {
  final int id;
  final double price;
  final double oldPrice;
  final double discount;
  final String image;
  final String name;
  final bool inFavorites;
  final bool inCart;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavorites,
    required this.inCart,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
      oldPrice: json['old_price'] != null
          ? double.parse(json['old_price'].toString())
          : 0.0,
      discount: json['discount'] != null
          ? double.parse(json['discount'].toString())
          : 0.0,
      image: json['image'] ?? "",
      name: json['name'] ?? "",
      inFavorites: json['in_favorites'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }
}
