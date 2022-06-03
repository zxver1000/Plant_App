import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/constants.dart';


class RegistProfile extends StatefulWidget {
  const RegistProfile({Key? key}) : super(key: key);

  @override
  State<RegistProfile> createState() => _RegistProfileState();
}

class _RegistProfileState extends State<RegistProfile> {

  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  //PickedFile? _imageFile;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            imageProfile(),
            SizedBox(height: 20),
          ],
        ),
      ),

    );
  }




Widget imageProfile()
{
  return Center(
    child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80,
          backgroundImage:
            AssetImage("assets/images/avatar.png")
              /*_imageFile == null
              ? AssetImage("assets/images/avatar.png")
              : FileImage(File(_imageFile.path)),
*/
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                  Icons.camera_alt,
                  color: mainColor,
                  size :40
              ),
            )
        )
      ],
    ),
  );

}

Widget bottomSheet(){
  return Container(
    height: 40,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
    ),
    child: Column(
      children: [
        Text('Choose Profile photo',
          style: TextStyle(
            fontSize:20,
          ),
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.camera, size: 50,),
              onPressed:(){
                takePhoto(ImageSource.gallery);
              },
              label: Text('Camera', style: TextStyle(fontSize: 20),),
            ),
         ElevatedButton.icon(
             onPressed:(){
               takePhoto(ImageSource.gallery);
             },
             icon: Icon(Icons.photo_library, size: 50,),
             label: Text('Gallery', style: TextStyle(fontSize: 20),)
         )
          ],
        )

      ],
    ),
  );
}

takePhoto(ImageSource source) async {
  final pickedFile = await _picker.pickImage(source: source);
  setState((){
    _imageFile = pickedFile;
  });
}


}


