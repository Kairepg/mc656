import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture(
      {super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePicture();
}

class _ProfilePicture extends State<ProfilePicture> {
  Uint8List? pickedImage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String emailId = '';


@override
  void initState() {
    final user = _auth.currentUser;
    if (user != null) {
      emailId = user.email ?? '';
    }
    super.initState();
    getProfilePicture();
  }


  void onProfileTapped() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final storage = FirebaseStorage.instance.ref();
      final imageReference = storage.child('$emailId.jpg');
      final imageByte = await image.readAsBytes();
      await imageReference.putData(imageByte);

      setState(() => pickedImage = imageByte);
  }

  Future<void> getProfilePicture() async {
    final storage = FirebaseStorage.instance.ref();
    final imageReference = storage.child('$emailId.jpg');

    try {
      final imageByte = await imageReference.getData();
      if (imageByte == null) return;

    } catch (e){
      print('Foto de perfil não encontrada.');
    }
  }


 
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        decoration: 
        BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
          image: pickedImage != null 
          ? DecorationImage(
            fit: BoxFit.cover,
            image: Image.memory(
              pickedImage!,
              fit: BoxFit.cover,
            ).image,
            ): null),
        child: const Center(
          child:  Icon(Icons.account_circle, size: 100),
        ),
        ),
        Positioned(
          bottom: 1,
          right: 230,
          child: GestureDetector( 
            onTap: onProfileTapped,
            child: 
            Container(
           
            decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    50,
                  ),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 4),
                    color: Colors.black.withOpacity(
                      0.3,
                    ),
                    blurRadius: 3,
                  ),
                ]),
           child: const Padding(
              padding:  EdgeInsets.all(2.0),
              child: Icon(Icons.photo_camera, color: Colors.black),
            ),),),)
      ],
    );
  }
}
// const Icon(Icons.account_circle, size: 100),