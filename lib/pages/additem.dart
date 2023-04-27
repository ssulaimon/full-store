// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fullstore/cloudfunctions/uploadimage.dart';
import 'package:fullstore/cloudfunctions/uploaditem.dart';
import 'package:fullstore/models/itemmodel.dart';
import 'package:fullstore/providers/addproductsate.dart';
import 'package:fullstore/providers/pickedimagestate.dart';
import 'package:fullstore/providers/uploadingitem.dart';

import 'package:fullstore/utils/colors.dart';
import 'package:fullstore/widgets/admintextform.dart';
import 'package:fullstore/widgets/customsnackbar.dart';
import 'package:fullstore/widgets/dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddNewProduct extends StatelessWidget {
  AddNewProduct({super.key});
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController productIngredients = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _key,
        child:
            Consumer<UploadingItemLoading>(builder: (context, loading, child) {
          return ListView(
            children: [
              Container(
                margin: EdgeInsets.only(right: width * 0.5),
                padding: EdgeInsets.only(
                  right: width * 0.07,
                  left: width * 0.03,
                  top: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    gradient: LinearGradient(
                        colors: [
                          MyColors.lightBlue,
                          MyColors.primaryColor,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Text(
                  'Add New Item To Resturant',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.primaryColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                  height: height * 0.8,
                  width: width * 0.5,
                  child: ListView(
                    children: [
                      Consumer<PickImageStae>(
                          builder: (context, pickedImage, child) {
                        return Center(
                          child: SizedBox(
                            width: width * 0.15,
                            height: height * 0.15,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () async {
                                  String? image =
                                      await pickImage(context: context);
                                  pickedImage.imagePath = image;
                                },
                                child: DottedBorder(
                                  strokeWidth: 1,
                                  child: pickedImage.imagePath == null
                                      ? const Center(
                                          child: Icon(Icons.upload),
                                        )
                                      : Center(
                                          child: Image.network(
                                            pickedImage.imagePath!,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.22,
                            child: AdninTextForm(
                              label: 'Product Name',
                              validator: (value) => validator(
                                  name: 'Product Name ', value: value!),
                              hint: 'Product Name',
                              controller: productName,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          SizedBox(
                            width: width * 0.22,
                            child: AdninTextForm(
                              label: 'Product Price',
                              validator: (value) =>
                                  validator(name: 'Price', value: value!),
                              hint: 'Product Price',
                              controller: productPrice,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.22,
                            child: AdninTextForm(
                              maxLine: 4,
                              label: 'Product Description',
                              validator: (value) =>
                                  validator(name: 'Description', value: value!),
                              hint: 'Product Description',
                              controller: productDetails,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          SizedBox(
                              width: width * 0.22,
                              child: Consumer<DropDownItems>(
                                  builder: (context, dropDown, child) {
                                return CustomDropDown(
                                  validator: (value) => validator(
                                      name: 'Category', value: value!),
                                  labeltext: 'Category',
                                  hint: 'Please Choose Product Category',
                                  onchanged: (value) {
                                    dropDown.selectedValue = value;
                                  },
                                  items: dropDown.items,
                                );
                              })),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.22,
                            child: AdninTextForm(
                              label: 'Ingredients',
                              maxLine: 2,
                              validator: (value) =>
                                  validator(name: 'Ingredients', value: value!),
                              hint: 'Ingredeints',
                              controller: productIngredients,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => addProduct(
                                price: productPrice.text,
                                category: Provider.of<DropDownItems>(context,
                                        listen: false)
                                    .selectedValue!,
                                name: productName.text,
                                ingredients: productIngredients.text,
                                description: productDetails.text,
                                key: _key,
                                context: context,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: MyColors.lightBlue,
                                ),
                                width: width * 0.22,
                                child: Text(
                                  'Add Product',
                                  style: TextStyle(color: MyColors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      loading.isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyColors.primaryColor,
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

validator({
  required String name,
  required String value,
}) {
  if (value.isEmpty) {
    return '$name cannot be empty';
  } else {
    return null;
  }
}

void addProduct({
  required GlobalKey<FormState> key,
  required BuildContext context,
  required String name,
  required String price,
  required String description,
  required String ingredients,
  required String category,
}) async {
  if (key.currentState!.validate() &&
      Provider.of<PickImageStae>(context, listen: false).pickedFile != null) {
    Provider.of<UploadingItemLoading>(context, listen: false).isLoading = true;
    String image = await UploadImage.uploadImage(
      image: Provider.of<PickImageStae>(context, listen: false).pickedFile!,
      category: category,
      itemName: name,
    );
    ItemModel itemModel = ItemModel(
      category: category,
      description: description,
      image: image,
      ingredients: ingredients,
      name: name,
      price: price,
    );
    await UploadItem.uploadItem(itemModel: itemModel);
    Provider.of<UploadingItemLoading>(context, listen: false).isLoading = false;
    ScaffoldMessenger.of(context)
        .showSnackBar(customSnackBar(message: 'Item Uploaded'));
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(customSnackBar(message: 'Please Select Item Image'));
  }
}

Future<String?> pickImage({
  required BuildContext context,
}) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? xFile = await imagePicker.pickImage(
    source: ImageSource.gallery,
  );
  if (xFile != null) {
    Provider.of<PickImageStae>(context, listen: false).pickedFile =
        await xFile.readAsBytes();
    return xFile.path;
  } else {
    return null;
  }
}
