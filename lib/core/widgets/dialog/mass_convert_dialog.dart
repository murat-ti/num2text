import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:num2text/core/extension/context_extension.dart';
import 'package:num2text/core/extension/string_extension.dart';
import 'package:num2text/view/_features/enums/separator_type.dart';
import '../../init/lang/locale_keys.g.dart';

class MassConvertDialog extends StatefulWidget {
  final List<SeparatorType> data;
  final SeparatorType selectedData;
  final ValueChanged<SeparatorType> onSelectedDataChanged;

  const MassConvertDialog({
    Key? key,
    required this.data,
    required this.selectedData,
    required this.onSelectedDataChanged,
  }) : super(key: key);

  @override
  MassConvertDialogState createState() => MassConvertDialogState();
}

class MassConvertDialogState extends State<MassConvertDialog> {
  late SeparatorType _tempSelected;

  @override
  void initState() {
    _tempSelected = widget.selectedData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: <Widget>[
            SizedBox(
              width: context.width,
              //padding: context.verticalPaddingNormal,
              child: Text(
                LocaleKeys.mass_convert_title,
                style: context.appTheme.textTheme.headline6,
                textAlign: TextAlign.center,
              ).tr(),
            ),
            Container(
              width: context.width,
              padding: context.paddingNormal,
              child: Text(
                LocaleKeys.mass_convert_separator_character,
                style: context.appTheme.textTheme.bodyText1,
                textAlign: TextAlign.left,
              ).tr(),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                      title: Text(widget.data[index].rawValue.capitalize()),
                      subtitle: Text(widget.data[index].hintValue),
                      value: (_tempSelected == widget.data[index]),
                      onChanged: (bool? value) {
                        if (value != null) {
                          if (_tempSelected != widget.data[index]) {
                            setState(() {
                              _tempSelected = widget.data[index];
                            });
                          }
                        } else {
                          if (_tempSelected == widget.data[index]) {
                            setState(() {
                              _tempSelected = widget.selectedData;
                            });
                          }
                        }
                      });
                }),
            SizedBox(
              width: context.width,
              child: MaterialButton(
                onPressed: () async {
                  if (_tempSelected is SeparatorType) {
                    widget.onSelectedDataChanged(_tempSelected);
                    Navigator.pop(context);
                  }
                },
                color: const Color(0xFFfab82b),
                child: const Text(
                  LocaleKeys.paste_from_clipboard,
                  style: TextStyle(color: Colors.white),
                ).tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
