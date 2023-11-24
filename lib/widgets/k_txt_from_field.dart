
import 'package:flutter/material.dart';


Widget kTextFormField({
  required final String hintText,
  required final bool obscureText,
  // required final String errorText,
  required final Color color,
  required final void Function(String)? onChanged,
  required final String? Function(String?) validator,
}) {
  return TextFormField(
    onChanged: onChanged,
    validator: validator,
    obscureText: obscureText,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color:  Colors.red),
      ),
      // errorText: errorText,
      hintText: hintText,
    ),
  );
}