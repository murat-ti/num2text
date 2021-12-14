import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/extension/context_extension.dart';

Future<dynamic> modalBottomSheet(dynamic viewModel, BuildContext context, double height, String? caption, int count,
    IndexedWidgetBuilder itemBuilder) {
  return showModalBottomSheet(
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: context.normalRadius,
      ),
    ),
    context: context,
    builder: (context) {
      return buildList(
        viewModel,
        context,
        height,
        caption,
        count,
        itemBuilder,
      );
    },
  );
}

Widget buildList(dynamic viewModel, BuildContext context, double height, String? caption, int count,
    IndexedWidgetBuilder itemBuilder) {
  return SizedBox(
    height: height,
    child: Column(
      children: [
        (caption != null)
            ? Padding(
                padding: context.verticalPaddingNormal,
                child: Text(
                  caption,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headline6!
                      .copyWith(color: context.colorScheme.primary, fontSize: context.fontNormalSize),
                ).tr(),
              )
            : const SizedBox(),
        Expanded(
          child: ListView.builder(
            //controller: scrollController,
            itemCount: count,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    ),
  );
}

Widget buildBottomSheetItem(
    dynamic viewModel, BuildContext context, int index, String title, VoidCallback? onTap, bool isChecked) {
  return Column(
    children: [
      ListTile(
        title: Text(
          title,
          style: context.textTheme.subtitle1!.copyWith(color: context.colorScheme.primary),
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: context.normalValue * 2),
        dense: true,
        trailing: isChecked ? const Icon(Icons.check) : null,
      ),
      const Divider(height: 1)
    ],
  );
}
