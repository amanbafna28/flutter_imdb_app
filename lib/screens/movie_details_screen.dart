import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:imdb_flutter_app/models/movie_response.dart';
import 'package:imdb_flutter_app/themes/export_themes.dart';
import 'package:imdb_flutter_app/utilities/export_utilities.dart';
import 'package:imdb_flutter_app/utilities/size_config.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieResponse movieDetails;

  MovieDetailsScreen({this.movieDetails});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(
                      width: double.maxFinite,
                      child: Image.network(
                        movieDetails.poster,
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.deviceWidth * 7.5),
                    child: IconContainer(
                      onPressed: () => Navigator.pop(context),
                      iconName: 'eva_arrow-ios-back-fill',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: SizeConfig.deviceHeight * 5,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.deviceWidth * 10,
                            ),
                            child: Text(
                              movieDetails.title,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.standardTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: SizeConfig.deviceHeight * 5),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: SizeConfig.deviceHeight * 2,
                              left: SizeConfig.deviceWidth * 10,
                            ),
                            child: Text(
                              movieDetails.genre,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.standardTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: SizeConfig.deviceHeight * 2.5,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.deviceHeight * 7.5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconContainer(
                      iconName: 'Vector 27',
                      allPadding: 3,
                      iconSize: SizeConfig.deviceHeight * 3,
                    ),
                    IconContainer(
                      iconName: 'Path-1',
                      allPadding: 3,
                      iconSize: SizeConfig.deviceHeight * 3,
                    ),
                    IconContainer(
                      iconName: 'Path',
                      allPadding: 3,
                      iconSize: SizeConfig.deviceHeight * 3,
                    )
                  ],
                ),
              ),
              DetailsContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.deviceHeight * 1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating:
                                double.parse('${movieDetails.imdbRating}') / 2,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.deviceWidth * 1,
                            ),
                            itemBuilder: (context, _) => CustomIconButton(
                              iconName: 'Star 1',
                            ),
                            itemSize: SizeConfig.deviceWidth * 5,
                            onRatingUpdate: (newRating) {},
                          ),
                          Text(
                            '${double.parse('${movieDetails.imdbRating}') / 2}',
                            style: AppTextStyles.standardTextStyle.copyWith(
                              color: AppColors.yellowColor,
                              fontSize: SizeConfig.deviceHeight * 2.5,
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: movieDetails.ratings
                          .map(
                            (e) => MovieAndItsReviewWidget(
                              title: e.source,
                              review: e.value,
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
              DetailsContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconTextRow(
                      iconName: 'Group 357',
                      title: movieDetails.year,
                    ),
                    IconTextRow(
                      iconName: 'Vector',
                      title: movieDetails.country,
                    ),
                    IconTextRow(
                      iconName: 'Group 356',
                      title: movieDetails.runtime,
                    ),
                    IconTextRow(
                      iconName: 'Group 358',
                      title: movieDetails.language,
                    ),
                  ],
                ),
              ),
              DetailsContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.deviceHeight * 1,
                      ),
                      child: Text(
                        'Plot',
                        textAlign: TextAlign.start,
                        style: AppTextStyles.standardTextStyle.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: SizeConfig.deviceHeight * 2.75,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.deviceHeight * 2,
                      ),
                      child: Text(
                        movieDetails.plot,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.standardTextStyle.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: SizeConfig.deviceHeight * 2.25),
                      ),
                    ),
                    TitleAndContributorsWidget(
                      title: 'Director',
                      contributors: movieDetails.director.split(','),
                    ),
                    TitleAndContributorsWidget(
                      title: 'Writers',
                      contributors: movieDetails.writer.split(','),
                    ),
                    TitleAndContributorsWidget(
                      title: 'Actors',
                      contributors: movieDetails.actors.split(','),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
