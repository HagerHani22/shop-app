import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'categories_model.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubits,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubits cubit=ShopCubits.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemBuilder: (context, index) => buildCatItem(cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
              height: 2,
              color: Colors.grey[300],
              width: double.infinity,
            ),
            itemCount: cubit.categoriesModel!.data!.data.length,
          ),
        );
      },
    );
  }
}

Widget buildCatItem(DataModel model) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image!),
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            model.name!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios_outlined),
      ],
    ),
  );
}
