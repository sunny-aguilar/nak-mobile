import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class FratInfo extends StatelessWidget {
  const FratInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: const FratInfoBody(),
    );
  }
}

class FratInfoBody extends StatelessWidget {
  const FratInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      children: <Widget>[
        // Header Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.redOfficial.withOpacity(0.1),
                theme.redOfficial.withOpacity(0.05),
              ],
            ),
            border: Border.all(
              color: theme.redOfficial.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Fraternity Information',
                textAlign: TextAlign.center,
                style: theme.TextThemes.headlineSmall20(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.redOfficial,
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                'Nu Alpha Kappa Fraternity, Inc.',
                textAlign: TextAlign.center,
                style: theme.TextThemes.bodyLarge(context).copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color ?? theme.charcoalClr,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28,),

        // Corporate Address Section
        _buildInfoCard(
          context,
          icon: Icons.location_on_rounded,
          title: 'Corporate Address',
          content: 'Nu Alpha Kappa Fraternity\nPO Box 1287\nRoseville, CA 95678',
        ),
        const SizedBox(height: 20,),

        // Tax Information Section
        _buildInfoCard(
          context,
          icon: Icons.receipt_long_rounded,
          title: 'Tax Information',
          content: 'Nu Alpha Kappa, Inc. is an officially recognized 501(c)(3) organization. Contact the CFO for more information regarding the tax status of Nu Alpha Kappa Fraternity.',
        ),
        const SizedBox(height: 20,),

        // Donations Section
        _buildInfoCard(
          context,
          icon: Icons.favorite_rounded,
          title: 'Donations',
          content: 'Most donations made to the national organization Nu Alpha Kappa Fraternity, Inc. are tax deductible. NAK provides tax receipts upon request. Local chapters should inquire to the national office for any questions on donations.',
        ),
        const SizedBox(height: 20,),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shawdowClr.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: theme.redOfficial,
                  width: 4,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Title with Icon
                  Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.redOfficial.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          icon,
                          color: theme.redOfficial,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12,),
                      Expanded(
                        child: Text(
                          title,
                          style: theme.TextThemes.bodyLargeBold(context).copyWith(
                            color: theme.redOfficial,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  // Content
                  Text(
                    content,
                    style: theme.TextThemes.bodyLarge(context).copyWith(
                      height: 1.6,
                      color: Theme.of(context).textTheme.bodyLarge?.color ?? theme.charcoalClr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}