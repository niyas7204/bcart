import 'dart:convert';
import 'dart:developer';

import 'package:amazone_clone/core/errors/error_handling.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class AdminUrls {
  static const addPrduct = '/api/admin/addProduct';
  static const getProudct = '/api/admin/getProduct';
  static const deleteProudct = '/api/admin/deleteProduct';
  static const getCategories = '/api/admin/getCategory';
  static const createCategory = '/api/admin/createCategory';
}
