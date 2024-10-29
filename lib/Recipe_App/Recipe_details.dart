import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "Provider.dart";
import "data.dart";
class recipeDetrails extends StatefulWidget {
  const recipeDetrails({super.key});

  @override
  State<recipeDetrails> createState() => _recipeDetrailsState();
}

class _recipeDetrailsState extends State<recipeDetrails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Consumer<changesProvider>(builder: (context,value,index){
              return Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(width: 1),
                    ),
                    width: MediaQuery.sizeOf(context).width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(meals[value.changeMealIndex].imageUrl,fit: BoxFit.fill,)),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(meals[value.changeIndex].title,style: TextStyle(fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){
                        value.addMeals(meals[value.changeMealIndex]);
                      }, icon:value.MealStatus(meals[value.changeMealIndex])
                          ? Icon(Icons.favorite,color: Colors.red,)
                          : Icon(Icons.favorite_border,color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange),
                      child: Center(
                          child: Text(meals[value.changeMealIndex].id,
                              style: TextStyle(color: Colors.white, fontSize: 20))),
                    ),
                    trailing: Text(meals[value.changeMealIndex].complexity),
                    title: Text(
                      meals[value.changeMealIndex].affordability,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                    Text("Duration ${meals[value.changeMealIndex].duration} Minutes"),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text("Ingredients",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Flex(direction: Axis.horizontal,
                      children: List.generate(meals[value.changeMealIndex].ingredients.length,(indx)=>Card(
                        color: Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              meals[value.changeMealIndex].ingredients[indx],
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      )
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text("Steps to prepare",style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  for (int i = 0; i < meals[value.changeIndex].steps.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${i + 1}. ${meals[value.changeMealIndex].steps[i]}",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            })
        ),
      ),
    );
  }
}