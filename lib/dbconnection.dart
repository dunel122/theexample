import 'package:mysql1/mysql1.dart';

class DBConnection {
  // Database configuration
  final String host = '192.168.0.31'; // Replace with your server IP or localhost for testing
  final int port = 3306;              // MySQL default port
  final String user = 'test';         // Replace with your MySQL username
  final String password = '123';      // Replace with your MySQL password
  final String dbName = 'senior';     // Your database name

  Future<MySqlConnection> connect() async {
    // Establish the connection
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: dbName,
    );

    MySqlConnection conn = await MySqlConnection.connect(settings);
    print('Connected to database');
    return conn;
  }

  // Example function to fetch all data from 'seniorinfo'
  Future<List<Map<String, dynamic>>> getSeniorInfo() async {
    var conn = await connect();
    var results = await conn.query('SELECT * FROM seniorinfo');

    // Map the results to a list of maps for easy use in your UI
    var data = results
        .map((row) => {
      'fname': row['fname'],
      'lname': row['lname'],
      'seniorid': row['seniorid'],
      'status': row['status'],
      'suid': row['suid'],
    })
        .toList();

    await conn.close();
    return data;
  }
}
