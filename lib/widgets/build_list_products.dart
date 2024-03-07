import 'package:flutter/material.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/models/favourite.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/styles/colors.dart';

class BuildListProducts extends StatelessWidget {
  BuildListProducts({
    super.key,
    required this.favoritee,
  });
  final Product favoritee;
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
                  image: NetworkImage(favoritee.image),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
                if (favoritee.discount != 0)
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
                    favoritee.name.toString(),
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14.0, height: 1.3),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        favoritee.price.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (favoritee.discount != 0)
                        Text(
                          favoritee.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopsCubit.get(context)
                                .changeFavourite(favoritee.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopsCubit.get(context).favorite[favoritee.id]!
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


class BuildListProductsToSearch extends StatelessWidget {
  BuildListProductsToSearch({
    super.key,
    required this.search,
  });
  final ProductSearch search;
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
                  image: NetworkImage(search.image),
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
                // if (search.discount != 0)
                //   Container(
                //     color: Colors.red,
                //     padding: const EdgeInsets.symmetric(horizontal: 5.0),
                //     child: const Text(
                //       'Discount',
                //       style: TextStyle(fontSize: 8.0, color: Colors.white),
                //     ),
                //   ),
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
                    search.name.toString(),
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14.0, height: 1.3),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        search.price.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      // if (search.discount != 0 && isOldPrice == true)
                      //   Text(
                      //     search.oldPrice.toString(),
                      //     style: const TextStyle(
                      //         fontSize: 10.0,
                      //         color: Colors.grey,
                      //         decoration: TextDecoration.lineThrough),
                      //   ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopsCubit.get(context)
                                .changeFavourite(search.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopsCubit.get(context).favorite[search.id]!
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
