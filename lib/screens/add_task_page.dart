import 'package:flutter/material.dart';
import 'package:simple_todo_app/database/database_helper.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _status = 'Todo';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Todo App', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 150, // Set a fixed width for the dropdown container
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _status,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        setState(() {
                          _status = newValue!;
                        });
                      },
                      items: <String>['Todo', 'In progress', 'Done', 'Bug']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: _getStatusColor(value),
                                size: 19,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                // Added Flexible widget
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold), // Bold text
                                  overflow: TextOverflow
                                      .ellipsis, // Ensure no overflow
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      selectedItemBuilder: (BuildContext context) {
                        return <String>['Todo', 'In progress', 'Done', 'Bug']
                            .map<Widget>((String value) {
                          return Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: _getStatusColor(_status),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Status',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold), // Bold text
                              ),
                            ],
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nouvelle tache',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(12.0)), // Rounded edges
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(12.0)), // Rounded edges
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper().insertTask({
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'status': _status,
                  });
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Changed to black background
                  minimumSize: const Size(150, 50),
                ),
                child: const Text('Ajouter',
                    style: TextStyle(
                        fontSize: 18, color: Colors.white)), // White text
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.black, // Changed to black
        child: const Icon(Icons.close, color: Colors.white), // White close icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In progress':
        return Colors.blue;
      case 'Done':
        return Colors.green;
      case 'Bug':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
