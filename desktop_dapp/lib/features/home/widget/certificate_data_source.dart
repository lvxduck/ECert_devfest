import 'package:ecert/core/widget/google_loading.dart';
import 'package:ecert/features/home/model/certificate.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CertificateDataSource extends DataGridSource {
  CertificateDataSource({required List<Certificate?> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'cid', value: e?.cid),
              DataGridCell<String>(columnName: 'timeAdd', value: e?.timeAdd),
              DataGridCell<String>(columnName: 'name', value: e?.name),
              DataGridCell<String>(columnName: 'type', value: e?.type),
              const DataGridCell<String>(columnName: 'delete', value: "delete"),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return e.value == null
          ? GoogleLoading(radius: 12)
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: e.value == "delete"
                  ? Icon(
                      Icons.delete,
                      color: CustomTheme.lightColorScheme.primary,
                    )
                  : Text(
                      e.value.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
            );
    }).toList());
  }
}
