import 'package:flutter/material.dart';
import 'package:nectar/commons/themedata.dart';

class lineInput extends StatelessWidget {
  final String title;
  final String placeholder;
  final TextInputType? keyboardType;
  final Widget?right;
  final String? Function(String?)? validator;
  final bool obsecuretext;
  final TextEditingController controller;
  const lineInput({super.key, required this.title, required this.placeholder, this.keyboardType, this.right, this.obsecuretext = false, required this.controller, required this.validator });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color:Tcolor.textTittle,
            fontSize:16,
            fontWeight:FontWeight.w600
          ),
        ),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obsecuretext,
          decoration: InputDecoration(
            suffixIcon: right,
            border:UnderlineInputBorder(borderSide:BorderSide(color:Color(0xffE2E2E2)) ),
            enabledBorder:UnderlineInputBorder(borderSide:BorderSide(color:Color(0xffE2E2E2)) ),
            focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color:Color(0xffE2E2E2)) ),
            errorBorder:UnderlineInputBorder(borderSide:BorderSide(color:Color(0xffE2E2E2)) ) ,
            hintText: placeholder,
            errorStyle: const TextStyle(color:Colors.red),
            hintStyle: TextStyle(color:Tcolor.placeholder, fontSize:17),

          ),
          controller: controller,
          validator: validator,
        ),


      ],

    );
  }
}

