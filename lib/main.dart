import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Gunung Merapi di Indonesia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VolcanoListPage(),
    );
  }
}

class VolcanoListPage extends StatefulWidget {
  @override
  _VolcanoListPageState createState() => _VolcanoListPageState();
}

class _VolcanoListPageState extends State<VolcanoListPage> {
  List<dynamic> volcanoList = [];

  @override
  void initState() {
    super.initState();
    fetchVolcanoData();
  }

  Future<void> fetchVolcanoData() async {
    final response =
        await http.get(Uri.parse('https://indonesia-public-static-api.vercel.app/api/volcanoes'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data is List) {
        setState(() {
          volcanoList = data;
        });
      }
    } else {
      print('Failed to fetch volcano data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Gunung Merapi di Indonesia'),
      ),
      body: ListView.builder(
        itemCount: volcanoList.length,
        itemBuilder: (context, index) {
          final volcano = volcanoList[index];
          return ListTile(
            title: Text(volcano['nama'] ?? ''),
            subtitle: Text(volcano['tinggi_meter'] ?? ''),
            trailing: Text(volcano['geolokasi'] ?? ''),
          );
        },
      ),
    );
  }
}