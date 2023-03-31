import 'package:flutter/material.dart';

import '../ViewModel/Utilities/reusableRow.dart';

class DetailScreen extends StatelessWidget {
  String country, cases, recovered, deaths, active, test, todayRecover, critical;
   DetailScreen({Key? key, required this.country, required this.cases, required this.recovered, required this.deaths, required this.active, required this.test, required this.todayRecover, required this.critical}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$country details'),
        backgroundColor: Colors.grey[300],
      ),
      backgroundColor: Colors.grey[300],
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            children: [
          Center(child: Text('Country: $country',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),),
              SizedBox(height: 20,),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity * 0.89,
                  decoration:BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow:[
                        BoxShadow(
                            offset: Offset(5, 5),
                            color: Colors.grey.shade500,
                            blurRadius: 15),
                        BoxShadow(
                            offset: Offset(-5, -5),
                            color: Colors.grey.shade100,
                            blurRadius: 15),
                      ]),
                child: Column(
                  children: [
                    ReusableRow(
                        name: 'Country', number:country ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableRow(
                        name: 'Cases', number:cases ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableRow(
                        name: 'Recovered', number:recovered ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableRow(
                        name: 'Deaths', number:deaths ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableRow(
                        name: 'Active', number:active ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableRow(
                        name: 'Tests', number:test ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableRow(
                        name: 'Total Recover', number:todayRecover ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ReusableRow(
                        name: 'Critical', number:critical ),
                    const Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      height: 5,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
