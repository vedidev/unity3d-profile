*This project is a part of The [SOOMLA](http://www.soom.la) Framework, which is a series of open source initiatives with a joint goal to help mobile game developers do more together. SOOMLA encourages better game design, economy modeling, social engagement, and faster development.*

Haven't you ever wanted a status sharing one liner that looks like this ?!

```cs
SoomlaProfile.UpdateStatus(Provider.FACEBOOK, "I love this game !", new VirtualItemReward( ... ));
```

unity3d-profile
---

**November 17th**: v2.0 **unity3d-profile** supports Facebook, Google+ and Twitter

*SOOMLA's Profile Module for Unity3d*

* More documentation and information in SOOMLA's [Knowledge Base](http://know.soom.la/docs/platforms/unity)  
* For issues you can use the [issues](https://github.com/soomla/unity3d-profile/issues) section or SOOMLA's [Answers Website](http://answers.soom.la)

unity3d-profile is the Unity3d flavor of SOOMLA's Profile Module.

![SOOMLA's Profile Module](http://know.soom.la/img/tutorial_img/soomla_diagrams/Profile.png)


## Download

####Pre baked unitypackage: [unity3d-profile v1.0](http://bit.ly/1sUDdG0)  

## Debugging

If you want to see full debug messages from android-store and ios-store you just need to check the box that says "Debug Messages" in the SOOMLA Settings.
Unity debug messages will only be printed out if you build the project with _Development Build_ checked.

## Cloning

There are some necessary files in submodules linked with symbolic links. If you're cloning the project make sure you clone it with the `--recursive` flag.

```
$ git clone --recursive git@github.com:soomla/unity3d-profile.git
```

## Getting Started

1. Download and import [soomla-unity3d-core.unitypackage](https://github.com/soomla/unity3d-profile/blob/master/soomla-unity3d-core.unitypackage) and [unity3d-profile.unitypackage](http://bit.ly/1sUDdG0). If you also want to use Store related rewards you'll need to go over the instructions of [unity3d-store](https://github.com/soomla/unity3d-store)
2. Drag the `CoreEvents` and `ProfileEvents` Prefabs from `Assets/Soomla/Prefabs` into your scene. You should see it listed in the "Hierarchy" panel. [This step MUST be done for unity3d-profile to work properly!]
3. On the menu bar click "Window -> Soomla -> Edit Settings" and change the value for "Soomla Secret".
    - _Soomla Secret_ - is an encryption secret you provide that will be used to secure your data. (If you used versions before v1.5.2 this secret MUST be the same as Custom Secret)  
    **Choose the secret wisely. You can't change them after you launch your game!**
    - _Social Platforms_ - select the social platform which you want to integrate with
4. Initialize `SoomlaProfile`:

    ```cs
    SoomlaProfile.Initialize();
    ```

    > Initialize `SoomlaProfile` ONLY ONCE when your application loads.

    > Initialize `SoomlaProfile` in the `Start()` function of a "MonoBehaviour" and **NOT** in the `Awake()` function. SOOMLA has its own "MonoBehaviour" and it needs to be "Awakened" before you initialize.

    > `SoomlaProfile` will initialize the social providers. Don't initialize them on your own (for example, **don't** call `FB.Init()` !).

8. Call all the social functions you can from `SoomlaProfile` class. Otherwise, you won't be able to work with SOOMLA correctly. You can still call functions from the `FB` class but only those that are not provided by `SoomlaProfile`.

9. Register event handlers in order to be notified about in-app purchasing related events. refer to the [Event Handling](https://github.com/soomla/unity3d-profile#event-handling) section for more information.

And that's it ! You have social capabilities for your game.

## What's next? Selecting Social Providers

**unity3d-profile** is structured to support multiple social networks (Facebook, Twitter, Google+, etc.), at the time of writing this the framework only supports Facebook, Twitter and Google+ integration.
Note that currently only Facebook is supported for work in Editor.

### Facebook

1. Go over the guidelines for downloading and importing the official Facebook SDK: https://developers.facebook.com/docs/unity/getting-started/canvas    - You don't need to initialize FB. SoomlaProfile will initialize it for you.

    > **NOTE:** unity3d-profile currently supports FB Unity SDK v5.1.  Make sure to use that one, support for v6.0 is in the works.

2. Create an empty folder named `Facebook` under `Assets/Plugins`
3. Move the folder `Scripts` from `Assets/Facebook` to `Assets/Plugins/Facebook`  -  SOOMLA works from the Plugins folder so it'll be available to UnityScript devs. So you'll have to move Facebook in there as well.

    > When working under Unity version > 4.5.0 (targeting iOS) please follow these extra steps:

    > 1. Edit the file `Assets/Facebook/Editor/iOS/fixup.projmods`

    > 1. Under `headerpaths` change `Facebook/Scripts` to `Plugins/Facebook/Scripts`

### Twitter
Twitter is supported out-of-the-box, authentication is done either through the signed in Twitter account (iOS 5+) or through web browser (fallback). Follow the next steps to make it work:

1. Create your Twitter app at https://apps.twitter.com/
2. On the menu bar click "Window -> Soomla -> Edit Settings" and toggle the "twitter" check box and fill in "Consumer Key" and "Consumer Secret".

    > Consumer Key and Consumer Secret are located under "Keys and Access Tokens" of your twitter app.

### Google Plus

##### Targeting iOS:
  1. Follow [Step 1. Creating the Google Developers Console project](https://developers.google.com/+/mobile/ios/getting-started#step_1_creating_the_console_name_project) and create a google+ app for iOS.

    > Set the BUNDLE ID of your google+ app to the Bundle Identifier of your unity3d app.

  2. On the menu bar click "Window -> Soomla -> Edit Settings", toggle "google" check box and fill the "Client Id" text box with "CLIENT ID" value of your google+ app.


##### Targeting Android:
  1. Follow [Step 1: Enable the Google+ API](https://developers.google.com/+/mobile/android/getting-started#step_1_enable_the_google_api) and create a google+ app for Android.

  > Set the PACKAGE NAME of your google+ app to the value of "Bundle Identifier" of your unity3d app.

  > To create a custom keystore file with unity3d, navigate to "Player Settings" -> "Publishing Settings" and click "Create New Keystore". In your google+ app page, navigate to "API & Auth " -> "Credentials" and update the value of "CERTIFICATE FINGERPRINT (SHA1)" with the SHA-1 of your new keystore file.
  
  1. Navigate to "Window -> Soomla -> Edit Settings" and toggle "google" check box (ignore the Client Id text box).

  1. Navigate to "Publishing Settings" and browse for your keystore file (debug.keystore/custom keystore).

## What's next? Social Actions.

The Profile module is young and only a few social actions are provided. We're always working on extending the social capabilities and hope the community will "jump" on the chance to create them and even connect them with SOOMLA's modules (Store and LevelUp).

Here is an example of sharing a story on the user's feed:

After you initialized SoomlaProfile and logged the user in:

```cs
  SoomlaProfile.UpdateStory(
                  Provider.FACEBOOK,
                  "Check out this great story by SOOMLA !",  
                  "SOOMLA is 2 years young!",
                  "SOOMLA is GROWing",
                  "soomla_2_years",
                  "http://blog.soom.la/2014/08/congratulations-soomla-is-2-years-young.html",
                  "http://blog.soom.la/wp-content/uploads/2014/07/Birthday-bot-300x300.png",
                  new BadgeReward("sherriff", "Sheriff"));
```

And that's it! unity3d-profile knows how to contact Facebook and share a story with the information you provided.  
It will also give the user the `BadgeReward` we configured in the function call.


Storage
---

unity3d-profile is caching user information on the device. You can access it through:

```cs
UserProfile userProfile = SoomlaProfile.GetStoredUserProfile(Provider.FACEBOOK);
```

The on-device storage is encrypted and kept in a SQLite database. SOOMLA is preparing a cloud-based storage service that will allow this SQLite to be synced to a cloud-based repository that you'll define.

Event Handling
---

SOOMLA lets you subscribe to profile events, get notified and implement your own application specific behavior to those events.

> Your behavior is an addition to the default behavior implemented by SOOMLA. You don't replace SOOMLA's behavior.

The 'ProfileEvents' class is where all event go through. To handle various events, just add your specific behavior to the delegates in the Events class.

For example, if you want to 'listen' to a MarketPurchase event:

```cs
StoreEvents.OnMarketPurchase += onMarketPurchase;

ProfileEvents.OnLoginFinished += (UserProfile UserProfile) => {
			Soomla.SoomlaUtils.LogDebug("My Perfect Game", "login finished with profile: " + UserProfile.toJSONObject().print());
			SoomlaProfile.GetContacts(Provider.FACEBOOK);
};
```

## Facebook Caveats

1. See [iOS Facebook Caveats](https://github.com/soomla/ios-profile#facebook-caveats)
1. See [Android Facebook Caveats](https://github.com/soomla/android-profile#facebook-caveats)

## Twitter Caveats

1. Have you enabled twitter in "Widow -> Soomla -> Edit Settings" and supplied the correct Consumer Key and Secret?

## Google Plus Caveats

1. Have you enabled google in "Widow -> Soomla -> Edit Settings"?
1. Have you supplied the correct Client Id (when targeting iOS)?
1. Did you sign your unity3d app with keystore file with SHA-1 identical to "CERTIFICATE FINGERPRINT (SHA1)" of your google+ app?

Contribution
---
SOOMLA appreciates code contributions! You are more than welcome to extend the capabilities of SOOMLA.

Fork -> Clone -> Implement -> Add documentation -> Test -> Pull-Request.

IMPORTANT: If you would like to contribute, please follow our [Documentation Guidelines](https://github.com/soomla/unity3d-store/blob/master/documentation.md
). Clear, consistent comments will make our code easy to understand.

## SOOMLA, Elsewhere ...

+ [Framework Website](http://www.soom.la/)
+ [Knowledge Base](http://know.soom.la/)


<a href="https://www.facebook.com/pages/The-SOOMLA-Project/389643294427376"><img src="http://know.soom.la/img/tutorial_img/social/Facebook.png"></a><a href="https://twitter.com/Soomla"><img src="http://know.soom.la/img/tutorial_img/social/Twitter.png"></a><a href="https://plus.google.com/+SoomLa/posts"><img src="http://know.soom.la/img/tutorial_img/social/GoogleP.png"></a><a href ="https://www.youtube.com/channel/UCR1-D9GdSRRLD0fiEDkpeyg"><img src="http://know.soom.la/img/tutorial_img/social/Youtube.png"></a>

License
---
Apache License. Copyright (c) 2012-2014 SOOMLA. http://www.soom.la
+ http://opensource.org/licenses/Apache-2.0
