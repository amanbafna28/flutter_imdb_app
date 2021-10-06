import 'package:flutter/material.dart';
import 'package:imdb_flutter_app/models/movie_response.dart';
import 'package:imdb_flutter_app/screens/movie_details_screen.dart';
import 'package:imdb_flutter_app/themes/export_themes.dart';
import 'package:imdb_flutter_app/utilities/export_utilities.dart';
import 'package:imdb_flutter_app/utilities/size_config.dart';

class CustomIconButton extends StatelessWidget {
  final String iconName;
  final double size;
  Function onPressed;

  CustomIconButton({this.iconName, this.size, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        'assets/images/$iconName.png',
        height: size ?? SizeConfig.deviceWidth * 6,
        width: size ?? SizeConfig.deviceWidth * 6,
      ),
    );
  }
}

class MovieDetailsWidget extends StatelessWidget {
  final MovieResponse details;

  const MovieDetailsWidget({
    Key key,
    this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.standardHorizontalLenSmall,
          vertical: SizeConfig.deviceHeight * 2),
      child: GestureDetector(
        onTap: () => GlobalUtils.navigateTo(
          context: context,
          screen: MovieDetailsScreen(
            movieDetails: details,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.5),
                    image: DecorationImage(
                        image: NetworkImage(
                          details.poster,
                        ),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusMax,
                    ),
                  ),
                  height: SizeConfig.deviceHeight * 25,
                  width: double.maxFinite,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.deviceHeight * 2,
                      left: SizeConfig.deviceWidth * 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.deviceWidth * 2,
                        vertical: SizeConfig.deviceHeight * .5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusSmall,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.whiteColor,
                          size: SizeConfig.deviceHeight * 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.deviceWidth * 2,
                          ),
                          child: Text(
                            '${details.imdbRating} / 10',
                            style: AppTextStyles.standardTextStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.standardHorizontalLen,
                  top: SizeConfig.deviceHeight * 2),
              child: Text(
                details.title,
                style: AppTextStyles.standardTextStyle.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: SizeConfig.deviceHeight * 2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: AppDimensions.standardHorizontalLen,
                  top: SizeConfig.deviceHeight * 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconButton(
                    iconName: 'Group 356',
                    size: SizeConfig.deviceHeight * 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.deviceWidth * 2,
                    ),
                    child: Text(
                      details.runtime,
                      style: AppTextStyles.standardTextStyle.copyWith(
                          color: AppColors.yellowColor,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TitleAndContributorsWidget extends StatelessWidget {
  final String title;
  final List<String> contributors;

  const TitleAndContributorsWidget({
    Key key,
    this.title,
    this.contributors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.deviceHeight * 5,
          ),
          child: Text(
            '$title',
            textAlign: TextAlign.start,
            style: AppTextStyles.standardTextStyle.copyWith(
              color: AppColors.whiteColor,
              fontSize: SizeConfig.deviceHeight * 2.75,
            ),
          ),
        ),
        Wrap(
          children: contributors
              .map((e) => Container(
                    margin: EdgeInsets.all(
                      SizeConfig.deviceHeight * (1),
                    ),
                    padding: EdgeInsets.all(
                      SizeConfig.deviceHeight * (1),
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(.125),
                        borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusSmall)),
                    child: Text(
                      '$e'.toUpperCase(),
                      style: AppTextStyles.standardTextStyle.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: SizeConfig.deviceHeight * 2,
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}

class IconTextRow extends StatelessWidget {
  final String iconName;
  final String title;

  const IconTextRow({
    Key key,
    this.iconName,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.deviceHeight * 2,
      ),
      child: Row(
        children: [
          CustomIconButton(
            iconName: '$iconName',
            size: SizeConfig.deviceHeight * 2.5,
          ),
          SizedBox(
            width: SizeConfig.deviceWidth * 2.5,
          ),
          Container(
            width: SizeConfig.deviceWidth * 50,
            child: Text(
              '$title',
              textAlign: TextAlign.start,
              style: AppTextStyles.standardTextStyle.copyWith(
                color: AppColors.whiteColor,
                fontSize: SizeConfig.deviceHeight * 2.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MovieAndItsReviewWidget extends StatelessWidget {
  final String title;
  final String review;

  const MovieAndItsReviewWidget({this.title, this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.deviceHeight * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConfig.deviceWidth * 35,
            child: Text(
              '$title',
              textAlign: TextAlign.start,
              style: AppTextStyles.standardTextStyle.copyWith(
                color: AppColors.whiteColor,
                fontSize: SizeConfig.deviceHeight * 2.5,
              ),
            ),
          ),
          Text(
            '$review',
            textAlign: TextAlign.start,
            style: AppTextStyles.standardTextStyle.copyWith(
              color: AppColors.whiteColor,
              fontSize: SizeConfig.deviceHeight * 2,
            ),
          )
        ],
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  Widget child;

  DetailsContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.deviceHeight * 1.5,
      ),
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.all(
          SizeConfig.deviceWidth * (2.5),
        ),
        padding: EdgeInsets.all(
          SizeConfig.deviceHeight * (2),
        ),
        decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(.125),
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusLarge)),
        child: child,
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  final String iconName;
  final double allPadding;
  final double iconSize;
  Function onPressed;

  IconContainer(
      {this.iconName, this.iconSize, this.allPadding, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(
          SizeConfig.deviceHeight * (allPadding ?? 1),
        ),
        decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(.125),
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusLarge)),
        child: CustomIconButton(
          iconName: iconName,
          size: iconSize ?? SizeConfig.deviceHeight * 5,
        ),
      ),
    );
  }
}
