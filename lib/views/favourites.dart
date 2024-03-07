import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/widgets/build_list_products.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouriteState,
          builder: (context) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildListProducts(
                favoritee:
                    ShopsCubit.get(context).favoritemodel!.data.items[index].product),
            itemCount: ShopsCubit.get(context).favoritemodel!.data.items.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
