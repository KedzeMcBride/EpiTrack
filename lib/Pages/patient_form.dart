import 'package:flutter/material.dart';

class PatientsForm extends StatefulWidget {
  const PatientsForm({super.key});

  @override
  State<PatientsForm> createState() => _PatientsFormState();
}

class _PatientsFormState extends State<PatientsForm> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Remove Scaffold, return directly
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
                    child: Text(currentStep == 2 ? 'Submit' : 'Next'),
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
        title: const Text("Personal Info"),
        content: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Medical Details"),
        content: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Condition",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Medications",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Allergies",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Contact & Emergency"),
        content: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Emergency Contact",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Emergency Phone",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
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
          title: const Text('Registration Successful'),
          content: const Text('Patient information has been saved successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Don't pop again since we're not in a separate screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}