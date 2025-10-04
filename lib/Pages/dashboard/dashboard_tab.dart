import 'package:flutter/material.dart';
import '../models/patient_model.dart';
import '../models/story_model.dart';
import 'health_updates_manager.dart';

class DashboardTab extends StatelessWidget {
  final List<Patient> patients;
  final List<HealthStory> stories;
  final Function(List<HealthStory>) onStoriesUpdated;

  const DashboardTab({
    super.key,
    required this.patients,
    required this.stories,
    required this.onStoriesUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeSection(),
          const SizedBox(height: 20),
          _buildQuickStats(),
          const SizedBox(height: 20),
          HealthUpdatesManager(
            stories: stories,
            onStoriesUpdated: onStoriesUpdated,
          ),
          const SizedBox(height: 20),
          _buildRecentRequests(),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.medical_services, color: Colors.blue, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Dr. Smith',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${patients.length} patients need attention',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    final totalCases = patients.length;
    final critical = patients.where((p) => p.condition == 'Critical').length;
    final recovered = patients.where((p) => p.condition == 'Recovered').length;
    final deaths = 3; // This would come from your data

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Overview',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildStatCard('Total Cases', totalCases.toString(), Colors.blue, Icons.people),
            _buildStatCard('Critical', critical.toString(), Colors.orange, Icons.warning),
            _buildStatCard('Deaths', deaths.toString(), Colors.red, Icons.heart_broken),
            _buildStatCard('Recovered', recovered.toString(), Colors.green, Icons.health_and_safety),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Patient Requests',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...patients.take(3).map((patient) => _buildPatientRequestCard(patient)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientRequestCard(Patient patient) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getConditionColor(patient.condition),
          child: Text(
            patient.name.split(' ').map((n) => n[0]).join(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(patient.name),
        subtitle: Text('${patient.disease} • ${patient.condition}'),
        trailing: patient.flagged
            ? const Icon(Icons.flag, color: Colors.red)
            : null,
      ),
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
}