# Project 1 - MoveMe

MoveMe is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 13 hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] Customize the UI.

The following **additional** features are implemented:


## Video Walkthrough

Here's a walkthrough of implemented user stories:

![gif walkthru](https://github.com/brianhillsley/MoveMe/blob/master/MoveMe_walkthru.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

Since I switched from TableViewController to CollecitonViewController there was a few issues I had with the set up and displaying content on the CollectionViewController.

## License

Copyright 2016 Brian Hillsley (as a part of Code Path University)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

-----------------------------------------------------------------------

# Project 2 - MoveMe

MoveMe is a movies app displaying box office and top rental DVDs using [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 20 hours spent in total (I spent a lot of time researching more topics)

## User Stories

The following **required** functionality is completed:

- [x] User can view movie details by tapping on a cell.
- [x] User can select from a tab bar for either **Now Playing** or **Top Rated** movies.
- [x] Customize the selection effect of the cell.

The following **optional** features are implemented:

- [x] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Made my own icons for now playing and top rated tabs.
## Video Walkthrough

Here's a walkthrough of implemented user stories:

![gif walkthru](https://github.com/brianhillsley/MoveMe/blob/master/MoveMe_walkthru.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

I actually redid the whole application due to a file system messup. I saw redoing both part 1 and part 2 of this project as extra review. So being patient and redoing the application was the hard part. For that reason the time spent on Project 1 has been increased to reflect redoing that part to include some of the extra features.

Additionally, CocoaPods, the dependency manager, continues to give me a hard time as I need to reinstall it on every reboot, which I have done 3 times. Something to do with permissions and security of OS El Capitan and Ruby Gems made it so I had to try several ways to install cocoapods.

Also,
I also customized the UI to include the search bar which was a part of the extra credit of from the flicks-app part 1 (last week).

## License

Copyright 2016 Brian Hillsley (as a part of Code Path University)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
