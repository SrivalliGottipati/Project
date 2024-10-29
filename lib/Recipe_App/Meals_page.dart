import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "Provider.dart";
import "Recipe_details.dart";
import "data.dart";
class recpirDsply extends StatefulWidget {
  recpirDsply({super.key});

  @override
  State<recpirDsply> createState() => _recpirDsplyState();
}

class _recpirDsplyState extends State<recpirDsply> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(itemBuilder: (context,index){
          return Consumer<changesProvider>(builder: (context,value,ind){
            return
              meals[index].categoryIds.contains(("c"+(value.changeIndex+1).toString())) ?
              GestureDetector(
                onTap: (){
                  value.setMealIndex(index);
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>recipeDetrails()));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("  "+meals[index].title),
                          IconButton(onPressed: (){
                            value.addMeals(meals[index]);
                          }, icon:value.MealStatus(meals[index])
                              ? Icon(Icons.favorite,color: Colors.red,)
                              : Icon(Icons.favorite_border,color: Colors.black),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Container(
                            height: 150,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                child: Image.network(meals[index].imageUrl,fit: BoxFit.fill,height: 500,))),
                      ),
                    ],
                  ),
                ),
              ): SizedBox(height: 0,);
          });
        },itemCount: meals.length,),
      ),
    );
  }
}