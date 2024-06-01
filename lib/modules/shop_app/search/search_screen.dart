import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';


import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopSearchCubits(),
      child: BlocConsumer<ShopSearchCubits, ShopSearchStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var cubit =ShopSearchCubits.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'search',
                      onSubmitted: (text){
                        cubit.search(text,context);
                      },
                      prefix: Icons.search,
                      validate: (value){
                          if(value.isEmpty){
                            return 'enter text to search';
                          }
                          return null;
                        }
                    ),
                    if(state is ShopSearchLoadingStates)const LinearProgressIndicator(),
                    const SizedBox(height:20),
                    if(state is ShopSearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildFavItem(
                              cubit.searchModel!.data!.data![index], context,isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: cubit.searchModel!.data!.data!.length),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildFavItem( model, context,{bool isOldPrice=true}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      height: 120,
      child: Row(children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,
            ),
            if (model.discount != 0 && isOldPrice)
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
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: HexColor('3d8069'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.oldprice.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopSearchCubits.get(context)
                            .changeFavourite(model.id,context);
                        print(model.id);
                        print(ShopCubits.get(context)
                            .favorites);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubits.get(context).favorites[model.id]!
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
