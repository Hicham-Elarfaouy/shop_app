import 'package:flutter/material.dart';
import 'package:flutter_app6/modules/onboarding_screen.dart';
import 'package:flutter_app6/modules/search_screen.dart';
import 'package:flutter_app6/shared/components/elements.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_app6/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appCubit()..getProfileData()..getHomeData()..getCategoriesData(),
      child: BlocConsumer<appCubit, appStates>(
        listener: (context, state) {},
        builder: (context, state) {
          appCubit cubit = appCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Shop App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            body: cubit.ListBottomNavWidget[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (int){
                cubit.changeBottomNav(int);
              },
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: Icon(
                    Icons.home_rounded,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Categories',
                  icon: Icon(
                    Icons.grid_view,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Favorites',
                  icon: Icon(
                    Icons.favorite,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Icon(
                    Icons.settings,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
