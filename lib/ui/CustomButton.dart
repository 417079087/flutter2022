import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final String label;

  CustomButton(this.label) ;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){}, child: Text(label));
  }

}