import 'package:flutter/material.dart';
import 'package:tap_invest/core/theme/app_theme.dart';
import 'package:tap_invest/features/home/presentation/bloc/home_bloc.dart';

class IssuerDetails extends StatelessWidget {
  final HomeState? state;
  const IssuerDetails({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: AppTheme.kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.description_outlined),
                const SizedBox(width: 8),
                Text(
                  'Issuer Details',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 12),
            _buildDetailItem(
              'Issuer Name',
              state?.companyDetails?.issuerDetails?.issuerName ?? '',
            ),
            _buildDetailItem(
              'Type of Issuer',
              state?.companyDetails?.issuerDetails?.typeOfIssuer ?? '',
            ),
            _buildDetailItem(
              'Sector',
              state?.companyDetails?.issuerDetails?.sector ?? '',
            ),
            _buildDetailItem(
              'Industry',
              state?.companyDetails?.issuerDetails?.industry ?? '',
            ),
            _buildDetailItem(
              'Issuer nature',
              state?.companyDetails?.issuerDetails?.issuerNature ?? '',
            ),
            _buildDetailItem(
              'Corporate Identity Number (CIN)',
              state?.companyDetails?.issuerDetails?.cin ?? '',
              isLink: true,
            ),
            _buildDetailItem(
              'Name of the Lead Manager',
              state?.companyDetails?.issuerDetails?.leadManager ?? '',
            ),
            _buildDetailItem(
              'Registrar',
              state?.companyDetails?.issuerDetails?.registrar ?? '',
            ),
            _buildDetailItem(
              'Name of Debenture Trustee',
              state?.companyDetails?.issuerDetails?.debentureTrustee ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF1D4ED8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
