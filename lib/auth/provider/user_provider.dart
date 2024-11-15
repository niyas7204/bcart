import 'dart:developer';

import 'package:amazone_clone/auth/model/user_model.dart';
import 'package:amazone_clone/auth/services/auth_service.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:amazone_clone/core/state.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  StateHandler<User> user = StateHandler.initial();
  StateHandler<User> get userSate => user;
  set setUser(StateHandler<User> newUser) {
    user = newUser;
    notifyListeners();
  }

  void userLogin(
      {required String email,
      required String name,
      required String password}) async {
    setUser = StateHandler.loading();

    notifyListeners();
    if (password.length < 6) {
      setUser = StateHandler.error("password must be at least 6 characters");
    } else {
      final result = await AuthService.userSignUp(
          email: email, name: name, password: password);

      result.fold(
        (l) {
          setUser = StateHandler.error(l.errorMessage);
        },
        (r) {
          setUser = StateHandler.success(r);
        },
      );
    }
  }

  void userSignin({required String email, required String password}) async {
    setUser = StateHandler.loading();
    final result =
        await AuthService.userSignIn(email: email, password: password);
    result.fold(
      (l) {
        setUser = StateHandler.error(l.errorMessage);
      },
      (r) {
        setUser = StateHandler.success(r);
      },
    );
  }
}
