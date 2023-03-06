import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'add_user.dart';

class USerListPage extends StatefulWidget {
  const USerListPage({super.key});

  @override
  State<USerListPage> createState() => _USerListPageState();
}

class _USerListPageState extends State<USerListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Api Demo'),
            backgroundColor: Colors.black,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 15),
                color: Colors.black,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) {
                        return AddEmployee(null);
                      }),
                    )).then(((value) {
                      setState(() {
                        getUser();
                      });
                    }));
                  },
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFFE57734),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          body: FutureBuilder<http.Response>(
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.hasData) {
                return ListView.builder(
                  itemCount: jsonDecode(snapshot.data!.body.toString()).length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return AddEmployee(
                                jsonDecode(snapshot.data!.body.toString())[index]);
                          },
                        )).then(
                              (value) {
                            setState(() {
                              getUser();
                            });
                          },
                        );
                      },
                      child: Card(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (jsonDecode(snapshot.data!.body.toString())[
                                    index]['name'])
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold,
                                    color: Color(0xFFE57734)),
                                  ),
                                  Text(
                                    (jsonDecode(snapshot.data!.body.toString())[
                                    index]['salary'])
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey.shade600),
                                  ),
                                ],

                              ),
                              Row(
                                children: [
                                  // Container(
                                  //   padding: EdgeInsets.only(right: 20),
                                  //   child: InkWell(
                                  //     onTap: () {
                                  //       Navigator.of(context).push(MaterialPageRoute(
                                  //         builder: (context) {
                                  //           return AddEmployee(jsonDecode(snapshot
                                  //               .data!.body
                                  //               .toString())[index]);
                                  //         },
                                  //       )).then(
                                  //         (value) {
                                  //           setState(() {
                                  //             getUser();
                                  //           });
                                  //         },
                                  //       );
                                  //     },
                                  //     child: Icon(Icons.edit),
                                  //   ),
                                  // ),
                                  Container(
                                    padding: EdgeInsets.only(right: 20),
                                    child: InkWell(
                                      onTap: () {
                                        alert(jsonDecode(snapshot.data!.body
                                            .toString())[index]['id']);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: getUser(),
          ),
        ));
  }

  void alert(id) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Delete',
          style: TextStyle(
            color: Color(0xFFE57734)
          ),),
          content: Text('Are you Sure Want To Delete ?',
          style: TextStyle(
            color: Color(0xFFE57734)
          ),),
          actions: [
            TextButton(
                onPressed: ((() async {
                  http.Response res = await deleteUser(id);
                  if (res.statusCode == 200) {
                    setState(() {});
                  }
                  Navigator.of(context).pop();
                }
                )
                ),
                child: Text('Yes',
                style: TextStyle(
                  color: Color(0xFFE57734)
                ),)),
            TextButton(
                onPressed: ((() {
                  Navigator.of(context).pop();
                })),
                child: Text('No',
                style: TextStyle(
                  color: Color(0xFFE57734)
                ),)),
          ],
        );
      }),
    );
  }

  Future<http.Response> getUser() async {
    var res = await http
        .get(Uri.parse('https://630ee64b37925634188319ff.mockapi.io/faculties1'));
    return res;
  }

  Future<http.Response> deleteUser(id) async {
    // print(id);
    var response1 = await http.delete(
        Uri.parse("https://630ee64b37925634188319ff.mockapi.io/faculties1/" + id));
    return response1;
  }
}