import 'package:flutter/material.dart';
import 'package:tudushka/src/common/components/forked/custom_dropdown/src/dropdown_button.dart';
import 'package:tudushka/src/theme/app_colors.dart';

/// `CustomDropDown` is a custom dropdown button that can be used to select a single value from a set of options.
class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    this.initialOption,
    this.hintText,
    required this.options,
    this.optionLabels,
    required this.onChanged,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    required this.textStyle,
    required this.elevation,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.margin,
    this.hidesUnderline = false,
    this.disabled = false,
    this.onTap,
    this.disabledText,
    this.disabledTextStyle,
    this.dropDownValue,
    this.validator,
    this.focusNode,
    this.suffixIcon,
  }) : super(key: key);

  final T? initialOption;
  final String? hintText;
  final String? disabledText;
  final List<T> options;
  final List<String>? optionLabels;
  final Function(T?) onChanged;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? fillColor;
  final TextStyle textStyle;
  final TextStyle? disabledTextStyle;
  final Function()? onTap;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final String? Function(T?)? validator;
  final Color borderColor;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;
  final bool disabled;
  final T? dropDownValue;
  final FocusNode? focusNode;
  final Widget? suffixIcon;

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = DropdownButtonFormField2<T>(
        value: widget.options.contains(widget.dropDownValue) ? widget.dropDownValue : null,
        focusNode: widget.focusNode,
        validator: widget.validator,
        items: widget.options
            .asMap()
            .entries
            .map(
              (option) => DropdownMenuItem<T>(
                value: option.value,
                child: Text(
                  widget.optionLabels == null || widget.optionLabels!.length < option.key + 1
                      ? option.value.toString()
                      : widget.optionLabels![option.key],
                  style: widget.textStyle,
                ),
              ),
            )
            .toList(),
        style: const TextStyle(overflow: TextOverflow.clip),
        customButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.dropDownValue != null ? widget.dropDownValue.toString() : "",
                style: widget.disabled ? widget.disabledTextStyle ?? widget.textStyle : widget.textStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            widget.suffixIcon ??
                const Icon(
                  Icons.expand_more_rounded,
                  color: AppColors.gray800,
                  size: 18,
                ),
          ],
        ),
        dropdownStyleData: DropdownStyleData(
          elevation: widget.elevation.toInt(),
          width: widget.width,
          direction: DropdownDirection.center,
          decoration: BoxDecoration(
            color: widget.disabled ? AppColors.gray300 : widget.fillColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: List.generate(
            widget.options.length,
            (index) => 45,
          ),
          overlayColor: MaterialStateProperty.all(AppColors.splashColor),
        ),
        onChanged: !widget.disabled
            ? (value) {
                widget.onChanged(value);
              }
            : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          hintText: widget.hintText,
          labelText: widget.hintText,
          filled: true,
          fillColor: widget.disabled ? const Color(0xfffafafa) : widget.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.gray300,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.dangerColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.gray300,
              width: 1.5,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.gray300,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.dangerColor, width: 1.5),
          ),
          labelStyle: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            overflow: TextOverflow.fade,
            color: widget.disabled ? AppColors.gray800 : AppColors.abyssColor,
          ),
          hintStyle: const TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.grayText,
          ),
        ),
        isExpanded: true);

    return SizedBox(
      width: widget.width,
      child: dropdownWidget,
    );
  }
}
