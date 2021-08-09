
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                      color: Colors.grey

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget myDivider()=> Padding(padding: EdgeInsets.all(10.0),child: Container(width: double.infinity, height: 1.0,));

Widget articleBuilder(context, list)=> Conditional.single(
  context: context,
  conditionBuilder: (context) => list.length > 0,
  widgetBuilder: (context)=> ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index)=> buildArticleItem(list[index], context),
      separatorBuilder: (context, index)=> myDivider(),
      itemCount: 10
  ),
  fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
  /*condition: state is! NewsGetBusinessLoadingState,
          builder: (context)=> ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index)=> buildArticleItem(list[index]),
              separatorBuilder: (context, index)=> myDivider(),
              itemCount: 10),
          fallback: (context) => Center(child: CircularProgressIndicator()),*/
);

void navigateTo(context, widget) => Navigator.push(context,
    MaterialPageRoute(
      builder: (context)=>widget,
    )
);