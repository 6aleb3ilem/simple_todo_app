import 'package:flutter/material.dart';

class TaskFilter extends StatefulWidget {
  final Map<String, bool> initialFilters;
  final Function(Map<String, bool>) onFilterChanged;

  const TaskFilter({
    super.key,
    required this.initialFilters,
    required this.onFilterChanged,
  });

  @override
  _TaskFilterState createState() => _TaskFilterState();
}

class _TaskFilterState extends State<TaskFilter> {
  late Map<String, bool> _filters;

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.initialFilters);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter par'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _filters.keys.map((status) {
            return CheckboxListTile(
              title: Text(status,
                  style: TextStyle(color: _getStatusColor(status))),
              value: _filters[status],
              onChanged: (bool? value) {
                setState(() {
                  _filters[status] = value!;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onFilterChanged(_filters);
            Navigator.of(context).pop();
          },
          child: const Text('Appliquer'),
        ),
      ],
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
