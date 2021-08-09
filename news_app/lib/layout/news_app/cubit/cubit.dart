import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
import 'package:newsapp/modules/sports/sports_screen.dart';
import 'package:newsapp/shared/network/local/cach_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
import 'package:newsapp/layout/news_app/news_layout.dart';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ),

  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),

  ];

  void changeBottomNavBar(int index){
    currentIndex = index;

    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavStates());
  }

  List<dynamic> business= [];

  void getBusiness(){

    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business',
        'apiKey':'4f8c8991191640d5b954c241be4c5522',
      },
    ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    }
    );
  }

  List<dynamic> sports= [];

  void getSports(){

    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'sports',
            'apiKey':'4f8c8991191640d5b954c241be4c5522',
          },
        ).then((value)
        {
          //print(value.data['articles'][0]['title']);
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }
        ).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        }
        );
      }
    else
      {
        emit(NewsGetSportsSuccessState());
      }

  }

  List<dynamic> science= [];

  void getScience(){

    emit(NewsGetScienceLoadingState());

    if(science.length ==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'science',
            'apiKey':'4f8c8991191640d5b954c241be4c5522',
          },
        ).then((value)
        {
          //print(value.data['articles'][0]['title']);
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }
        ).catchError((error){
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        }
        );
      }
    else {
      emit(NewsGetScienceSuccessState());
    }


  }

  List<dynamic> search= [];
  void getSearch(){

    emit(NewsGetSearchLoadingState());

    search= [];

    var value;
    DioHelper.getData(
      url: 'v2/everything',
      query:
      {

        'q':'$value',
        'apiKey':'4f8c8991191640d5b954c241be4c5522',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    }
    );


  }

  bool isDark =false;

  void changeAppMode({required bool fromShared})
  {
    // ignore: unnecessary_null_comparison
    if(fromShared != null)
      {
        isDark = fromShared;
        emit(NewsChangeModeState());
      }

    else
      {
        isDark = !isDark;
        CachHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
          emit(NewsChangeModeState());
        });
      }


  }
}