/* 
  RxTypes from the GETx library
  9/1/2024


  Author: Amgad Fahd
  
*/


import 'package:appwrite/models.dart';
import 'package:get/get.dart';

late Rx<User>? yaUser;

// store the user token - for global use 
final RxString userToken = ''.obs;