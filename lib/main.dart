import 'package:flutter/material.dart';
import 'database_helper.dart';

// Here we are using a global variable. You can use something like
// get_it in a production app.
final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _updateIdController = TextEditingController();
  final TextEditingController _updateNameController = TextEditingController();
  final TextEditingController _updateAgeController = TextEditingController();
  final TextEditingController _deleteIdController = TextEditingController();
  final TextEditingController _queryIdController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _idController.dispose();
    _updateIdController.dispose();
    _updateNameController.dispose();
    _updateAgeController.dispose();
    _deleteIdController.dispose();
    _queryIdController.dispose();
    super.dispose();
  }

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sqflite'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Insert Section
              const Text(
                'Insert New Record',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _insert,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Insert'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Query All Button
              ElevatedButton(
                onPressed: _query,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Query All Rows'),
              ),

              const SizedBox(height: 20),

              // Update Section
              const Text(
                'Update Record',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _updateIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'ID to Update',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _updateNameController,
                      decoration: const InputDecoration(
                        labelText: 'New Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _updateAgeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'New Age',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _update,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Delete Section
              const Text(
                'Delete Record',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _deleteIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'ID to Delete',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _delete,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Divider(thickness: 2),
              const SizedBox(height: 10),

              // Part 2 Functions
              const Text(
                'Part 2 Functions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),

              // Query by ID Section
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _queryIdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'ID to Query',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _queryById,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('Query by ID'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Delete All Button
              ElevatedButton(
                onPressed: _deleteAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Delete All Records'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    if (_nameController.text.isEmpty || _ageController.text.isEmpty) {
      debugPrint('Error: Name and Age fields cannot be empty');
      return;
    }

    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: _nameController.text,
      DatabaseHelper.columnAge: int.parse(_ageController.text)
    };
    final id = await dbHelper.insert(row);
    debugPrint('inserted row id: $id');

    // Clear the text fields after insert
    _nameController.clear();
    _ageController.clear();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  void _update() async {
    if (_updateIdController.text.isEmpty ||
        _updateNameController.text.isEmpty ||
        _updateAgeController.text.isEmpty) {
      debugPrint('Error: All update fields must be filled');
      return;
    }

    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: int.parse(_updateIdController.text),
      DatabaseHelper.columnName: _updateNameController.text,
      DatabaseHelper.columnAge: int.parse(_updateAgeController.text)
    };
    final rowsAffected = await dbHelper.update(row);
    debugPrint('updated $rowsAffected row(s)');

    // Clear the text fields after update
    _updateIdController.clear();
    _updateNameController.clear();
    _updateAgeController.clear();
  }

  void _delete() async {
    if (_deleteIdController.text.isEmpty) {
      debugPrint('Error: ID field cannot be empty');
      return;
    }

    final id = int.parse(_deleteIdController.text);
    final rowsDeleted = await dbHelper.delete(id);
    debugPrint('deleted $rowsDeleted row(s): row $id');

    // Clear the text field after delete
    _deleteIdController.clear();
  }

  // Part 2 Functions

  void _queryById() async {
    if (_queryIdController.text.isEmpty) {
      debugPrint('Error: ID field cannot be empty');
      return;
    }

    final id = int.parse(_queryIdController.text);
    final row = await dbHelper.queryById(id);
    if (row != null) {
      debugPrint('query by ID ($id): $row');
    } else {
      debugPrint('No row found with ID $id');
    }

    // Clear the text field after query
    _queryIdController.clear();
  }

  void _deleteAll() async {
    final rowsDeleted = await dbHelper.deleteAll();
    debugPrint('deleted all $rowsDeleted row(s)');
  }
}