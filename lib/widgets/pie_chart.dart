import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/utils/constants.dart';

class MobileSalesChart extends StatelessWidget {
  final double infinixPercentage;
  final double tecnoPercentage;
  final double realmePercentage;
  final double redmiPercentage;
  final double othersPercentage;
  final int unitsSold;

  const MobileSalesChart({
    super.key,
    required this.infinixPercentage,
    required this.tecnoPercentage,
    required this.realmePercentage,
    required this.redmiPercentage,
    required this.othersPercentage,
    required this.unitsSold,
  });

  String formatUnits(int unitsSold) {
    if (unitsSold >= 1000000) {
      return '${(unitsSold / 1000000).toStringAsFixed(1)}M';
    } else if (unitsSold >= 1000) {
      return '${(unitsSold / 1000).toStringAsFixed(1)}K';
    } else {
      return unitsSold.toString();
    }
  }

  Widget _buildLegendItem(String title, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(title),
          const SizedBox(width: 10),
          Text(
            percentage,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        value: infinixPercentage,
        color: Colors.blue[400]!,
        title: '',
        radius: 30,
      ),
      PieChartSectionData(
        value: tecnoPercentage,
        color: Colors.orange[300]!,
        title: '',
        radius: 30,
      ),
      PieChartSectionData(
        value: realmePercentage,
        color: Colors.green[300]!,
        title: '',
        radius: 30,
      ),
      PieChartSectionData(
        value: redmiPercentage,
        color: Colors.red[300]!,
        title: '',
        radius: 30,
      ),
      PieChartSectionData(
        value: othersPercentage,
        color: Colors.purple[300]!,
        title: '',
        radius: 30,
      ),
    ];
  }

  Widget _buildPieChart() {
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              centerSpaceRadius: 100,
              sections: _buildPieChartSections(),
            ),
          ),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.PrimaryColor.withOpacity(0.3),
              border: Border.all(
                color: AppColors.PrimaryColor,
                width: 2.0,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatUnits(unitsSold),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Units Sold",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendColumn(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1 + 20,
      child: Column(
        children: [
          _buildLegendItem("Infinix", "$infinixPercentage%", Colors.blue[400]!),
          _buildLegendItem("Tecno", "$tecnoPercentage%", Colors.orange[300]!),
          _buildLegendItem("Realme", "$realmePercentage%", Colors.green[300]!),
          _buildLegendItem("Redmi", "$redmiPercentage%", Colors.red[300]!),
          _buildLegendItem("Others", "$othersPercentage%", Colors.purple[300]!),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 -
          50, // Adjusted height without portrait setup
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Mobile Sales Distribution",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  onSelected: (value) {
                    if (value == 'option1') {
                      // Handle Option 1
                    } else if (value == 'option2') {
                      // Handle Option 2
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'option1',
                      child: Text('Option 1'),
                    ),
                    const PopupMenuItem(
                      value: 'option2',
                      child: Text('Option 2'),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(height: 0), // Unified height
            Row(
              children: [
                Expanded(child: _buildPieChart()),
                _buildLegendColumn(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
