import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:plant_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference event = FirebaseFirestore.instance.collection('events');
/*
  await event.add({
  'Date': selectedDay.toString().substring(0,10),
  'Title': _eventController.text,
  }).then((value)
  {
  print(value.id);
  if(selectedEvents[selectedDay] != null){
  selectedEvents[selectedDay]!.add(
  value.id + '▒' + _eventController.text,
  );
  }else{
  selectedEvents[selectedDay] = [
  value.id + '▒' + _eventController.text
  ];

  }
  });
  */
  late Map<DateTime, List<String>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.parse(DateTime.now().toString().substring(0,10) + " 00:00:00.000Z");
  DateTime focusedDay = DateTime.parse(DateTime.now().toString().substring(0,10) + " 00:00:00.000Z");

  final  _eventController = TextEditingController(); //텍스트 필드에서 값을 가져올 수 있게 해주는 거
  List eventList = [];

  //final String eventTitle;

  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    //FirebaseFirestore.instance.collection('events').snapshots();
    selectedEvents = {};
    
    // selectedEvents = Message(selectedDay.toString()) as Map<DateTime, List>;
    getData();
    super.initState();

  }

  void _daySelect(selectDay, focusDay){
    setState(() {
      selectedDay = selectDay;
      focusedDay = focusDay;
    });
  }

  getData() async{
    await db.collection("events").get().then((event) {
      for (var doc in event.docs) {
        // print(doc.data());
        var eventData = doc.data();
        eventData["id"]= doc.id;
        // print(eventData);
        

        eventList.add(eventData);
        //print(" ${DateTime.fromMicrosecondsSinceEpoch(doc.data()['Date'].microsecondsSinceEpoch)}");
      }
    });
    
    print(eventList);
    //sleep(const Duration(seconds: 1));
    eventList.asMap().forEach(
      (index, value) {
        // print('&&&&&&&' + value['Date']);
        // print('&&&&&&&' + value['Title']);

        if (selectedEvents[DateTime.parse(value['Date'] + " 00:00:00.000Z")] != null) {
            selectedEvents[DateTime.parse(value['Date'] + " 00:00:00.000Z")]!.add(
            value['id']+'▒'+value['Title'],
          );
        } else {
          selectedEvents[DateTime.parse(value['Date'] + " 00:00:00.000Z")] = [
            value['id']+'▒'+value['Title'],
          ];
        }
        print(selectedEvents[DateTime.parse(value['Date'] + " 00:00:00.000Z")]);
        //   selectedEvents[DateTime.parse(value[index][0] + " 00:00:00.000Z")] = [
        // Event(title: value[index][1]) ]
      },
    );
    print(selectedEvents);

    _daySelect(selectedDay, focusedDay);
    
  }
  List<dynamic> _getEventsfromDay(DateTime date){
    return selectedEvents[date] ?? [];
  }

  //위젯이 dispose될 때 TextEditingController도 함께 dispose될 수 있게 해줌
  @override
  void dispose(){
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('캘린더'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: 
      SingleChildScrollView(
        child: 
        Column(
          children: [
            TableCalendar(
              //locale: 'ko-KR',
              focusedDay: focusedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format){
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay){
                _daySelect(selectDay, focusDay);
                print(focusDay);
              },
              selectedDayPredicate: (DateTime date){
                return isSameDay(selectedDay, date);
              },
            
              eventLoader: _getEventsfromDay,
            
              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: purple,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: purple, width: 1.5)
                ),
                todayTextStyle: TextStyle(color: Colors.black),
                defaultDecoration: BoxDecoration(
                  //color: Color(0xffD0CEF7),
                  shape: BoxShape.circle,
                ),
                weekendDecoration: BoxDecoration(
                  //color: Color(0xffD0CEF7),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            
            // Message(selectedDay.toString()),
            ..._getEventsfromDay(selectedDay).map((dynamic event) => ListTile(
              trailing: IconButton(
                icon: Icon(Icons.delete,
                ),
                onPressed: () async{ 
                  // print(event.id);
                  await db.collection('events').doc(event.split('▒')[0]).delete().then((_) {
                    selectedEvents[selectedDay] = [];
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 1000),
                        content: Text('일정을 삭제하였습니다!'),),);
                    print('delete events');
                  });
                  setState(() {
                    
                  });
                },
              
              ),
              title: Text(event.split('▒')[1])
            ),

            ),//map
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () =>
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("일정 추가하기"),
                content: TextFormField(
                  controller: _eventController, //_eventController.text로 텍스트필드에 쓴 일정을 꺼내옴
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: kPrimaryColor
                    ),
                    onPressed: ()async{
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 1000),
                          content: Text('일정을 추가하였습니다!'),),);
                      //for(int i = 0; i < selectedEvents.length; i++){
                        if(_eventController.text.isEmpty){
                          
                        }else{
                          //.toIso8601String()
                          
                        //}
                        await event.add({
                          'Date': selectedDay.toString().substring(0,10),
                          'Title': _eventController.text,
                        }).then((value) 
                        { 
                          print(value.id);
                          if(selectedEvents[selectedDay] != null){
                            selectedEvents[selectedDay]!.add(
                               value.id + '▒' + _eventController.text,
                            );
                          }else{
                            selectedEvents[selectedDay] = [
                              value.id + '▒' + _eventController.text
                            ];

                          }
                        });

                        Navigator.pop(context);
                        _eventController.clear();
                        setState(() {
                            
                        });
                        return;
                      }
                      
                    },
                    child: const Text("추가"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: kPrimaryColor
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      },
                    child: const Text("취소"),
                  ),
                ],
              )
            ),
        label: const Text("일정 추가", style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add, color: Colors.white,),
      ),
      
    );
  }
}