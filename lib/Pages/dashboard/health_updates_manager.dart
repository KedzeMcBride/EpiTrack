// TODO Implement this library.
import 'package:flutter/material.dart';
import '../models/story_model.dart';

class HealthUpdatesManager extends StatefulWidget {
  final List<HealthStory> stories;
  final Function(List<HealthStory>) onStoriesUpdated;

  const HealthUpdatesManager({
    super.key,
    required this.stories,
    required this.onStoriesUpdated,
  });

  @override
  State<HealthUpdatesManager> createState() => _HealthUpdatesManagerState();
}

class _HealthUpdatesManagerState extends State<HealthUpdatesManager> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Health Updates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blue),
              onPressed: _showAddStoryDialog,
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140, // Increased height for images
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.stories.length,
            itemBuilder: (context, index) {
              return _buildStoryCard(widget.stories[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStoryCard(HealthStory story) {
    return Stack(
      children: [
        Container(
          width: 200,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: story.imageUrl != null
                        ? NetworkImage(story.imageUrl!) // Network image
                        : AssetImage(story.image) as ImageProvider, // Local asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      story.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      story.date,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Delete button
        Positioned(
          top: 4,
          right: 16,
          child: GestureDetector(
            onTap: () => _deleteStory(story.id),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddStoryDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Health Update'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Leave empty to use default image',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty) {
                _addStory(
                  titleController.text,
                  descriptionController.text,
                  imageUrlController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addStory(String title, String description, String imageUrl) {
    final newStory = HealthStory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      image: 'lib/images/logo.png', // Default image
      date: 'Just now',
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
    );

    final updatedStories = [...widget.stories, newStory];
    widget.onStoriesUpdated(updatedStories);
  }

  void _deleteStory(String storyId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Update'),
        content: const Text('Are you sure you want to delete this health update?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedStories = widget.stories
                  .where((story) => story.id != storyId)
                  .toList();
              widget.onStoriesUpdated(updatedStories);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}