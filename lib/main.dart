import 'package:flutter/material.dart';
import 'dbconnection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MySQL Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBConnection dbConnection = DBConnection();
  List<Map<String, dynamic>> seniorInfo = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSeniorInfo();
  }

  void fetchSeniorInfo() async {
    try {
      var data = await dbConnection.getSeniorInfo();
      setState(() {
        seniorInfo = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Senior Info'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : seniorInfo.isEmpty
          ? Center(
        child: Text(
          'No data found',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: seniorInfo.length,
        itemBuilder: (context, index) {
          var item = seniorInfo[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${item['fname']} ${item['lname']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Senior ID: ${item['seniorid']}'),
                  Text('Status: ${item['status']}'),
                  Text('SUID: ${item['suid']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
