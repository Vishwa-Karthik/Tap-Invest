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

    if (companyList.isEmpty) return const SliverToBoxAdapter(child: SizedBox());

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
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
              child: Column(
                children: List.generate(
                  companyList.length * 2 - 1,
                  (index) {
                    if (index.isOdd) {
                      return Divider(
                        color: Colors.grey.shade300,
                      );
                    }
                    final actualIndex = index ~/ 2;

                    final company = companyList[actualIndex];

                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
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
                              child: const CircularProgressIndicator(
                                  strokeWidth: 2),
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
                        color: Color(0xFF406AEB),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
