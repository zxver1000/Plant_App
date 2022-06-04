
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/category_2/model/category_model.dart';
import 'package:plant_app/screens/category_2/plant_lists.dart';
import 'package:plant_app/notification.dart';
import 'package:plant_app/screens/category_2/register_plant.dart';

class MakePlant extends StatefulWidget {
  const MakePlant({Key? key}) : super(key: key);

  static String routeName = "make_plant";

  @override
  State<MakePlant> createState() => _MakePlantState();
}

class _MakePlantState extends State<MakePlant> {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;


  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController watercycleController = TextEditingController();

  String plantName ='';
  String content ='';
  String water_cycle = '';
  String information = '';

  String image = '';

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings;

    late String retriveString;

    if(data.arguments == null)
      retriveString = "empty";
    else
      retriveString = data.arguments as String;

    print(data);

    if(retriveString == "오이"){
      information = '① 햇빛의 세기: 일조가 부족하면 기형이 발생. \n ②재배일정: 6월 말~8월 초 \n ③키우는 방법:\n-오이 모종은 20~35일간, 낮 20~28℃, 밤 17~20℃의 환경에서 기른다.\n-밀식하면 아래 잎이 햇빛을 충분히 받지 못하므로 포기사이를 35cm 정도로 하여 심는다.\n-낮 25~28℃, 밤 15~18℃의 환경에서 키운다.\n-저온기에는 5~7일, 고온기에는 2~3일에 1회 소량으로 여러　번 물을 준다.\n-열매가 달리면 원줄기 6~7마디까지 달리는 암꽃은 일찍 제거해서 식물체가 튼튼하게 자라도록 한다.\n④수확: 아주심기 후 약 30일 전후면 수확이 가능하다. 수확은 오전 중에 하는 것이 신선도를 오래 유지할 수 있다.\n⑤주요 병충해: 흰가루병, 노균병, 잿빛곰팡이병, 진딧물 등\n-같은 장소에 박과 작물(수박, 오이, 참외, 멜론 등)을 계속해서 재배하지 않도록 한다.\n-주변 잡초는 빨리 뽑고, 오이 밭에 물이 잘 빠지도록 한다.';
      image = "assets/images/오이.jpg";
    }else if(retriveString == "당근"){
      information = '①햇빛의 세기: 빛에 큰 영향을 받지는 않으나, 햇빛을 충분히 쪼여주는 것이 좋다.\n②재배일정: (봄 재배)6월 말~7월 중순 / (여름 재배)8월 말~9월 중순/ (가을 재배)11월 중순~11월말\n③키우는 방법:\n-당근 씨앗을 8~10cm 간격으로 3~4립씩 파종하고, 흙을 0.5~1cm 두께로 덮고 가볍게 두드려준다.\n-씨앗을 뿌린 후 30~40일경에, 본 잎이 3~4매시 첫 솎음을 실시하고, 그 후 10~15일 후 한 번 더 솎음한다. 발아한 당근 중 튼튼한 것 1포기를 제외하고 나머지는 뽑아버린다.\n-씨앗을 뿌린 후 물을 주고, 땅 표면이 말랐을 때(보통 7~10일 간격) 물을 충분히 준다.\n-첫 웃거름은 솎음 작업을 끝내고 바로 주고 15~20일 뒤에 두 번째 웃거름을 준다.\n④수확: 파종 후 90~120일 후 수확(미니당근은 70일경) 가능하다.\n⑤주요 병충해: 검은잎마름병, 무름병, 선충 등\n-발생초기 약제 살포를 1주일 간격 2~3회 연속 뿌리면 방제가 가능하다.\n⑥효능: 베타카로틴 성분이 많이 포함되어 있어 몸속에서 프로비타민 A로 바꾸어 시력을 보호하고 야맹증을 예방하며 피부를 매끄럽게 한다.\n 또한 강한 항산화 성분으로 항암작용을 하여 폐암, 후두암 자궁암등에 예방효과가 있는 알칼리성 식품이다.';
      image = "assets/images/당근.jpg";
    }
    else if(retriveString == "아이비"){
      information =  '①햇빛의 세기: 반음지식물이기 때문에 직접적인 햇빛이 필요하지 않다.\n②특징:\n-두릅나뭇과의 상록성 덩굴식물로 담이나 나무줄기에 붙어 자란다.\n-꽃은 녹색을 띄고, 꽃받침조각은 5개이다.\n③키우는 방법:\n-16~20℃가 적당하고, 잎이 녹색으로 덮여진 아이비는 실내 밝은 곳에서, 잎에 흰색 무늬가 있는 것은 어느 정도 햇빛이 들어오는 곳에서 기르는 것이 좋다.\n-고온에 약하고, 과습에 약하므로, 여름철에는 직사광선이 아닌 곳에서 물주기를 줄인다.\n-건조한 겨울철에는 물주기는 가끔 해주는 대신 분무를 자주 해준다.\n-뿌리는 건조하게, 잎은 습하게 유지한다.\n-여름이나 겨울에는 성장이 멈추기 때문에 덩굴을 자르지 않는 것이 좋다.\n④수경재배: 아이비는 뿌리, 줄기가 과도하게 자랐을 때 수경재배가 가능하다. 덥수룩하지 않게 가지치기를 한 후 뿌리 부분이 충분히 잠길 수 있는 물속에 넣으면 20~30일 후 뿌리가 튼튼하게 내려진다.\n⑤효능: 공기정화에도 좋고 가습효과도 좋다.';
      image ="assets/images/아이비.jpg";
    }
    return Scaffold(

      appBar: AppBar(title: Text('식물 정보'),
        backgroundColor: mainColor,),
      body:SingleChildScrollView(

        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 5,),
            Text("선택한 식물 : $retriveString",
              style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontSize: 17.0,
                  fontWeight: FontWeight.normal
              ),),
            SizedBox(height: 5,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(image,
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5,),

                  Column(
                    children: [
                      Text(information,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterPlant() ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: activecolor
                          ),
                          child: Text('해당 식물 추가하기')
                      ),
                    ]

        ),
     ],
                      ),
      ),
    );

  }
}
