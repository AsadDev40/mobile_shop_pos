import 'package:flutter/material.dart';

class RecentSaleTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Order ID')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Status')),
            ],
            rows: [
              _buildDataRow('1001', 'John Doe', '\$120', 'Completed'),
              _buildDataRow('1002', 'Jane Smith', '\$80', 'Pending'),
              _buildDataRow('1003', 'Alice Johnson', '\$200', 'Completed'),
              _buildDataRow('1004', 'Bob Brown', '\$50', 'Cancelled'),
              _buildDataRow('1005', 'Charlie Davis', '\$150', 'Completed'),
            ],
          ),
        ),
      ),
    );
  }

  DataRow _buildDataRow(
      String orderId, String customer, String amount, String status) {
    Color statusColor = status == 'Completed'
        ? Colors.green
        : status == 'Pending'
            ? Colors.orange
            : Colors.red;

    return DataRow(cells: [
      DataCell(Text(orderId)),
      DataCell(Text(customer)),
      DataCell(Text(amount)),
      DataCell(
        Text(
          status,
          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }
}
