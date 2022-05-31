
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/category_2/make_plant.dart';
import 'package:plant_app/screens/category_2/model/category_helper.dart';
import 'package:plant_app/screens/category_2/model/category_model.dart';
/*
class PlantArguments {
  late CategoryModel model;
  late int index;

  PlantArguments(this.model ,this.index);
}
*/

class CategoryCard extends StatelessWidget {
  final CategoryModel model;
  final int index;

  static const routeName = '/category_card';


  final Function(double val) onHeight;

  const CategoryCard({Key? key, required this.model, required this.index, required this.onHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

   /* final args = ModalRoute.of(context)!.settings.arguments as PlantArguments;*/


    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      onHeight((context.size!.height) /
          (model.plants.length / CategoryHelper.GRID_COLUMN_VALUE));
    });


    return Column(
      children: [
        Divider(),
        Text("${model.categoryName} "),
        Card(
          child: buildGridViewProducts(index, model.plants),
        ),
      ],
    );
  }

  GridView buildGridViewProducts(int index, List<Plant> plants) {

    return GridView.builder(

      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: plants.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: CategoryHelper.GRID_COLUMN_VALUE),
      itemBuilder: (context, index) {
        return Card(
          //child: Text(plants[index].name),
          /*child: ListTile(
           title: Text(plants[index].name),
           leading: CircleAvatar(
             backgroundImage: AssetImage('assets/icons/user.svg'),
             radius: 15,


           ),
           onTap: (){
             print('Card Clicked');

             },
         )
          */
         child: Container(

           child: Column(
             children: [
               SizedBox(height: 10,),
               Text(plants[index].name),

               ElevatedButton(
                   style: ButtonStyle(
                       backgroundColor:MaterialStateProperty.all(purple) ),
                   onPressed: () {
                   //  Navigator.push(context, MaterialPageRoute(builder: (context) => MakePlant()),
                   Navigator.of(context).push(
                     MaterialPageRoute(
                       builder: (context) => MakePlant(),
                       settings: RouteSettings(
                         arguments: plants[index].name
                       )
                   ),
                     );


                   },
                   child: Text("식물 등록 ")
               )
             ],
           ),

         )

        );
      },
    );
  }
}
