import 'package:flutter/material.dart';

class PatientsForm extends StatefulWidget {
  const PatientsForm({super.key});

  @override
  State<PatientsForm> createState() => _PatientsFormState();
}

class _PatientsFormState extends State<PatientsForm> {
  int currentStep = 0;

  // Form state variables
  String? _diseaseType;
  String? _knownDisease;
  final List<String> _selectedSymptoms = [];
  final TextEditingController _otherSymptomsController = TextEditingController();
  String? _patientCondition;
  DateTime? _symptomStartDate;
  bool? _receivedMedicalCare;
  final TextEditingController _landmarkController = TextEditingController();

  // Options
  final List<String> _knownDiseases = [
    'Cholera',
    'Malaria',
    'COVID-19',
    'Measles',
    'Other'
  ];

  final List<Map<String, dynamic>> _symptoms = <Map<String, dynamic>>[
    {'name': 'Fever', 'icon': Icons.thermostat},
    {'name': 'Cough', 'icon': Icons.coronavirus},
    {'name': 'Diarrhea', 'icon': Icons.water_drop},
    {'name': 'Vomiting', 'icon': Icons.sick},
    {'name': 'Rash', 'icon': Icons.health_and_safety},
    {'name': 'Fatigue', 'icon': Icons.nightlight_round},
    {'name': 'Headache', 'icon': Icons.personal_injury},
  ];

  final List<Map<String, dynamic>> _conditions = [
    {'name': 'Alive', 'emoji': ''},
    {'name': 'Critical', 'emoji': ''},
    {'name': 'Deceased', 'emoji': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Add SingleChildScrollView here
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Stepper(
          type: StepperType.vertical,
          currentStep: currentStep,
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  if (currentStep != 0)
                    ElevatedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(currentStep == 2 ? 'Submit Report' : 'Next'),
                  ),
                ],
              ),
            );
          },
          onStepCancel: () => currentStep == 0
              ? null
              : setState(() {
            currentStep -= 1;
          }),
          onStepContinue: () {
            bool isLastStep = (currentStep == getSteps().length - 1);
            if (isLastStep) {
              _showSuccessDialog();
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepTapped: (step) => setState(() {
            currentStep = step;
          }),
          steps: getSteps(),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Disease & Symptoms"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Disease Type
            const Text(
              "What type of epidemic are you reporting?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Known'),
                    value: 'Known',
                    groupValue: _diseaseType,
                    onChanged: (value) {
                      setState(() {
                        _diseaseType = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Unknown'),
                    value: 'Unknown',
                    groupValue: _diseaseType,
                    onChanged: (value) {
                      setState(() {
                        _diseaseType = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Known Disease Dropdown
            if (_diseaseType == 'Known') ...[
              const SizedBox(height: 16),
              const Text(
                "If Known, which disease?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _knownDisease,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select disease',
                ),
                items: _knownDiseases.map((String disease) {
                  return DropdownMenuItem<String>(
                    value: disease,
                    child: Text(disease),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _knownDisease = value;
                  });
                },
              ),
            ],

            // Symptoms Checklist
            const SizedBox(height: 24),
            const Text(
              "What symptoms does the patient have?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _symptoms.map((symptom) {
                return FilterChip(
                  selected: _selectedSymptoms.contains(symptom['name']),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(symptom['icon'], size: 16),
                      const SizedBox(width: 4),
                      Text(symptom['name']),
                    ],
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedSymptoms.add(symptom['name']);
                      } else {
                        _selectedSymptoms.remove(symptom['name']);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            // Other Symptoms
            const SizedBox(height: 16),
            TextFormField(
              controller: _otherSymptomsController,
              decoration: const InputDecoration(
                labelText: "Other symptoms (describe briefly)",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Patient Condition"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Condition
            const Text(
              "What is the patient's condition right now?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Column(
              children: _conditions.map((condition) {
                return RadioListTile<String>(
                  title: Row(
                    children: [
                      Text(condition['emoji']),
                      const SizedBox(width: 8),
                      Text(condition['name']),
                    ],
                  ),
                  value: condition['name'],
                  groupValue: _patientCondition,
                  onChanged: (value) {
                    setState(() {
                      _patientCondition = value;
                    });
                  },
                );
              }).toList(),
            ),

            // Symptom Start Date
            const SizedBox(height: 24),
            const Text(
              "When did the symptoms start?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _symptomStartDate = picked;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _symptomStartDate == null
                    ? "Select date"
                    : "Selected: ${_symptomStartDate!.toString().split(' ')[0]}",
              ),
            ),

            // Medical Care
            const SizedBox(height: 24),
            const Text(
              "Has the patient received medical care?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('Yes'),
                    value: true,
                    groupValue: _receivedMedicalCare,
                    onChanged: (value) {
                      setState(() {
                        _receivedMedicalCare = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: const Text('No'),
                    value: false,
                    groupValue: _receivedMedicalCare,
                    onChanged: (value) {
                      setState(() {
                        _receivedMedicalCare = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Location"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Header
            const Text(
              "Where is the patient located?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // GPS Capture Button
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(Icons.location_on, size: 48, color: Colors.blue),
                    const SizedBox(height: 8),
                    const Text(
                      "GPS Location",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Auto-capturing location...",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement GPS capture
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Capturing current location...')),
                        );
                      },
                      icon: const Icon(Icons.gps_fixed),
                      label: const Text('Capture Current Location'),
                    ),
                  ],
                ),
              ),
            ),

            // Map Preview Placeholder
            const SizedBox(height: 16),
            Container(
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('Map preview will appear here'),
                  ],
                ),
              ),
            ),

            // Location Details
            const SizedBox(height: 24),
            const Text(
              "Confirm location details:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "District",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Neighborhood",
                border: OutlineInputBorder(),
              ),
            ),

            // Landmark
            const SizedBox(height: 16),
            TextFormField(
              controller: _landmarkController,
              decoration: const InputDecoration(
                labelText: "Landmark / nearest facility (optional)",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Submitted Successfully!'),
          content: const Text('Epidemic report has been recorded and will be reviewed by health authorities.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _otherSymptomsController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }
}