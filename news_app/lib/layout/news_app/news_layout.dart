import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/search/search_screen.dart';
import 'package:newsapp/shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "News App",
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },

              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: () {
                  var isDark;
                  NewsCubit.get(context).changeAppMode(fromShared: isDark);
                },

              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
