import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  String name, number;
   ReusableRow({Key? key, required this.name, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style:const TextStyle(color: Colors.black87, fontSize: 16,),),
        Text(number, style: const TextStyle(color: Colors.black87, fontSize: 16,),),
      ],
    );
  }
}
