import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/widgets/dialog/mass_convert_dialog.dart';
import '../../_features/_widgets/bottom_sheet_modal/bottom_sheet_modal.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/widgets/form/custom_text_input.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/base/view/base_widget.dart';
import '../viewmodel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, HomeViewModel viewModel) => ScaffoldMessenger(
        key: viewModel.scaffoldKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: buildBody(context, viewModel),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, HomeViewModel viewModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingNormal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: context.verticalPaddingNormal,
              child: CustomTextInput(
                  controller: viewModel.numberController,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    viewModel.changeResult(value);
                  },
                  onTap: () {},
                  suffixIcon: IconButton(
                    onPressed: () {
                      viewModel.clearInputs();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  hintText: '100.50',
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(21),
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,18}\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    return null;
                  },
                  focusNode: FocusNode()),
            ),
            CustomTextInput(
                controller: viewModel.resultController,
                maxLines: null,
                enabled: false,
                hintText: LocaleKeys.enter_your_money_hint.tr(),
                focusNode: FocusNode()),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildActionButton(Icons.monetization_on_outlined, () {
                  modalBottomSheet(
                    viewModel,
                    context,
                    270,
                    LocaleKeys.currency,
                    viewModel.currencyList.length,
                        (BuildContext context, int index) {
                      return buildBottomSheetItem(viewModel, context, index, viewModel.currencyMap[index], () {
                        viewModel.changeAppCurrency(viewModel.currencyList[index]);
                        Navigator.pop(context);
                      }, (viewModel.currentCurrency == viewModel.currencyList[index]));
                    },
                  );
                }),
                buildActionButton(Icons.copy, () async {
                  viewModel.copyToClipboard();
                }),
                buildActionButton(Icons.calculate_outlined, () {
                  //print('calculate');
                  viewModel.openCalculatorPage();
                }),
                buildActionButton(Icons.all_inclusive, () {
                  //print('Audiotrack');
                  showDialog(
                      context: context,
                      builder: (context) {
                        return MassConvertDialog(
                            data: viewModel.separatorTypeList,
                            selectedData: viewModel.selectedSeparatorType,
                            onSelectedDataChanged: (selected) {
                              viewModel.massUpload(selected);
                            });
                      });
                }),
                buildActionButton(Icons.language, () {
                  modalBottomSheet(
                    viewModel,
                    context,
                    context.height * 0.3,
                    LocaleKeys.language,
                    viewModel.languageList.length,
                        (BuildContext context, int index) {
                      return buildBottomSheetItem(viewModel, context, index, viewModel.languageMap[index], () {
                        viewModel.changeAppLocalization(viewModel.languageList[index]);
                        Navigator.pop(context);
                      }, (viewModel.currentLocale == viewModel.languageList[index]));
                    },
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildActionButton(IconData icon, VoidCallback action) {
    return Expanded(
      child: Card(
        elevation: 5,
        child: IconButton(
            onPressed: action,
            icon: Icon(icon)),
      ),
    );
  }
}
