part of 'shops_cubit.dart';

@immutable
sealed class ShopsState {}

final class ShopsInitialState extends ShopsState {}

final class ShopBottomNavbar extends ShopsState {}

final class ShopLoadingProductsState extends ShopsState {}

final class ShopSuccessProductsState extends ShopsState {}

final class ShopErrorProductsState extends ShopsState {}

final class ShopSuccessCategoryState extends ShopsState {}

final class ShopErrorCategoryState extends ShopsState {}

final class ShopChangeFavState extends ShopsState {}

final class ShopSuccessChangeFavouriteState extends ShopsState {
  final ChangeFav change;

  ShopSuccessChangeFavouriteState({required this.change});
}

final class ShopErrorChangeFavouriteState extends ShopsState {}

final class ShopLoadingGetFavouriteState extends ShopsState {}

final class ShopSucessGetFavouriteState extends ShopsState {}

final class ShopErrorGetFavouriteState extends ShopsState {}

final class ShopLoadingUsersState extends ShopsState {}

final class ShopSucessUsersState extends ShopsState {
  final ShopLoginModel loginModel;

  ShopSucessUsersState({required this.loginModel});
}

final class ShopErrorUsersState extends ShopsState {}

final class ShopLoadingUpdateState extends ShopsState {}

final class ShopSucessUpdateState extends ShopsState {
  final ShopLoginModel loginModel;

  ShopSucessUpdateState({required this.loginModel});
}

final class ShopErrorUpdateState extends ShopsState {}