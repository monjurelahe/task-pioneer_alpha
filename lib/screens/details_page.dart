// lib/screens/details_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/repository.dart';

class DetailsPage extends StatelessWidget {
  final Repository repository;
  const DetailsPage({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    // Last update date-time (formatted as MM-DD-YYYY HH:MM) [cite: 24]
    final formattedDate = DateFormat(
      'MM-dd-yyyy HH:mm',
    ).format(repository.updatedAt);

    return Scaffold(
      appBar: AppBar(title: Text(repository.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Owner's Profile Photo and Name [cite: 21, 22]
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(repository.owner.avatarUrl),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Owner: ${repository.owner.login}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            const Divider(height: 30),

            // Repository Description [cite: 23]
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              repository.description.isNotEmpty
                  ? repository.description
                  : 'No description provided.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const Divider(height: 30),

            // Other relevant details [cite: 25]
            _buildDetailRow(
              context,
              Icons.star,
              'Stars',
              repository.stargazersCount.toString(),
            ),
            const SizedBox(height: 10),
            _buildDetailRow(
              context,
              Icons.update,
              'Last Updated',
              formattedDate,
            ), // Formatted date [cite: 24]
            const SizedBox(height: 10),
            _buildDetailRow(
              context,
              Icons.code,
              'Repository ID',
              repository.id.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(value),
      ],
    );
  }
}
