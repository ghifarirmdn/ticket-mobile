import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.obscureText,
    this.maxLines,
    this.textInputAction,
    this.autoFocus,
    this.keyboardType,
    this.readOnly,
    this.onFieldSubmitted,
    this.errorText,
    this.error,
    this.contentPadding,
    this.onChanged,
    this.enabled = true,
  });
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? obscureText;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final bool? autoFocus;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function(String)? onFieldSubmitted;
  final String? errorText;
  final Widget? error;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onChanged;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText ?? false,
      autofocus: autoFocus ?? false,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      textInputAction: textInputAction,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
          ),
      decoration: InputDecoration(
        error: errorText != null
            ? Container(
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      errorText!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        filled: true,
        enabled: enabled!,
        fillColor: Colors.transparent,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black12,
              fontWeight: FontWeight.w600,
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
