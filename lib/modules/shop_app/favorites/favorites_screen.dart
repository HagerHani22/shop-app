import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/states.dart';
import '../../../shared/components/components.dart';

import '../../../models/favourites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubits, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubits cubit = ShopCubits.get(context);
        return state is! ShopLoadingFavouritesState
            ? ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    cubit.favouritesModel!.data!.data![index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favouritesModel!.data!.data!.length)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget buildFavItem(FavData model, context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      height: 120,
      child: Row(children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.product!.image!),
              width: 120,
              height: 120,
            ),
            if (model.product!.discount! != 0)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.product!.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.product!.price!.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: HexColor('3d8069'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.product!.discount! != 0)
                    Text(
                      model.product!.oldprice!.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopCubits.get(context)
                            .changeFavourite(model.product!.id!);
                        print(model.product!.id!);
                        print(ShopCubits.get(context)
                            .favorites);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubits.get(context)
                                .favorites[model.product!.id]!
                            ? HexColor('3d8069')
                            : Colors.grey[400],
                        child: const Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ]),
    ),
  );
}
