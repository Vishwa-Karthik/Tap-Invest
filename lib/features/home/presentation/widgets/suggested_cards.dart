import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tap_invest/core/theme/app_theme.dart';
import 'package:tap_invest/features/home/data/model/company_list_response_model.dart';

class SuggestedResultsCard extends StatelessWidget {
  final List<Company> companyList;
  final String? cardTitle;
  final void Function(Company company)? onCompanyTap;

  const SuggestedResultsCard({
    super.key,
    required this.companyList,
    required this.cardTitle,
    this.onCompanyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.sizeOf(context);
    if (companyList.isEmpty) return const SizedBox();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardTitle ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.kGreyColor,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.kWhiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: companyList.length,
                itemBuilder: (context, index) {
                  final company = companyList[index];

                  return ListTile(
                    onTap: () => onCompanyTap?.call(company),
                    leading: Container(
                      width: mediaQuery.width * 0.1,
                      height: mediaQuery.width * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: company.logo ?? '',
                          width: mediaQuery.width * 0.09,
                          height: mediaQuery.width * 0.09,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SizedBox(
                            width: mediaQuery.width * 0.1,
                            height: mediaQuery.width * 0.1,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                radius: 21,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.error,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                        ),
                      ),
                    ),
                    title: Text(
                      company.isin ?? '',
                      style: theme.textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    subtitle: Text(
                      '${company.rating ?? ''}  •  ${company.companyName ?? ''}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
