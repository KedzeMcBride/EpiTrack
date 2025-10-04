import 'package:flutter/material.dart';
import 'dashboard/dashboard_tab.dart';
import 'dashboard/patients_tab.dart';
import 'dashboard/analytics_tab.dart';
import 'dashboard/map_tab.dart';
import 'models/patient_model.dart';
import 'models/story_model.dart';
import 'models/disease_stats_model.dart';

class HealthPersonnelPage extends StatefulWidget {
  const HealthPersonnelPage({super.key});

  @override
  State<HealthPersonnelPage> createState() => _HealthPersonnelPageState();
}

class _HealthPersonnelPageState extends State<HealthPersonnelPage> {
  int _currentIndex = 0;

  final List<Patient> _patients = [
    Patient(
      id: '1',
      name: 'John Doe',
      condition: 'Critical',
      disease: 'Malaria',
      location: 'New York',
      date: '2024-01-15',
      email: 'john.doe@email.com',
      flagged: false,
    ),
    Patient(
      id: '2',
      name: 'Jane Smith',
      condition: 'Stable',
      disease: 'COVID-19',
      location: 'Los Angeles',
      date: '2024-01-14',
      email: 'jane.smith@email.com',
      flagged: true,
    ),
    Patient(
      id: '3',
      name: 'Mike Johnson',
      condition: 'Recovered',
      disease: 'Cholera',
      location: 'Chicago',
      date: '2024-01-13',
      email: 'mike.j@email.com',
      flagged: false,
    ),
    Patient(
      id: '4',
      name: 'Sarah Wilson',
      condition: 'Critical',
      disease: 'Malaria',
      location: 'Miami',
      date: '2024-01-16',
      email: 'sarah.w@email.com',
      flagged: true,
    ),
    Patient(
      id: '5',
      name: 'David Brown',
      condition: 'Stable',
      disease: 'Measles',
      location: 'Seattle',
      date: '2024-01-12',
      email: 'david.b@email.com',
      flagged: false,
    ),
  ];

  List<HealthStory> _stories = [
    HealthStory(
      id: '1',
      title: 'Malaria Outbreak',
      description: 'Rising cases in urban areas. Stay protected with mosquito nets.',
      image: 'lib/images/logo.png',
      date: '2h ago',
      imageUrl: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?w=400&h=200&fit=crop',
    ),
    HealthStory(
      id: '2',
      title: 'Vaccination Drive',
      description: 'Free vaccines available at all health centers this weekend.',
      image: 'lib/images/logo.png',
      date: '1d ago',
      imageUrl: 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=200&fit=crop',
    ),
    HealthStory(
      id: '3',
      title: 'Health Advisory',
      description: 'New safety guidelines issued by health department for public places.',
      image: 'lib/images/logo.png',
      date: '3d ago',
      imageUrl: 'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?w=400&h=200&fit=crop',
    ),
    HealthStory(
      id: '4',
      title: 'Clean Water Initiative',
      description: 'New water purification systems installed in affected areas.',
      image: 'lib/images/logo.png',
      date: '5d ago',
      // No imageUrl - will use default image
    ),
  ];

  final List<DiseaseStats> _stats = [
    DiseaseStats(disease: 'Malaria', cases: 45, deaths: 2, critical: 8, recovered: 35),
    DiseaseStats(disease: 'COVID-19', cases: 23, deaths: 1, critical: 3, recovered: 19),
    DiseaseStats(disease: 'Cholera', cases: 12, deaths: 0, critical: 2, recovered: 10),
    DiseaseStats(disease: 'Measles', cases: 8, deaths: 0, critical: 1, recovered: 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Health Personnel Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: _showNotifications,
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: _showProfile,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _getCurrentPage(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _getCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return DashboardTab(
          patients: _patients,
          stories: _stories,
          onStoriesUpdated: _updateStories,
        );
      case 1:
        return PatientsTab(
          patients: _patients,
          onToggleFlag: _toggleFlag,
          onSendEmail: _sendEmail,
        );
      case 2:
        return AnalyticsTab(stats: _stats);
      case 3:
        return MapTab(stats: _stats);
      default:
        return DashboardTab(
          patients: _patients,
          stories: _stories,
          onStoriesUpdated: _updateStories,
        );
    }
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      selectedItemColor: Colors.blue[800],
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Patients',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
      ],
    );
  }

  void _updateStories(List<HealthStory> updatedStories) {
    setState(() {
      _stories = List.from(updatedStories);
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Health updates updated successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _toggleFlag(String patientId) {
    setState(() {
      final patient = _patients.firstWhere((p) => p.id == patientId);
      patient.flagged = !patient.flagged;
    });

    final patient = _patients.firstWhere((p) => p.id == patientId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(patient.flagged
            ? '${patient.name} flagged for attention'
            : '${patient.name} unflagged'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _sendEmail(Patient patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Email to Patient'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient: ${patient.name}'),
            Text('Email: ${patient.email}'),
            Text('Condition: ${patient.condition}'),
            const SizedBox(height: 16),
            const Text('What would you like to do?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _sendAppointmentReminder(patient);
            },
            child: const Text('Appointment Reminder'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _sendHealthUpdate(patient);
            },
            child: const Text('Health Update'),
          ),
        ],
      ),
    );
  }

  void _sendAppointmentReminder(Patient patient) {
    // Simulate sending appointment reminder
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Appointment reminder sent to ${patient.name}'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Undo action if needed
          },
        ),
      ),
    );
  }

  void _sendHealthUpdate(Patient patient) {
    // Simulate sending health update
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Health update sent to ${patient.name}'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Undo action if needed
          },
        ),
      ),
    );
  }

  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildNotificationItem(
                'New patient report',
                'John Doe reported malaria symptoms',
                Icons.medical_services,
                Colors.blue,
              ),
              _buildNotificationItem(
                'Critical alert',
                'Sarah Wilson condition worsened',
                Icons.warning,
                Colors.orange,
              ),
              _buildNotificationItem(
                'System update',
                'New features available in dashboard',
                Icons.update,
                Colors.green,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, size: 16),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening: $title')),
        );
      },
    );
  }

  void _showProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Your Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue[100],
              child: const Icon(Icons.person, size: 40, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            const Text(
              'Dr. Sarah Smith',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Senior Health Officer'),
            const SizedBox(height: 8),
            const Text('Department: Epidemiology'),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            _buildProfileStat('Patients Today', '12'),
            _buildProfileStat('Total Cases', '88'),
            _buildProfileStat('Success Rate', '94%'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showEditProfile();
            },
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showEditProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Profile editing functionality would go here...'),
              SizedBox(height: 16),
              Text('This could include:'),
              Text('• Name and contact updates'),
              Text('• Profile picture upload'),
              Text('• Department information'),
              Text('• Notification preferences'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}