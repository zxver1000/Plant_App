import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/home/message.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'calendar_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'collect_events.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference event = FirebaseFirestore.instance.collection('events');

  late Map<String, List<String>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  //final selectedDay = DateFormat('yyyy-MM-dd').format(DateTime.now()); //DateTime to String

  final  _eventController = TextEditingController(); //텍스트 필드에서 값을 가져올 수 있게 해주는 거

  //final String eventTitle;



  @override
  void initState() {
    //FirebaseFirestore.instance.collection('events').snapshots();
   
    selectedEvents = {};
    super.initState();
  }

  List<String> _getEventsfromDay(DateTime date){
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
        title: const Text('Calendar'),
        backgroundColor: mainColor,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: (){
              FirebaseAuth.instance.signOut();
              //Navigator.pop(context);
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
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
              },
              selectedDayPredicate: (DateTime date){
                return isSameDay(selectedDay, date);
              },
            
              eventLoader: _getEventsfromDay,
            
              //To style the Calendar
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: purple,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                ),
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
            
            Message(selectedDay.toString()),
            // ..._getEventsfromDay(selectedDay).map((selectedEvents) => ListTile(
            //   title: Text(_eventController.text)
            // ),
            // ),//map
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: beige,
        onPressed: () =>
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Add Event"),
                content: TextFormField(
                  controller: _eventController, //_eventController.text로 텍스트필드에 쓴 일정을 꺼내옴
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: mainColor
                    ),
                    onPressed: ()async{
                      
                      //for(int i = 0; i < selectedEvents.length; i++){
                        if(_eventController.text.isEmpty){
                          
                        }else{
                          if(selectedEvents[selectedDay.toIso8601String()] != null){
                            selectedEvents[selectedDay.toIso8601String()]!.add(
                              _eventController.text,
                            );
                          }else{
                            selectedEvents[selectedDay.toIso8601String()] = [
                              _eventController.text
                            ];

                          }
                        //}
                        await event.add({
                          'Date': selectedDay.toIso8601String(),
                          'Title': _eventController.text,
                        }).then((value) => print('User added'));
                        Navigator.pop(context);
                        _eventController.clear();
                        setState(() {
                            
                        });
                        return;
                      }
                      
                    },
                    child: const Text("OK"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: mainColor
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ],
              )
            ),
        label: const Text("Add Event", style: TextStyle(color: Colors.black),),
        icon: const Icon(Icons.add, color: Colors.black,),
      ),
      
    );
  }
}