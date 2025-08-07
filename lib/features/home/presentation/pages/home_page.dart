import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_invest/core/theme/app_theme.dart';
import 'package:tap_invest/features/home/presentation/bloc/home_bloc.dart';
import 'package:tap_invest/features/home/presentation/pages/company_details_page.dart';
import 'package:tap_invest/features/home/presentation/widgets/suggested_cards.dart';
import 'package:tap_invest/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(HomeCompanyList());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search by Issuer Name or ISIN',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: AppTheme.kWhiteColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),

              onChanged: (value) {
                context.read<HomeBloc>().add(HomeSearchCompany(value));
              },
              onSubmitted: (value) =>
                  context.read<HomeBloc>().add(HomeSearchCompany(value)),
            ),
          ),

          const SizedBox(height: 16.0),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.status == HomeStatus.initial ||
                    state.status == HomeStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.kBlackColor,
                    ),
                  );
                } else if (state.status == HomeStatus.loaded) {
                  return SuggestedResultsCard(
                    cardTitle: (state.isSearchActive ?? false)
                        ? 'SEARCH RESULTS'
                        : 'SUGGESTED RESULTS',
                    companyList: state.companyList ?? [],
                    onCompanyTap: (company) {
                      if (kIsWeb) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                WrappedDeviceFrame(child: CompanyDetailsPage()),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CompanyDetailsPage(),
                          ),
                        );
                      }
                    },
                  );
                } else if (state.status == HomeStatus.error) {
                  return Wrap(
                    direction: Axis.vertical,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(state.errorMessage ?? ''),
                      IconButton(
                        onPressed: () =>
                            context.read<HomeBloc>().add(HomeCompanyList()),
                        icon: Icon(Icons.refresh),
                      ),
                    ],
                  );
                }
                return Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text('No Data Avaialble, Please try Again!'),
                    IconButton(
                      onPressed: () =>
                          context.read<HomeBloc>().add(HomeCompanyList()),
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
