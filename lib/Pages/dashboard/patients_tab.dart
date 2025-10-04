import 'package:flutter/material.dart';
import '../models/patient_model.dart';

class PatientsTab extends StatefulWidget {
  final List<Patient> patients;
  final Function(String) onToggleFlag;
  final Function(Patient) onSendEmail;

  const PatientsTab({
    super.key,
    required this.patients,
    required this.onToggleFlag,
    required this.onSendEmail,
  });

  @override
  State<PatientsTab> createState() => _PatientsTabState();
}

class _PatientsTabState extends State<PatientsTab> {
  final TextEditingController _searchController = TextEditingController();
  List<Patient> _filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _filteredPatients = widget.patients;
    _searchController.addListener(_filterPatients);
  }

  void _filterPatients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPatients = widget.patients.where((patient) {
        return patient.name.toLowerCase().contains(query) ||
            patient.disease.toLowerCase().contains(query) ||
            patient.location.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search patients...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredPatients.length,
            itemBuilder: (context, index) {
              final patient = _filteredPatients[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getConditionColor(patient.condition),
                    child: Text(
                      patient.name.split(' ').map((n) => n[0]).join(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(patient.name),
                  subtitle: Text('${patient.disease} • ${patient.location}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          patient.flagged ? Icons.flag : Icons.outlined_flag,
                          color: patient.flagged ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => widget.onToggleFlag(patient.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.email),
                        onPressed: () => widget.onSendEmail(patient),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getConditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'stable':
        return Colors.orange;
      case 'recovered':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}