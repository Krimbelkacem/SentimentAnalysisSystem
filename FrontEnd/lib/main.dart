import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Recommender',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  List<String> searchResults = []; // Changed to a list of strings
  final String serverUrl = 'http://127.0.0.1:5000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Recommender'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.grey[100],
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search for movies...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      final query = _searchController.text;
                      print('Sending request with query: $query');
                      final response = await performSearch(query);
                      print('Received response: $response');

                      setState(() {
                        searchResults = response;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Text(
                      'Recommendations:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            searchResults[index],
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> performSearch(String query) async {
    final response = await http.post(
      Uri.parse('$serverUrl/recommend'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer YourAccessToken', // Add your custom header here
      },
      body: jsonEncode({'query': query}),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<String> results = List<String>.from(jsonResponse);
      return results;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
