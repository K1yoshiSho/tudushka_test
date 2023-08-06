import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

/// `OutlinedTextField` is a custom widget which is used for return custom textfield with custom style.
class OutlinedTextfield extends StatelessWidget {
  // These are the required input parameters for the widget.
  final String hintText;
  final String? labelText;
  final bool? readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? textController;
  final int? maxLines;
  final int? minLines;
  final bool? obsureText;
  final int? maxLength;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final double? radius;

  // Constructor method to initialize the above input parameters.
  const OutlinedTextfield({
    Key? key,
    required this.textController,
    required this.hintText,
    this.readOnly,
    this.onTap,
    this.maxLines,
    this.obsureText,
    this.minLines,
    this.enabled,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.labelText,
    this.maxLength,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.radius,
  }) : super(key: key);

  // This is a FocusNode variable which can be used to control the focus on the text field if needed.
  // (It is currently commented out because it is not being used.)
  // FocusNode focusNode = FocusNode();

  // This method builds and returns the widget tree for the OutlinedTextfield widget.
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // These properties define the basic configuration of the text field.
      readOnly: readOnly ?? false,
      controller: textController,
      onTap: onTap,
      enabled: enabled,
      textAlignVertical: TextAlignVertical.top,
      maxLength: maxLength,
      validator: validator,
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
      autofocus: false,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: (obsureText ?? false) ? 1 : maxLines,
      minLines: minLines,
      onChanged: onChanged,
      obscureText: obsureText ?? false,
      // These properties define the look and feel of the text field.
      decoration: InputDecoration(
        hintText: hintText,
        hintTextDirection: TextDirection.ltr,
        labelText: (labelText != "") ? labelText ?? hintText : null,
        hintStyle: AppTextStyle.bodyMedium400(context).copyWith(
          color: AppColors.gray600,
        ),
        labelStyle: AppTextStyle.bodyMedium400(context).copyWith(
          color: enabled ?? true ? AppColors.abyssColor : AppColors.gray600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: const BorderSide(
            color: AppColors.gray300,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: const BorderSide(
            color: AppColors.gray300,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: const BorderSide(
            color: AppColors.dangerColor,
            width: 1.5,
          ),
        ),
        alignLabelWithHint: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: const BorderSide(
            color: AppColors.dangerColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 16),
          borderSide: BorderSide(
            color: readOnly ?? false ? AppColors.gray300 : AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: enabled ?? true ? Colors.white : const Color(0xfffafafa),
        contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
      ),
      style: AppTextStyle.bodyMedium400(context).copyWith(
        color: enabled ?? true ? AppColors.abyssColor : AppColors.gray800,
      ),
    );
  }
}
