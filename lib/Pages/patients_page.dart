import 'package:flutter/material.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {

  // Sample user data
  final String userName = "Agba John Doe";
  final String userEmail = "john.doe@example.com";
  final String userAvatar = "lib/images/logo.png";

  // Sample stories data
  final List<Map<String, String>> stories = [
    {'name': 'Story 1', 'image': 'lib/images/logo.png'},
    {'name': 'Story 2', 'image': 'lib/images/logo.png'},
    {'name': 'Story 3', 'image': 'lib/images/logo.png'},
    {'name': 'Story 4', 'image': 'lib/images/logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EpiTrack',
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => print('Notification bell tapped'),
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () => print('Message icon tapped'),
            icon: const Icon(Icons.message_outlined),
            color: Colors.black,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // User Profile and Stories Section
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // User Profile Card (Left Side)
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(userAvatar),
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userName.split(' ')[0],
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Stories Horizontal List (Right Side)
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: stories.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.purple, Colors.blue],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                  image: DecorationImage(
                                    image: AssetImage(stories[index]['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                stories[index]['name']!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}