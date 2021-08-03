import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/modules/counter/cubit/cubit.dart';
import 'package:todoapp/modules/counter/cubit/states.dart';

class Counter extends StatelessWidget {

  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state){

          if(state is CounterMinusState)
            {
              //print('Minus State');
            }
          if(state is CounterPlusState)
            {
              //print('Plus State');
            }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Title(
                child: Text('Counter'),
                color: Colors.blue,
              ),
            ),
            body: Container(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Text(
                        'Minus',
                        style: TextStyle(fontSize: 50),
                      ),
                      onPressed: () {
                        CounterCubit.get(context).Minus();
                      },
                    ),
                    SizedBox(width: 30,),
                    Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 30,),
                    TextButton(
                      child: Text(
                        'Plus',
                        style: TextStyle(fontSize: 50),
                      ),
                      onPressed: () {
                        CounterCubit.get(context).Plus();

                      },
                    ),
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


