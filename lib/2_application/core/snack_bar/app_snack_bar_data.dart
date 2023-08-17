import 'package:traffeye_sg_flutter/1_domain/failures/failures.dart';

class AppSnackBarData {
  final String title;
  final String message;

  const AppSnackBarData({required this.title, required this.message});

  factory AppSnackBarData.fromFailure(Failure failure) {
    switch (failure) {
      case ConnectionFailure():
        return const AppSnackBarData(
          title: 'Connection Error',
          message: 'Please check your internet connection',
        );
      case GeneralFailure():
        return const AppSnackBarData(
          title: 'Unknown Error',
          message: 'An unknown error has occurred',
        );
    }
  }
}