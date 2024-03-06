import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/models/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding:const EdgeInsets.symmetric(vertical: 10),
            child: BuildCatItem(
                category:
                    ShopsCubit.get(context).category!.data.categories[index]),
          ),
          itemCount:  ShopsCubit.get(context).category!.data.categories.length,
        );
      },
    );
  }
}

class BuildCatItem extends StatelessWidget {
  const BuildCatItem({
    super.key,
    required this.category,
  });
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(category.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            category.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
