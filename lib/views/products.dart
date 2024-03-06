import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/models/category.dart';
import 'package:shopapp/models/home.dart';
import 'package:shopapp/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavouriteState) {
          if (!state.change.status) {
            showToast(
              text: state.change.message,
              color: ToastColors.ERROR,
            ); 
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopsCubit.get(context).homeModel != null &&
              ShopsCubit.get(context).category != null,
          builder: (context) => ProductBuilder(
            home: ShopsCubit.get(context).homeModel!,
            category: ShopsCubit.get(context).category!,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class ProductBuilder extends StatelessWidget {
  const ProductBuilder({
    required this.home,
    Key? key,
    required this.category,
  }) : super(key: key);

  final HomeModel home;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: home.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 100.0,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: BuildCategoryItem(
                            category: category.data.categories[index]),
                      );
                    },
                    itemCount: category.data.categories.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Products',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              children: List.generate(
                home.data.products.length,
                (index) =>
                    BuildGridProducts(product: home.data.products[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildCategoryItem extends StatelessWidget {
  const BuildCategoryItem({
    super.key,
    required this.category,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(category.image),
          height: 100.0,
          width: 100.0,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 100.0,
          child: Text(
            category.name,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class BuildGridProducts extends StatelessWidget {
  BuildGridProducts({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: double.infinity,
                height: 200.0,
              ),
              if (product.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 14.0, height: 1.3),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      '${product.price.round()}',
                      style:
                          const TextStyle(fontSize: 12.0, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (product.discount != 0)
                      Text(
                        '${product.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopsCubit.get(context).changeFavourite(product.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              ShopsCubit.get(context).favorite[product.id]!
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
    );
  }
}
