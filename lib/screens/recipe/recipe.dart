
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/main.dart';
import 'package:plant_app/screens/recipe/recipe_item.dart';
import 'package:provider/provider.dart';

class recipe extends StatefulWidget {
  const recipe({Key? key}) : super(key: key);





  @override
  State<recipe> createState() => _recipeState();
}

class _recipeState extends State<recipe> with SingleTickerProviderStateMixin{
  late TabController? tab;
  var indexs=0;
  var board_name=["샐러드/수프","무침","부침","조림"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tab=TabController(
      length: 4,
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("레시피"),
      backgroundColor: mainColor,),

      body: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:TabBar(
              indicatorColor: purple,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              controller: tab,onTap:(i){
              indexs=i;
            },
              tabs: [Tab(text:board_name[0],),Tab(text:board_name[1],),Tab(text:board_name[2]),Tab(text:board_name[3])]),
          ),
          body: TabBarView(
            controller: tab,
            children: <Widget>[
              CustomScrollView(
                  slivers:<Widget>[
                    SliverFixedExtentList(
                      itemExtent: 100.0,
                      delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                        return Padding(
                            padding:EdgeInsets.only(top: 1),
                            child:
                            Column(children: <Widget>[ ListTile(
                              isThreeLine: true,
                              // leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
                              title:Text(context.watch<recipeData>().saladData[index].name.toString()),
                              subtitle: Text(context.watch<recipeData>().saladData[index].summary.toString()),
                              onTap : ()=>{
                                print("tab :"+indexs.toString()),

                                context.read<recipeData>().plusVisit(context.read<recipeData>().saladData[index])
                              ,Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return information(board_name:board_name[indexs],index:index,item_num:0);
                              }))
                              },
                              trailing:Image(image: AssetImage(context.watch<recipeData>().saladData[index].image),height: 70,width: 70,),
                            ),
                              Divider(height: 1,color: Colors.black,)],)
                        );
                      },childCount: context.read<recipeData>().saladData.length),
                    )
                  ]
              ),

              //두번쨰꺼위치!!!

             moochim(board_name:board_name[indexs],item_num:indexs)
           ,
              boochim(board_name:board_name[indexs])
            ,

            jorim(board_name: board_name[indexs],)
            ],
          ),





      ),
    );
  }
}


class information extends StatefulWidget {
  const information({Key? key,this.board_name,this.index,this.item_num}) : super(key: key);
  final board_name;
  final index;
  final item_num;
  @override
  State<information> createState() => _informationState();
}
class _informationState extends State<information> {


  var items;
  @override
  void initState() {
    // TODO: implement initState

    if(widget.item_num==0) {items=saladRecipe;}
    else if(widget.item_num==1) {items=moochimRecipe;}
    else if(widget.item_num==2) {items=boochimRecipe;}
    else {items=jorimRecipe;}

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("레시피정보"),
        backgroundColor: mainColor,),
      body:CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
                padding:EdgeInsets.all(13),
                child:Text(widget.board_name.toString()+" >")),
          ),
          SliverToBoxAdapter(
              child: Padding(padding: EdgeInsets.all(13),

                child: Image(image: AssetImage(items[widget.index].image),height: 200,),)
          ),
          SliverToBoxAdapter(
            child: Divider(height: 1,color: Colors.black,),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:EdgeInsets.all(13),
                child:Text("● "+items[widget.index].name.toString())),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:EdgeInsets.only(left: 13),
                child:Text("- 조리시간 : "+items[widget.index].cookingtime.toString())),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:EdgeInsets.only(left: 13),
                child:Text("- 칼로리 : "+items[widget.index].calorie.toString())),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:EdgeInsets.all(13),
                child:Text("- 주재료 : "+items[widget.index].mainingredient.toString())),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:EdgeInsets.all(13),
                child:Text("- 부재료 : "+items[widget.index].subingredient.toString())),
          ),

          SliverToBoxAdapter(
            child: Padding(
                padding:EdgeInsets.only(left: 13),
                child:Text("- 조리법 : "+items[widget.index].cookingcourse.toString())),
          ),

        ],
      ),

      bottomNavigationBar: BottomAppBar(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween
          ,children: [TextButton(onPressed: (){
          Navigator.pop(context,false);
        }, child: Row(children: [Icon(Icons.list),Text("목록으로"),],),
          style:TextButton.styleFrom(primary: Colors.black),),
          TextButton(onPressed: (){}, child:
          Row(children: [Icon(Icons.star)],))],),
      ),
    );
  }
}


class moochim extends StatefulWidget {
  const moochim({Key? key,this.board_name,this.item_num}) : super(key: key);
final board_name;
final item_num;
  @override
  State<moochim> createState() => _moochimState();
}

class _moochimState extends State<moochim> {
  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
        slivers:<Widget>[
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildBuilderDelegate((BuildContext context,int index){
              return Padding(
                  padding:EdgeInsets.only(top: 1),
                  child:

                  Column(children: <Widget>[ ListTile(
                    isThreeLine: true,
                    // leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
                    title:Text(moochimRecipe[index].name.toString()),
                    subtitle: Text(moochimRecipe[index].summary.toString()),
                    onTap : ()=>{


                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return information(board_name:widget.board_name,index:index,item_num:1);
                      }))

                    },
                    trailing:Image(image: AssetImage(moochimRecipe[index].image),height: 70,width: 70,),
                  ),
                    Divider(height: 1,color: Colors.black,)],)
              );
            },childCount: moochimRecipe.length),
          )
        ]
    );
  }
}

class boochim extends StatefulWidget {
  const boochim({Key? key,this.board_name}) : super(key: key);
  final board_name;
  @override
  State<boochim> createState() => _boochimState();
}

class _boochimState extends State<boochim> {
  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
        slivers:<Widget>[
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildBuilderDelegate((BuildContext context,int index){
              return Padding(
                  padding:EdgeInsets.only(top: 1),
                  child:
                  Column(children: <Widget>[ ListTile(
                    isThreeLine: true,
                    // leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
                    title:Text(boochimRecipe[index].name.toString()),
                    subtitle: Text(boochimRecipe[index].summary.toString()),
                    onTap : ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return information(board_name:widget.board_name,index:index,item_num:2);
                      }))

                    },
                    trailing:Image(image: AssetImage(boochimRecipe[index].image),height: 70,width: 70,),
                  ),
                    Divider(height: 1,color: Colors.black,)],)
              );
            },childCount: boochimRecipe.length),
          )
        ]
    );
  }
}

class jorim extends StatefulWidget {
  const jorim({Key? key,this.board_name}) : super(key: key);
 final board_name;
  @override
  State<jorim> createState() => _jorimState();
}

class _jorimState extends State<jorim> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers:<Widget>[
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildBuilderDelegate((BuildContext context,int index){
              return Padding(
                  padding:EdgeInsets.only(top: 1),
                  child:

                  Column(children: <Widget>[ ListTile(
                    isThreeLine: true,
                    // leading: dataset[index].userImage!=null?Image.file(dataset[index].userImage):Text(""),
                    title:Text(jorimRecipe[index].name.toString()),
                    subtitle: Text(jorimRecipe[index].summary.toString()),
                    onTap : ()=>{

                      /*
                      ,Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return information(board_name:board_name[indexs],index:index);
                      }))
                      */
                    },
                    trailing:Image(image: AssetImage(jorimRecipe[index].image),height: 70,width: 70,),
                  ),
                    Divider(height: 1,color: Colors.black,)],)
              );
            },childCount: jorimRecipe.length),
          )
        ]
    );
  }
}
