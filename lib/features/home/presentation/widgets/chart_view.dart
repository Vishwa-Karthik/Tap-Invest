import 'package:flutter/material.dart';
import 'package:tap_invest/core/theme/app_theme.dart';
import 'package:tap_invest/features/home/presentation/bloc/home_bloc.dart';
import 'package:tap_invest/features/home/presentation/widgets/company_finanicial_chart.dart';

enum ChartViewSegment { ebitda, revenue }

class ChartView extends StatefulWidget {
  final HomeState? state;
  const ChartView({super.key, required this.state});

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  ChartViewSegment segment = ChartViewSegment.ebitda;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'COMPANY FINANCIALS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: segment == ChartViewSegment.revenue ? 13 : 15,
                  ),
                ),
                SegmentedButton(
                  showSelectedIcon: true,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.white,
                    ),
                    iconSize: WidgetStatePropertyAll<double>(16),
                    minimumSize: WidgetStatePropertyAll<Size>(Size(20, 30)),
                    fixedSize: WidgetStatePropertyAll<Size>(Size(20, 30)),
                    maximumSize: WidgetStatePropertyAll<Size>(Size(20, 30)),
                  ),
                  segments: <ButtonSegment<ChartViewSegment>>[
                    ButtonSegment(
                      value: ChartViewSegment.ebitda,
                      label: Text('EBITDA'),
                    ),
                    ButtonSegment(
                      value: ChartViewSegment.revenue,
                      label: Text('REVENUE'),
                    ),
                  ],
                  selected: <ChartViewSegment>{segment},
                  onSelectionChanged: (Set<ChartViewSegment> value) {
                    setState(() {
                      segment = value.first;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            CompanyFinancialChart(
              selectedSegment: segment,
              ebitda:
                  widget.state?.companyDetails?.financials?.ebitda.toList() ??
                  [],
              revenue:
                  widget.state?.companyDetails?.financials?.revenue.toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}
