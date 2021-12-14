import 'package:flutter/material.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/constants/app/app_constants.dart';

abstract class SnackBarHelper {
  void showSnackMessage(GlobalKey<ScaffoldMessengerState>? scaffoldKey, String text) {
    if (scaffoldKey == null) return;

    scaffoldKey.currentState?.showSnackBar(SnackBar(
      content: Text(
        text,
        style: scaffoldKey.currentState!.context.textTheme.subtitle2!
            .copyWith(color: scaffoldKey.currentState!.context.colorScheme.primaryVariant),
      ),
      duration: const Duration(seconds: ApplicationConstants.snackbarDuration),
      backgroundColor: scaffoldKey.currentState!.context.colorScheme.primary,
    ));
  }
}