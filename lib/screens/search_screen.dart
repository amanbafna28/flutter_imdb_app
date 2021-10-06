import 'package:flutter/material.dart';
import 'package:imdb_flutter_app/providers/movie_provider.dart';
import 'package:imdb_flutter_app/themes/export_themes.dart';
import 'package:imdb_flutter_app/utilities/export_utilities.dart';
import 'package:imdb_flutter_app/utilities/size_config.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            SizedBox(
              height: SizeConfig.deviceHeight * 5,
            ),
            CustomTextFieldContainer(),
            SizedBox(
              height: SizeConfig.deviceHeight * 2.5,
            ),
            _widgetBySearchState(
                context.watch<MovieProvider>().searchState, context),
          ],
        ),
      ),
    );
  }

  Widget _widgetBySearchState(SEARCH_STATE searchState, BuildContext context) {
    Widget widget;
    switch (searchState) {
      case SEARCH_STATE.SEARCHING:
        widget = Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.deviceHeight * 2,
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.whiteColor),
          ),
        );
        break;

      case SEARCH_STATE.NOT_FOUND:
        widget = Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.deviceHeight * 2,
          ),
          child: Text(
            'No results found.',
            style: AppTextStyles.standardTextStyle.copyWith(
              color: AppColors.whiteColor,
              fontSize: SizeConfig.deviceHeight * 2,
            ),
          ),
        );
        break;

      case SEARCH_STATE.FOUND:
        widget = MovieDetailsWidget(
          details: context.read<MovieProvider>().result,
        );
        break;

      case SEARCH_STATE.IDLE:
        widget = SizedBox.shrink();
        break;
    }
    return widget;
  }
}

class CustomTextFieldContainer extends StatefulWidget {
  @override
  _CustomTextFieldContainerState createState() =>
      _CustomTextFieldContainerState();
}

class _CustomTextFieldContainerState extends State<CustomTextFieldContainer> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.standardHorizontalLen,
      ),
      height: SizeConfig.deviceHeight * 7.5,
      decoration: BoxDecoration(
          color: AppColors.textFieldBgColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge)),
      alignment: Alignment.center,
      margin:
          EdgeInsets.symmetric(horizontal: AppDimensions.standardHorizontalLen),
      child: Row(
        children: [
          CustomIconButton(
            iconName: 'Frame',
          ),
          SizedBox(
            width: SizeConfig.deviceWidth * 2.5,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              onChanged: (text) =>
                  context.read<MovieProvider>().searchMovie(text),
              style: AppTextStyles.standardTextStyle
                  .copyWith(color: AppColors.whiteColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Search Movies/Shows',
                hintStyle: AppTextStyles.standardTextStyle
                    .copyWith(color: AppColors.whiteColor),
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.deviceWidth * 2.5,
          ),
          CustomIconButton(
            onPressed: () {
              if (controller.text.trim().length > 0) {
                controller.clear();
              }
            },
            iconName: 'Group 220',
          ),
        ],
      ),
    );
  }
}
