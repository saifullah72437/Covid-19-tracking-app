import 'dart:convert';

import 'package:covid_19_app/Screens/detailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/CountriesModel.dart';
import 'package:http/http.dart' as http;
class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController searchController = TextEditingController();
  Future<List<dynamic>> getCourntriesDetail() async{
    var data;
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if(response.statusCode == 200){
     data = jsonDecode(response.body);
    return data;
    }
else{
  throw Exception('Something Went Wrong');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],

        title: Text('All Countries'),
      ),
      body: SafeArea(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 20.0,),
            Container(

              decoration:BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
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
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(

                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),

                  hintText: 'Search with country name',
                  suffixIcon: searchController.text.isEmpty ? const Icon(Icons.search) :
                  GestureDetector(
                      onTap: (){
                        searchController.text = "" ;
                        setState(() {
                        });
                      },
                      child: Icon(Icons.clear)),

                ),
                onChanged: (value){
                  setState(() {

                  });
                },
              ),
            ),
            SizedBox(height: 20.0,),
            Expanded(
              child: FutureBuilder(
                  future: getCourntriesDetail(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index){
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Column(
                              children: [
                                ListTile(
                                  leading:  Container(height: 50 , width: 50, color: Colors.white,),
                                  title:  Container(
                                    width: 100,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                  subtitle:  Container(
                                    width: double.infinity,
                                    height: 8.0,
                                    color: Colors.white,
                                  ),
                                ),

                              ],
                            ),
                          );
                        },

                      );
                    }else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'];

                            if(searchController.text.isEmpty){
                               return  InkWell(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                       country: snapshot.data![index]['country'].toString(),
                                       cases: snapshot.data![index]['cases'].toString(),
                                       recovered: snapshot.data![index]['recovered'].toString(),
                                       deaths: snapshot.data![index]['deaths'].toString(),
                                       active: snapshot.data![index]['active'].toString(),
                                       test: snapshot.data![index]['tests'].toString(),
                                       todayRecover: snapshot.data![index]['todayRecovered'].toString(),
                                       critical: snapshot.data![index]['critical'].toString())));
                                 },
                                 child: Container(
                                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                   decoration:BoxDecoration(
                                     borderRadius: BorderRadius.circular(8),
                                       color: Colors.grey[300],
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
                                   child: ListTile(

                                     leading: CircleAvatar(backgroundColor: Colors.blue, ),
                                     title: Text(snapshot.data![index]['country']),
                                     subtitle: Text('Total Cases: ${snapshot.data![index]['cases']}'),
                                   ),
                                 ),
                               );
                             }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                               return Column(
                                 children: [
                                   InkWell(
                                   onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                     country: snapshot.data![index]['country'].toString(),
                                     cases: snapshot.data![index]['cases'].toString(),
                                     recovered: snapshot.data![index]['recovered'].toString(),
                                     deaths: snapshot.data![index]['deaths'].toString(),
                                     active: snapshot.data![index]['active'].toString(),
                                     test: snapshot.data![index]['tests'].toString(),
                                     todayRecover: snapshot.data![index]['todayRecovered'].toString(),
                                     critical: snapshot.data![index]['critical'].toString())));
                               },
                                     child: Container(
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
                                       child: ListTile(
                                         leading: CircleAvatar(backgroundColor: Colors.blue, ),
                                         title: Text(snapshot.data![index]['country']) ,
                                         subtitle:  Text("Effected: "+ snapshot.data![index]['cases'].toString()) ,
                                       ),
                                     ),
                                   ),
                                 ],
                               );
                             }else{
                              return Container();
                            }
                          });
                    }
                  }),
            ),
          ],
        ),
      ),),
    );
  }
}
