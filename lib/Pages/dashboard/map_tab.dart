import 'package:flutter/material.dart';
import '../models/disease_stats_model.dart';

class MapTab extends StatelessWidget {
  final List<DiseaseStats> stats;

  const MapTab({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Disease Spread Map',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 64, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Interactive Map View'),
                          SizedBox(height: 4),
                          Text('Showing disease hotspots and spread patterns'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    final diseaseColors = {
      'Malaria': Colors.red,
      'COVID-19': Colors.blue,
      'Cholera': Colors.orange,
      'Measles': Colors.purple,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: diseaseColors.entries.map((entry) {
          return _buildMapLegend(entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  Widget _buildMapLegend(String disease, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          disease,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}