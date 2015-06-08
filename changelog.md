### v2.1.2 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.1...v2.1.2)

* Fixes
  * fixed pagination in GetContacts
  * multiShare crash on iPad with iOS8
* Changes
  * improve working with the permissions in FB

### v2.1.1 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.1.0...v2.1.1)

* Fixes
  * Fix `publish_actions` permission

* Changes
  * Upgraded to latest version of FB SDK

### v2.1.0 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.8...v2.1.0)

* New Features
  * Implemented Pagination for GetContacts and GetFeed
  * Implemented multi-sharing (sharing with the native functionality of your target platform)
  * Implemented methods to show confirmation dialog before some actions (not supported for FB)
  * Supporting permissions param in FB

* Fixes
 * Fixed an issue on Google+ & Android where cancellation of login didn't work properly

### v2.0.8 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.7...v2.0.8)

* Changes
  * Making Store module Unity 5 compatible

### v2.0.7 [view commit logs](https://github.com/soomla/unity3d-profile/compare/v2.0.6...v2.0.7)

* Changes
  * Added core post build script

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
