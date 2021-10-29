import 'package:ecert/core/svg_icon.dart';
import 'package:ecert/features/home/controller/home_controller.dart';
import 'package:ecert/features/home/widget/app_bar.dart';
import 'package:ecert/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(color: Colors.white);
    const int rowsPerPage = 3;

    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 21),
            const Text(
              "Danh sách văn bằng",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SfDataPagerTheme(
                  data: SfDataPagerThemeData(
                    itemColor: Colors.grey[200],
                    selectedItemColor: CustomTheme.lightColorScheme.primary,
                    itemBorderRadius: BorderRadius.circular(5),
                    itemTextStyle: const TextStyle(color: Colors.black),
                  ),
                  child: Obx(() {
                    return SfDataPager(
                      delegate: _controller.orderInfoDataSource.value,
                      pageCount: _controller.dataCert.length / rowsPerPage,
                      direction: Axis.horizontal,
                      itemHeight: 38,
                      itemWidth: 38,
                      navigationItemHeight: 38,
                    );
                  }),
                ),
                const SizedBox(width: 48),
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: TextField(
                      controller: _controller.searchController,
                      onSubmitted: _controller.onSearchSubmitted,
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm theo tên",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          onTap: _controller.onClearSearch,
                          child: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48),
                SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: _controller.addCertificate,
                    label: Text(
                      "Thêm",
                      style: Get.textTheme.subtitle2?.copyWith(color: Colors.white),
                    ),
                    icon: const Icon(Icons.add),
                    style: ElevatedButton.styleFrom(),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: _controller.addFromExcel,
                    label: Text(
                      "Thêm từ Excel",
                      style: Get.textTheme.subtitle2?.copyWith(color: Colors.white),
                    ),
                    icon: SvgPicture.string(SVGIcon.excel),
                    style: ElevatedButton.styleFrom(),
                  ),
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                      headerColor: CustomTheme.lightColorScheme.primary,
                      gridLineColor: const Color(0xffE4E4E4),
                      headerHoverColor: CustomTheme.lightColorScheme.onBackground,
                    ),
                    child: Obx(() {
                      return SfDataGrid(
                        source: _controller.orderInfoDataSource.value,
                        columnWidthMode: ColumnWidthMode.fill,
                        headerRowHeight: 46,
                        onQueryRowHeight: (details) {
                          return 38;
                        },
                        onCellTap: (DataGridCellTapDetails data) {
                          if (data.rowColumnIndex.columnIndex == 4) {
                            _controller.alertDeleteCertificate(data.rowColumnIndex.rowIndex);
                          } else {
                            _controller.handleRowPressed(data.rowColumnIndex.rowIndex);
                          }
                        },
                        columns: <GridColumn>[
                          GridColumn(
                            columnName: 'cid',
                            label: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: const Text('Mã chứng chỉ', style: headerStyle),
                            ),
                          ),
                          GridColumn(
                            columnName: 'timeAdd',
                            label: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              child: const Text('Thời gian thêm', style: headerStyle),
                            ),
                          ),
                          GridColumn(
                            columnName: 'name',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Họ và tên', style: headerStyle),
                            ),
                          ),
                          GridColumn(
                            columnName: 'type',
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: const Text('Loại văn bằng', style: headerStyle),
                            ),
                          ),
                          GridColumn(
                            columnName: 'delete',
                            width: 80.0,
                            label: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              width: 52,
                              child: const Text('', style: headerStyle),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
