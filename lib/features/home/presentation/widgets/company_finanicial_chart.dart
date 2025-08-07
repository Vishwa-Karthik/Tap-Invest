import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tap_invest/features/home/data/model/company_details_response_model.dart';
import 'package:tap_invest/features/home/presentation/widgets/chart_view.dart';

class CompanyFinancialChart extends StatefulWidget {
  final ChartViewSegment selectedSegment;
  final List<Ebitda> ebitda;
  final List<Ebitda> revenue;

  const CompanyFinancialChart({
    super.key,
    required this.selectedSegment,
    required this.ebitda,
    required this.revenue,
  });

  @override
  State<CompanyFinancialChart> createState() => _CompanyFinancialChartState();
}

class _CompanyFinancialChartState extends State<CompanyFinancialChart> {
  static const _months = [
    'J',
    'F',
    'M',
    'A',
    'M',
    'J',
    'J',
    'A',
    'S',
    'O',
    'N',
    'D',
  ];

  List<BarChartGroupData> _buildBarGroups(ChartViewSegment segment) {
    return List.generate(_months.length, (index) {
      final ebitdaValue = widget.ebitda[index].value ?? 0;
      final revenueValue = widget.revenue[index].value ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          if (segment == ChartViewSegment.ebitda) ...[
            BarChartRodData(
              toY: ebitdaValue / 10000000,
              width: 8,
              color: Color(0xFF155DFC),
              borderRadius: BorderRadius.circular(12),
            ),
          ],
          BarChartRodData(
            toY: revenueValue / 10000000,
            width: 8,
            color: Color(0xFF101829),
            borderRadius: BorderRadius.circular(12),
          ),
        ],
        barsSpace: 4,
      );
    });
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    final month = _months[value.toInt()];
    return SideTitleWidget(
      space: 6,
      meta: meta,
      child: Text(month, style: style),
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontSize: 10,
      fontWeight: FontWeight.bold,
    );

    final label = '${value.toInt()} CR';

    return SideTitleWidget(
      space: 6,
      meta: meta,
      child: Text(label, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final isEbitda =
                    widget.selectedSegment == ChartViewSegment.ebitda;
                final dataList = isEbitda ? widget.ebitda : widget.revenue;

                if (groupIndex < dataList.length) {
                  final entry = dataList[groupIndex];
                  final label = isEbitda ? "EBITDA" : "Revenue";
                  final value = entry.value?.toStringAsFixed(2);

                  return BarTooltipItem(
                    '$label\n₹$value Rs',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  );
                }

                return null;
              },
            ),
          ),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: _bottomTitles,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: _leftTitles,
                interval: 1,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: _buildBarGroups(widget.selectedSegment),
        ),
      ),
    );
  }
}
