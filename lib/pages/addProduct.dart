import 'dart:io';
import 'package:ecommerce/db/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;

  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantitiyController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  final priceController = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  List<String> selectedSizes = <String>[];
  bool isLoading = false;
  File _image1;
  File _image2;
  File _image3;
  @override
  void initState() {
    _getBrands();
    _getCategories();

    //  _currentCategory = categoriesDropDown[0].value;
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      items.insert(
          0,
          DropdownMenuItem(
            child: Text(categories[i].data['category']),
            value: categories[i].data['category'],
          ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> _getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < brands.length; i++) {
      items.insert(
          0,
          DropdownMenuItem(
            child: Text(brands[i].data['brand']),
            value: brands[i].data['brand'],
          ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        automaticallyImplyLeading: true,
        title: Text(
          "Add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: isLoading
            ? CircularProgressIndicator()
            : ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide: BorderSide(
                              color: grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                1);
                          },
                          child: _displayChild1(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide: BorderSide(
                              color: grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                2);
                          },
                          child: _displayChild2(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide: BorderSide(
                              color: grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                3);
                          },
                          child: _displayChild3(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Enter a product Name with 10 char at max",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      hintText: "Product Name",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "You must type a value";
                      } else if (value.length > 10) {
                        return 'Product name cant be more then 10';
                      }
                    },
                  ),
                ),

                // SELECT CATEGORY
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: DropdownButton(
                        items: categoriesDropDown,
                        onChanged: changeSelectedCategory,
                        value: _currentCategory,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Brands",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: DropdownButton(
                        items: brandsDropDown,
                        onChanged: changeSelectedBrand,
                        value: _currentBrand,
                      ),
                    ),
                  ],
                ),
                // Quantitiy
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: quantitiyController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Quantitiy",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "You must type a value";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Price",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "You must type a value";
                      }
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: selectedSizes.contains('28'),
                      onChanged: (value) => changeSelectedSize('28'),
                    ),
                    Text("28"),
                    Checkbox(
                      value: selectedSizes.contains('30'),
                      onChanged: (value) => changeSelectedSize('30'),
                    ),
                    Text("30"),
                    Checkbox(
                      value: selectedSizes.contains('32'),
                      onChanged: (value) => changeSelectedSize('32'),
                    ),
                    Text("32"),
                    Checkbox(
                      value: selectedSizes.contains('34'),
                      onChanged: (value) => changeSelectedSize('34'),
                    ),
                    Text("34"),
                    Checkbox(
                      value: selectedSizes.contains('36'),
                      onChanged: (value) => changeSelectedSize('36'),
                    ),
                    Text("36"),
                    Checkbox(
                      value: selectedSizes.contains('38'),
                      onChanged: (value) => changeSelectedSize('38'),
                    ),
                    Text("38"),
                  ],
                ),

                FlatButton(
                  color: Colors.red,
                  textColor: white,
                  onPressed: () {
                    validateAndUpload();
                  },
                  child: Text("Add product"),
                ),
              ],
            ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategory();
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data['category'];
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      brandsDropDown = _getBrandsDropDown();
      _currentBrand = brands[0].data['brand'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() {
      _currentBrand = selectedBrand;
    });
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.add(size);
      });
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() {
          _image1 = tempImg;
        });
        break;
      case 2:
        setState(() {
          _image2 = tempImg;
        });
        break;
      case 3:
        setState(() {
          _image3 = tempImg;
        });
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
        child: Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_image1);
          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);

          final String picture2 =
              "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task2 =
              storage.ref().child(picture2).putFile(_image2);
          StorageTaskSnapshot snapshot2 =
              await task2.onComplete.then((snapshot) => snapshot);

          final String picture3 =
              "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task3 =
              storage.ref().child(picture3).putFile(_image3);
          await task3.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();
            List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];
            _productService.uploadProduct(
                brand: _currentBrand,
                category: _currentCategory,
                productName: productNameController.text,
                price: double.parse(priceController.text),
                sizes: selectedSizes,
                images: imageList,
                quantitiy: int.parse(quantitiyController.text));
            _formKey.currentState.reset();
            setState(() {
              isLoading =false;
            });
            Fluttertoast.showToast(msg: 'Product Added');
            Navigator.pop(context);
          });
        } else {
            setState(() {
              isLoading =false;
            });
          Fluttertoast.showToast(msg: 'Select at least one size');

        }
      } else {
          setState(() {
              isLoading =false;
            });
        Fluttertoast.showToast(
            msg: 'At leas first image field must be provided');
      }
    }
  }
}
