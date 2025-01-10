import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        automaticallyImplyLeading: false,
        title: const Text(
          'Control Panel',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushNamed(context, '/notify');
            },
          ),
        ],
        elevation: 8.0, // Added shadow to AppBar
      ),
      body: Container(
        color: Colors.grey[800],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Greeting section
              _buildGreetingSection(),

              const SizedBox(height: 20),

              // Status Indicator section (new component)
              _buildStatusIndicator(),

              const SizedBox(height: 20),

              // Quick Access Buttons
              _buildQuickAccessButtons(context),

              const SizedBox(height: 20),

              // Latest Updates section
              _buildLatestUpdatesSection(),

              const SizedBox(height: 20),

              // Action Cards section
              _buildActionCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Welcome Back!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(
            Icons.warning_amber_outlined,
            size: 30.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  // New Status Indicator Widget
  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Colors.red, // Green color for active status
            size: 12.0,
          ),
          const SizedBox(width: 10.0),
          const Text(
            'Status: Inactive', // You can change this to "Node" or other status
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButtons(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Change to 3 columns to fit 6 buttons
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: 6, // Number of quick access buttons
      itemBuilder: (context, index) {
        final icons = [
          Icons.dataset_linked_rounded,
          Icons.emergency_share,
          Icons.chat,
          Icons.settings,
          Icons.place,
          Icons.miscellaneous_services,
        ];

        final texts = [
          'Data Center',
          'Em-Contact',
          'Chat',
          'Settings',
          'H-Centers',
          'Service',
        ];

        return GestureDetector(
          onTap: () {
            // Navigate to the appropriate page
            Navigator.pushNamed(context, '/panel${index + 1}');
          },
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icons[index], // Use icons list
                  color: Colors.white,
                  size: 30.0,
                ),
                const SizedBox(height: 8.0),
                Text(
                  texts[index], // Use texts list
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLatestUpdatesSection() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Updates',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildUpdateItem(
              'New accident detection system updated', Icons.update),
          _buildUpdateItem('Check your insurance status', Icons.notifications),
          _buildUpdateItem(
              'Crash advisor service now available', Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCards() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.red[700],
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildActionCard('Frequently asked!', Icons.question_answer),
          _buildActionCard('Request Assistance', Icons.help_outline),
          _buildActionCard('View History', Icons.history),
        ],
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Navigate to the appropriate page
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 20.0),
            const SizedBox(width: 15.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
