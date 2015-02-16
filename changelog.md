### v2.0.6 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.5...v2.0.6)

* Changes
  * Updated new changes from submodules

### v2.0.5 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.4...v2.0.5)

* Fixes
  * Making profile initialize event wait for FB to complete initialization
  * Adding missing social action failed event from native android
  * Login cancelled will be fired when going back from Twitter login web view (android)

### v2.0.4 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.3...v2.0.4)

* New Features
  * Ability to page contacts (supported in Facebook only)
  * Ability to invite friends (supported in Facebook only)

* Fixes
  * Pushing get contacts events to native

### v2.0.3 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.2...v2.0.3)

* New Features
  * Fully supporting uploadImage for all social platforms (Facebook, Twitter and Google+)
  * Added option for uploading image with byte array and Texture

* Fixes
  * Making profile remove the UserProfile from storage when doing Logout

### v2.0.2 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.1...v2.0.2)

* New Features
  * Supporting Facebook SDK v6.x
  * Supporting new features from submodules

* Fixes
  * Moving reward handout before event sending


### v2.0.1 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v1.0...v2.0.1)

* Changes
  * Getting google-play-services_lib from sdk
  * Disabling removal of plugins
  * Added debug.keystore for the sake of running example with google+
  * Documentation for social platform support for each social action
  * Updated new changes from submodules

* Fixes
  * Fixing google play services issues

### v2.0.0 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v1.0...v2.0.0)

* New Features
  * The module is integrated with Facebook, Google Plus and Twitter
  * Ability to preform following actions on multiple social networks (parallel):
    * Login/Logout
    * Update status
    * Update Story (supported fully in Facebook only)
    * Upload image (supported on Facebook only)
    * Get user profile + store it on the device
    * Get user's contacts (not all social networks provide all information)
    * Get user's most recent feed (not supported in Google Plus)

### v1.0.0

* Features
  * Facebook integration only
