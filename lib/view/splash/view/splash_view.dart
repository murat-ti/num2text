import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/base/view/base_widget.dart';
import '../../../core/constants/image/image_constants.dart';
import '../viewmodel/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashViewModel>(
      viewModel: SplashViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SplashViewModel viewModel) => Scaffold(
          backgroundColor: context.colorScheme.primaryVariant,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset(ImageConstants.instance.logo),
                ),
                const SizedBox(height: 10),
                Text(
                  'Money2Word',
                  style: context.appTheme.textTheme.headline4?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.appTheme.colorScheme.secondaryVariant,
                  ),
                ),
                Text(
                  'Money into words converter',
                  style: context.appTheme.textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: context.appTheme.colorScheme.primary.withOpacity(0.5),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget buildSvgPicture(BuildContext context, String path) =>
      SvgPicture.asset(path, color: context.appTheme.colorScheme.primaryVariant);
}
