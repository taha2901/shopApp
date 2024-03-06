import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/Network/end_points.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/components/show_toast.dart';
import 'package:shopapp/components/sign_out.dart';
import 'package:shopapp/helper/api.dart';
import 'package:shopapp/models/category.dart';
import 'package:shopapp/models/change_fav.dart';
import 'package:shopapp/models/favourite.dart';
import 'package:shopapp/models/home.dart';
import 'package:shopapp/models/shop_login.dart';
import 'package:shopapp/views/categories.dart';
import 'package:shopapp/views/favourites.dart';
import 'package:shopapp/views/products.dart';
import 'package:shopapp/views/settings.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  ShopsCubit() : super(ShopsInitialState());

  static ShopsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopBottomNavbar());
  }

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.apps),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  HomeModel? homeModel;
  Map<int, bool> favorite = {};
  void getHomeData() {
    emit(ShopLoadingProductsState());
    DioHelper().getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favorite.addAll({
          element.id: element.inFavorites,
        });
      });
      // print(favorite.toString());
      // printFullText(homeModel.toString());
      emit(ShopSuccessProductsState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorProductsState());
    });
  }

  CategoryModel? category;

  void getCategoryData() {
    DioHelper().getData(url: GET_CATEGORIES, token: token).then((value) {
      category = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorCategoryState());
    });
  }

  ChangeFav? change;
  void changeFavourite(int productyId) {
    favorite[productyId] = !favorite[productyId]!;
    emit(ShopChangeFavState());
    DioHelper()
        .postData(
      url: FAVOURITES,
      data: {
        'product_id': productyId,
      },
      token: token,
    )
        .then((value) {
      change = ChangeFav.fromJson(value.data);

      // print(value.data);
      if (!change!.status) {
        favorite[productyId] = !favorite[productyId]!;
      } else {
        getFavouriteData();
      }
      emit(ShopSuccessChangeFavouriteState(change: change!));
    }).catchError((onError) {
      favorite[productyId] = !favorite[productyId]!;
      emit(ShopErrorChangeFavouriteState());
    });
  }

  FavouriteModel? favoritemodel;

  void getFavouriteData() {
    emit(ShopLoadingGetFavouriteState());
    DioHelper()
        .getData(
      url: FAVOURITES,
      token: token, // عشان اجيب المنتجات المفضله بتاعتي انا
    )
        .then((value) {
      favoritemodel = FavouriteModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSucessGetFavouriteState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorGetFavouriteState());
    });
  }

  ShopLoginModel? usersModel;

  void getUsersData() {
    DioHelper().getData(url: PROFILE, token: token).then((value) {
      usersModel = ShopLoginModel.fromjson(value.data);
      printFullText(
          'this is data data data data data ======>>>>>>> ${usersModel!.data!.name}');
      emit(ShopSucessUsersState(loginModel: usersModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUsersState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopSucessUpdateState(loginModel: usersModel!));
    DioHelper().putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      usersModel = ShopLoginModel.fromjson(value.data);
      printFullText(
          'this is data data data data data ======>>>>>>> ${usersModel!.data!.name}');
      emit(ShopSucessUsersState(loginModel: usersModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorUsersState());
    });
  }
}
