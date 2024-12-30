import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ManageBannersScreen extends StatefulWidget {
  const ManageBannersScreen ({super.key});

  static const String routeName = '/ManageBannersScreen';

  @override
  State<ManageBannersScreen> createState() => _ManageBannersScreenState();
}

class _ManageBannersScreenState extends State<ManageBannersScreen> {

  final FirebaseStorage _storage = FirebaseStorage.instance;
  dynamic _banner;
  String? fileName;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  pickImage ()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

if (result != null) {
  setState(() {
    _banner = result.files.first.bytes;
    fileName = result.files.first.name;
  });
}}

_saveBannerToFirebase (dynamic image)async{
Reference ref = _storage.ref().child('Banners').child(fileName!);

UploadTask uploadTask = ref.putData(image);

TaskSnapshot snapshot = await uploadTask;
String downloadURL = await snapshot.ref.getDownloadURL();
  return downloadURL;
}

uploadToFirebaseStore ()async{
  EasyLoading.show(status: "Uploading...",);
  if (_banner != null){
    String imageUrl = await _saveBannerToFirebase(_banner);

   await _firestore.collection('Banners').doc(fileName).set({
    'image' : imageUrl,
    },).whenComplete((){
    EasyLoading.dismiss();

    setState(() {
      _banner = null;
    });
    },
   );
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Manage Banners',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child:  
                  Container(
                    height: 140,
                    width: 230,
                    decoration: BoxDecoration(color: Colors.blue[100], 
                    borderRadius: BorderRadius.circular(10),),
                    child: _banner!=null ? Image.memory(_banner, fit: BoxFit.cover,) : 
                  const Center(child: Text('Image Preview'),),
                ),
              ),
              const SizedBox(width: 8,),
              IconButton(
                onPressed: (){
                  uploadToFirebaseStore();
                }, 
                icon: const Icon(Icons.save),
                iconSize: 50,
                color: Colors.blue[200],
                hoverColor: Colors.blue[400],
                ),
            ],),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: (){
                      pickImage();
                    }, 
                    icon: const Icon(Icons.add),
                    iconSize: 50,
                    color: Colors.blue[200],
                    hoverColor: Colors.blue[400],
                    ),
            ),
          ),
          ],
        ),
      );
    }
}