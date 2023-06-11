import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key});

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _shopController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  File? _image;

  // CollectionReference _reference=FirebaseFirestore.instance.collection('shopping_list');
  Future _getCameraImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future _getGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _image == null
                        ? Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                            ),
                          )
                        : Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                            ),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                  Column(
                    children: [
                      TextButton.icon(
                        onPressed: _getCameraImage,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Camera'),
                      ),
                      TextButton.icon(
                        onPressed: _getGalleryImage,
                        icon: const Icon(Icons.image),
                        label: const Text('Gallery'),
                      ),
                      TextButton.icon(
                        // onPressed: _removeImage,
                        onPressed: () {},
                        icon: const Icon(Icons.remove_circle),
                        label: const Text('Remove'),
                      ),
                    ],
                  ),
                ],
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(hintText: 'Category'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(hintText: 'Product name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'Description'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(hintText: 'Price'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _shopController,
                decoration: InputDecoration(hintText: 'Shop'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter shop';
                  }

                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      final productId = const Uuid().v4();
                      if (_image == null) {
                        return showDialog(
                            context: context,
                            builder: (cxt) {
                              return AlertDialog(
                                title: Text('Select image'),
                                content: Text('Image can not be empty'),
                              );
                            });
                      } else {
                        final ref = FirebaseStorage.instance
                            .ref()
                            .child('productImages')
                            .child('${_productNameController.text}.jpg');
                        UploadTask uploadTask = ref.putFile(_image!);
                        // String url = await ref.getDownloadURL();
                        // await ref.putFile(_image!);
                        final snapshot =
                            await uploadTask.whenComplete(() => null);

                        final urlImageUser =
                            await snapshot.ref.getDownloadURL();
                        await FirebaseFirestore.instance
                            .collection('products')
                            .doc(productId)
                            .set({
                          'category': _categoryController.text,
                          'description': _descriptionController.text,
                          'name': _productNameController.text,
                          'image': urlImageUser,
                          'price': _priceController.text,
                          'shop': _shopController.text,
                        });
                      }
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
