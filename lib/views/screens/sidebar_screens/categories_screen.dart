import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  static const String routeName = '/CategoriesScreen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  dynamic _category;
  String? fileName;
  late String categoryName;

  _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _category = result.files.first.bytes;
        fileName = result.files.first.name;
        categoryName = result.files.first.name;
      });
    }
  }

  _uploadCategoryThumbnailToStorage(dynamic image) async {
    Reference ref = _storage.ref().child('categoryImages').child(fileName!);

    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }

  uploadCategory() async {
  EasyLoading.show(status: 'Uploading...');
  if (_formKey.currentState!.validate()) {
    try {
      String imageUrl = await _uploadCategoryThumbnailToStorage(_category);
      await _firestore.collection('categories').doc(fileName).set({
        'image': imageUrl,
        'categoryName': categoryName,
      });
      EasyLoading.dismiss();
      setState(() {
        _category = null;
      });
    } catch (error) {
      EasyLoading.dismiss();
      print('Error uploading category: $error');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 140,
                    width: 230,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _category != null
                          ? Image.memory(
                              _category,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Text('Category Preview'),
                            ),
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: 250,
                    child: TextFormField(
                      onChanged: (value) {
                        categoryName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter New Category Name';
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'New Category',
                        hintText: 'Enter New Category Here',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                  onPressed: () {
                    uploadCategory();
                  },
                  icon: const Icon(Icons.save),
                  iconSize: 50,
                  color: Colors.blue[200],
                  hoverColor: Colors.blue[400],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    _pickImage();
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
      ),
    );
  }
}
