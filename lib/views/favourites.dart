import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/models/favourite.dart';
import 'package:shopapp/styles/colors.dart';

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
            itemBuilder: (context, index) => BuildFavItem(
                favoritee:
                    ShopsCubit.get(context).favoritemodel!.data.items[index]),
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

class BuildFavItem extends StatelessWidget {
  const BuildFavItem({
    super.key,
    required this.favoritee,
  });
  final ProductItem favoritee;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(favoritee.product.image),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
                if (1 != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'Discount',
                      style: TextStyle(fontSize: 8.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favoritee.product.name.toString(),
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14.0, height: 1.3),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        favoritee.product.price.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (favoritee.product.discount != 0)
                        Text(
                          favoritee.product.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopsCubit.get(context)
                                .changeFavourite(favoritee.product.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopsCubit.get(context)
                                    .favorite[favoritee.product.id]!
                                ? defaultColor
                                : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
