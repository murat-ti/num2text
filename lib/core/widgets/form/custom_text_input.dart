import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/extension/context_extension.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController? controller;

  //final String? initialValue;
  final TextInputType? keyboardType;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final dynamic maxLines;
  final bool? enabled;

  const CustomTextInput({
    Key? key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.onChanged,
    this.onTap,
    this.suffixIcon,
    required this.maxLines,
    this.enabled,
    //this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      //initialValue: controller != null ? controller!.text : (initialValue ?? ''),
      maxLines: maxLines ?? null,
      enabled: enabled ?? true,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: (enabled == null || enabled == true) ? Colors.transparent : Colors.black12,
        hintText: hintText ?? '',
        suffixIcon: suffixIcon,
        //labelText: LocaleKeys.add_contact_business_name.tr(),
        contentPadding: context.paddingNormal,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.primary.withOpacity(0.5)),
          borderRadius: context.borderRadiusCircularNormal,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.primary.withOpacity(0.5)),
          borderRadius: context.borderRadiusCircularNormal,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.primary.withOpacity(0.5)),
          borderRadius: context.borderRadiusCircularNormal,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.primary.withOpacity(0.5)),
          borderRadius: context.borderRadiusCircularNormal,
        ),
      ),
      inputFormatters: inputFormatters ?? [],
      validator: validator,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      //style: TextStyle(color: context.colorScheme.primary),
      style: context.textTheme.headline6,
    );
  }
}
