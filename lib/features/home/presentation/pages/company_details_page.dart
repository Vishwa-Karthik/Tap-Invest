import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_invest/core/theme/app_theme.dart';
import 'package:tap_invest/features/home/presentation/bloc/home_bloc.dart';
import 'package:tap_invest/features/home/presentation/widgets/chart_view.dart';
import 'package:tap_invest/features/home/presentation/widgets/issuer_details.dart';
import 'package:tap_invest/features/home/presentation/widgets/pros_and_cons_view.dart';

class CompanyDetailsPage extends StatefulWidget {
  const CompanyDetailsPage({super.key});

  @override
  State<CompanyDetailsPage> createState() => _CompanyDetailsPageState();
}

class _CompanyDetailsPageState extends State<CompanyDetailsPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    context.read<HomeBloc>().add(HomeCompanyDetails());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.initial ||
                state.status == HomeStatus.loading) {
              return const Center(child: CircularProgressIndicator());
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
            } else if (state.status == HomeStatus.loaded) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 0.22,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(18),
                        border: BoxBorder.all(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: state.companyDetails?.logo ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      state.companyDetails?.companyName ?? '-',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.companyDetails?.description ?? '',
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Chip(
                          label: Text(state.companyDetails?.isin ?? ''),
                          backgroundColor: Color(0xFFDFE8F8),
                          labelStyle: const TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(width: 8),
                        Chip(
                          label: Text(state.companyDetails?.status ?? ''),
                          backgroundColor: Color(0xFFE5F2EF),
                          labelStyle: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TabBar(
                      controller: tabController,
                      dividerColor: Colors.grey.shade300,
                      indicatorColor: AppTheme.kLightBlue,
                      labelColor: AppTheme.kLightBlue,
                      tabs: [
                        Tab(text: 'ISIN Analysis'),
                        Tab(text: 'Pros & Cons'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          // 1
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                ChartView(state: state),
                                IssuerDetails(state: state),
                              ],
                            ),
                          ),

                          // 2
                          SingleChildScrollView(
                            child: ProAndConsView(state: state),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
