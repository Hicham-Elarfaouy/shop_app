
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/models/home_model.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {},
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);
        var x = cubit.homeModel?.data.products;

        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Container(
            color: Colors.white,
            child: Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      items: cubit.homeModel?.data.banners.map((e) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage('${e.image}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )).toList(),
                      options: CarouselOptions(
                        height: 150,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 3),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CATEGORIES',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 100,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.categoriesModel!.data.data.length,
                              separatorBuilder: (context, index) => SizedBox(width: 15,),
                              itemBuilder: (context, index) => Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Image(
                                    image: NetworkImage('${cubit.categoriesModel!.data.data[index].image}'),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Container(
                                    color: Colors.black45,
                                    padding: EdgeInsets.all(5),
                                    width: 100,
                                    child: Text(
                                      '${cubit.categoriesModel!.data.data[index].name}'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'NEW PRODUCTS',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            childAspectRatio: 1 / 1.2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            crossAxisCount: 2,
                            children: List.generate(20, (index) => ProductHome(x![index])),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget ProductHome(ProductModel model) => Column(
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 100,
          width: double.infinity,
          fit: BoxFit.fitHeight,
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
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(
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
                ),
              ),
              SizedBox(
                width: 10,
              ),
              model.discount == 0 ? Text('') : Text(
                '${model.oldprice}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.favorite_border_outlined),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);


