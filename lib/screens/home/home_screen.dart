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
        eventList.add(doc.data());
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
            value['Title'],
          );
        } else {
          selectedEvents[DateTime.parse(value['Date'] + " 00:00:00.000Z")] = [
            value['Title'],
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
              trailing: const Icon(Icons.delete),
              onTap: () => print('tap delete'),
              title: Text(event)
            ),
            ),//map
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
                          //.toIso8601String()
                          if(selectedEvents[selectedDay] != null){
                            selectedEvents[selectedDay]!.add(
                              _eventController.text,
                            );
                          }else{
                            selectedEvents[selectedDay] = [
                              _eventController.text
                            ];

                          }
                        //}
                        await event.add({
                          'Date': selectedDay.toString().substring(0,10),
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