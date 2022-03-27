import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/models/favorites_model.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appCubit()..getFavoritesData(),
      child: BlocConsumer<appCubit, appStates>(
        listener: (context, state) {},
        builder: (context, state) {
          appCubit cubit = appCubit.get(context);
          //Product? model = cubit.favoritesModel!.data.data[0].product;

          return ConditionalBuilder(
            condition: cubit.favoritesModel != null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) => ConditionalBuilder(
              condition: cubit.favoritesModel!.data.data.isNotEmpty,
              fallback: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outlined,
                      size: 100,
                      color: Colors.black26,
                    ),
                    Text(
                      'Empty, add some Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
              builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: cubit.favoritesModel!.data.data.length,
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
                itemBuilder: (context, index) => FavoriteItem(cubit.listFav[index].product,cubit,index),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget FavoriteItem(Product? model,appCubit cubit,int index) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage('${model!.image}'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            model.discount == 0 ? Text('') : Container(
              color: Colors.red,
              padding: EdgeInsets.all(5),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '£ ${model.price}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  model.discount == 0 ? Text('') : Text(
                    '${model.oldprice}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        cubit.postFavoriteProduct(IdProduct: model.id,fromFav: true,index: index);
                      });
                    },
                    color: Colors.red,
                    icon: Icon(Icons.favorite_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

