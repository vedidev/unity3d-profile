
#import "UnityProfileEventDispatcher.h"
#import "SoomlaEventHandling.h"
#import "UserProfileEventHandling.h"
#import "UserProfile.h"
#import "SocialActionUtils.h"
#import "Reward.h"
#import "SoomlaUtils.h"
#import "UserProfileUtils.h"

extern "C"{
    
    // events pushed from external provider (Unity FB SDK etc.)
    
    void soomlaProfile_PushEventLoginStarted (const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [UserProfileEventHandling postLoginStarted:provider];
    }
    void soomlaProfile_PushEventLoginFinished(const char* sUserProfileJson) {
        NSString *userProfileJson = [NSString stringWithUTF8String:sUserProfileJson];
        UserProfile* userProfile = [[UserProfile alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:userProfileJson]];
        [UserProfileEventHandling postLoginFinished:userProfile];
    }
    void soomlaProfile_PushEventLoginFailed(const char* sProvider, const char* sMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        [UserProfileEventHandling postLoginFailed:provider withMessage:message];
    }
    void soomlaProfile_PushEventLoginCancelled(const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [UserProfileEventHandling postLoginCancelled:provider];
    }
    void soomlaProfile_PushEventLogoutStarted(const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [UserProfileEventHandling postLoginStarted:provider];
    }
    void soomlaProfile_PushEventLogoutFinished(const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [UserProfileEventHandling postLogoutFinished:provider];
    }
    void soomlaProfile_PushEventLogoutFailed(const char* sProvider, const char* sMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        [UserProfileEventHandling postLogoutFailed:provider withMessage:message];
    }
    void soomlaProfile_PushEventSocialActionStarted(const char* sProvider, const char* sActionType) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        [UserProfileEventHandling postSocialActionStarted:provider withType:socialActionType];
    }
    void soomlaProfile_PushEventSocialActionFinished(const char* sProvider, const char* sActionType) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        [UserProfileEventHandling postSocialActionFinished:provider withType:socialActionType];
    }
    void soomlaProfile_PushEventSocialActionCancelled(const char* sProvider, const char* sActionType) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        [UserProfileEventHandling postSocialActionCancelled:provider withType:socialActionType];
    }
    void soomlaProfile_PushEventSocialActionFailed(const char* sProvider, const char* sActionType,  const char* sMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        [UserProfileEventHandling postSocialActionFailed:provider withType:socialActionType withMessage:message];
    }
    
    //    void pushEventGetContactsStarted(enum SocialActionType socialActionType) {
    //
    //    }
    //    void pushEventGetContactsFinished(enum SocialActionType socialActionType, const char** contacts) {
    //
    //    }
    //    void pushEventGetContactsFailed(enum SocialActionType socialActionType, const char* message) {
    //
    //    }

}

@implementation UnityProfileEventDispatcher

- (id) init {
    if (self = [super init]) {
        [UserProfileEventHandling observeAllEventsWithObserver:self withSelector:@selector(handleEvent:)];
    }
    
    return self;
}

- (void)handleEvent:(NSNotification*)notification{
    if ([notification.name isEqualToString:EVENT_UP_PROFILE_INITIALIZED]) {
        UnitySendMessage("ProfileEvents", "onSoomlaProfileInitialized", "");
    }
    else if ([notification.name isEqualToString:EVENT_UP_USER_RATING]) {
        UnitySendMessage("ProfileEvents", "onUserRatingEvent", "");
    }
    else if ([notification.name isEqualToString:EVENT_UP_USER_PROFILE_UPDATED]) {
        NSDictionary* userInfo = [notification userInfo];
        UserProfile *userProfile = [userInfo valueForKey:DICT_ELEMENT_USER_PROFILE];
        NSString *userProfileJson = [SoomlaUtils dictToJsonString:[userProfile toDictionary]];
        
        NSString* jsonStr = [SoomlaUtils dictToJsonString:@{@"userProfile":userProfileJson
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onUserProfileUpdated"
                                     withFilter:@([userProfile provider])];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber *provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        UserProfile* userProfile = [userInfo valueForKey:DICT_ELEMENT_USER_PROFILE];
        NSString *userProfileJson = [SoomlaUtils dictToJsonString:[userProfile toDictionary]];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"userProfile":userProfileJson,
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginFinished"
                                     withFilter:@([userProfile provider])];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_CANCELLED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginCancelled"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginFailed"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue]}];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutFinished"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutFailed"
                                     withFilter:provider];
        
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"socialActionType": [[userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE] stringValue],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"socialActionType": [[userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE] stringValue],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_CANCELLED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"socialActionType": [[userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE] stringValue],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionCancelled"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"socialActionType": [[userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE] stringValue],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSArray* contacts = [userInfo valueForKey:DICT_ELEMENT_CONTACTS];
        NSMutableArray* contactsJsonArray = [NSMutableArray array];
        for (int i = 0; i < [contacts count]; i++) {
            NSString *currentContactJson = [SoomlaUtils dictToJsonString:@{@"userProfile":
                                                                               [[contacts objectAtIndex:i] toDictionary]
                                                                           }];
            [contactsJsonArray addObject:currentContactJson];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"contacts":[SoomlaUtils arrayToJsonString:contactsJsonArray],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetFeedStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSArray* feeds = [userInfo valueForKey:DICT_ELEMENT_FEEDS];
        
        NSMutableArray* feedsJsonArray = [NSMutableArray array];
        for (int i = 0; i < [feeds count]; i++) {
            NSString *currentFeedJson = [SoomlaUtils dictToJsonString:@{@"feed":
                                                                               [[feeds objectAtIndex:i] toDictionary]
                                                                           }];
            [feedsJsonArray addObject:currentFeedJson];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"feeds":[SoomlaUtils arrayToJsonString:feedsJsonArray]
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetFeedFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":[provider stringValue],
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetFeedFailed"
                                      withFilter:provider];
    }
}

//wrapper for UnitySendMessage
//send only to providers with native implementation
+ (void) sendMessage:(NSString*) message toRecepient:(NSString*) callbackName withFilter:(NSNumber *) provider{
    //don't send for facebook
    if (provider == 0)
        return;
    UnitySendMessage("ProfileEvents", [callbackName UTF8String], [message UTF8String]);
}

@end
