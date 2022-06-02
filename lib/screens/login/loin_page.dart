import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_app/constants.dart';
import '../main_screens.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _authentication = FirebaseAuth.instance;
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  bool showSpinner = false;

  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            //배경
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                child: Container(
                  padding: EdgeInsets.only(top:90, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                      text: TextSpan(
                        text: 'Welcom',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 25,
                          color: Colors.white
                        ),
                        children: [
                          TextSpan(
                            text: !isSignupScreen ? '!!' : '!!\nRegister your information',
                            style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 25,
                            color: Colors.white,
                          ),
                          )
                        ]
                      ),
                    ),
                    ]
                    
                  ),
                ),
                ),
              ),
            //텍스트 폼 필트
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              top: 180,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                padding: EdgeInsets.all(20.0),
                height: isSignupScreen ? 280.0 : 250.0,
                width: MediaQuery.of(context).size.width-40,
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5
                    )
                  ]
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen ? activecolor : skyblue
                                  ),
                                ),
                                if(!isSignupScreen)
                                Container(
                                  height: 2,
                                  width: 55,
                                  color: Color.fromARGB(255, 41, 74, 42),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isSignupScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen ? activecolor : skyblue
                                  ),
                                ),
                                if(isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Color.fromARGB(255, 41, 74, 42),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      if(isSignupScreen)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                key: ValueKey(1),
                                validator: (value){
                                  if(value!.isEmpty || value.length < 4){
                                    return 'Please enter at least 4 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  userName = value!;
                                },
                                onChanged: (value){
                                  userName = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                      ),
                                  ),
                                  hintText: 'User name',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: skyblue
                                  ),
                                  contentPadding: EdgeInsets.all(10)
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey(2),
                                validator: (value){
                                  if(value!.isEmpty || !value.contains('@')){
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  userEmail = value!;
                                },
                                onChanged: (value){
                                  userEmail = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                      ),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: skyblue
                                  ),
                                  contentPadding: EdgeInsets.all(10)
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                obscureText: true,
                                key: ValueKey(3),
                                validator: (value){
                                  if(value!.isEmpty || value.length < 5){
                                    return 'Please enter at least 6 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  userPassword = value!;
                                },
                                onChanged: (value){
                                  userPassword = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                      ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: skyblue
                                  ),
                                  contentPadding: EdgeInsets.all(10)
                                ),
                              )
                            ],
                          ),
                          ),
                      ),
                      if(!isSignupScreen)
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                key: ValueKey(4),
                                validator: (value){
                                      if(value!.isEmpty || !value.contains('@')){
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                },
                                onSaved: (value){
                                  userEmail = value!;
                                },
                                onChanged: (value){
                                  userEmail = value;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                      ),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: skyblue
                                  ),
                                  contentPadding: EdgeInsets.all(10)
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                obscureText: true,
                                key: ValueKey(5),
                                validator: (value){
                                      if(value!.isEmpty || value.length < 6){
                                        return 'Password must be at least 7 characters long';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){       
                                      userPassword = value!;
                                    },
                                    onChanged: (value){
                                      userPassword = value;
                                    },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                      BorderSide(color: skyblue),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                      ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: skyblue
                                  ),
                                  contentPadding: EdgeInsets.all(10)
                                ),
                              )
                            ],
                          ),
                
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //전송버튼
            AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                top: isSignupScreen ? 430 : 390,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        if (isSignupScreen) {
                          _tryValidation();

                          try {
                            final newUser = await _authentication
                                .createUserWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );

                            await FirebaseFirestore.instance.collection('users').doc(newUser.user!.uid)
                            .set({
                              'userName' : userName,
                              'email' : userEmail
                            });

                            if (newUser.user != null) {
                              print(newUser.user!.uid);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MainScreens();
                                  },
                                ),
                              );

                              
                            }
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                Text('Please check your email and password'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          }
                        }
                        if (!isSignupScreen) {
                          _tryValidation();

                          try {
                            final newUser =
                            await _authentication.signInWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );
                            if (newUser.user != null) {
                              print(newUser.user);
                            }
                          }catch(e){
                            print(e);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [mainColor, mainColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0,1)
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_forward,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
    
  }
}