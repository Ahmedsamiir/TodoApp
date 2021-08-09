
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/layout/news_app/news_layout.dart';
import 'package:newsapp/shared/bloc_observer.dart';
import 'package:newsapp/shared/network/local/cach_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';
//import 'package:bloc/bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CachHelper.init();

  bool? isDark = CachHelper.getBoolean(key: 'isDark');



  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NewsCubit()
          ..getBusiness()
          ..getSports()
          ..getScience(),),
        BlocProvider(create: (BuildContext context)=>NewsCubit()..changeAppMode(fromShared: isDark),)

      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){
        },
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),

                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                    color: Colors.black
                ),

              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black26,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),

                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                    color: Colors.white
                ),

              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor('333739'),

              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,

            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
