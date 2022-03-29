import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app6/models/categories_model.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appCubit()..getCategoriesData(),
      child: BlocConsumer<appCubit, appStates>(
        listener: (context, state) {},
        builder: (context, state) {
          appCubit cubit = appCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.categoriesModel != null,
            fallback: (context) => Center(child: CircularProgressIndicator()),
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: cubit.categoriesModel!.data.data.length,
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.grey[300],
              ),
              itemBuilder: (context, index) => CatItem(cubit.categoriesModel!.data.data[index]),
            ),
          );
        },
      ),
    );
  }
}

Widget CatItem(DataModelCat model) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  child: InkWell(
    onTap: (){},
    borderRadius: BorderRadius.circular(15),
    child: Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage('${model.image}'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios_rounded,
        ),
      ],
    ),
  ),
);
