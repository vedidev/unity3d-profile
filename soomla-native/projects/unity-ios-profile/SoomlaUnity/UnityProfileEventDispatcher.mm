
#import "UnityProfileEventDispatcher.h"
#import "SoomlaEventHandling.h"
#import "ProfileEventHandling.h"
#import "UserProfile.h"
#import "SocialActionUtils.h"
#import "Reward.h"
#import "SoomlaUtils.h"
#import "UserProfileUtils.h"

extern "C"{
    
    // events pushed from external provider (Unity FB SDK etc.)
    
    void soomlaProfile_PushEventLoginStarted (const char* sProvider, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginStarted:provider withPayload:payloadS];
    }
    void soomlaProfile_PushEventLoginFinished(const char* sUserProfileJson, const char* payload) {
        NSString *userProfileJson = [NSString stringWithUTF8String:sUserProfileJson];
        UserProfile* userProfile = [[UserProfile alloc] initWithDictionary:[SoomlaUtils jsonStringToDict:userProfileJson]];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginFinished:userProfile withPayload:payloadS];
    }
    void soomlaProfile_PushEventLoginFailed(const char* sProvider, const char* sMessage, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginFailed:provider withMessage:message withPayload:payloadS];
    }
    void soomlaProfile_PushEventLoginCancelled(const char* sProvider, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postLoginCancelled:provider withPayload:payloadS];
    }
    void soomlaProfile_PushEventLogoutStarted(const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [ProfileEventHandling postLogoutStarted:provider];
    }
    void soomlaProfile_PushEventLogoutFinished(const char* sProvider) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        [ProfileEventHandling postLogoutFinished:provider];
    }
    void soomlaProfile_PushEventLogoutFailed(const char* sProvider, const char* sMessage) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        [ProfileEventHandling postLogoutFailed:provider withMessage:message];
    }
    void soomlaProfile_PushEventSocialActionStarted(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionStarted:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventSocialActionFinished(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionFinished:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventSocialActionCancelled(const char* sProvider, const char* sActionType, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionCancelled:provider withType:socialActionType withPayload:payloadS];
    }
    void soomlaProfile_PushEventSocialActionFailed(const char* sProvider, const char* sActionType,  const char* sMessage, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString* actionType = [NSString stringWithUTF8String:sActionType];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        SocialActionType socialActionType = [SocialActionUtils actionStringToEnum:actionType];
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postSocialActionFailed:provider withType:socialActionType withMessage:message withPayload:payloadS];
    }
    void soomlaProfile_PushEventGetContactsStarted(const char* sProvider, bool fromStart, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        SocialActionType socialActionType = SocialActionType::GET_CONTACTS;
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetContactsStarted: provider withType: socialActionType withFromStart: fromStart withPayload:payloadS];
    }
    void soomlaProfile_PushEventGetContactsFinished(const char* sProvider, const char* sUserProfilesJson, const char* payload, bool hasMore) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        SocialActionType socialActionType = SocialActionType::GET_CONTACTS;
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        
        NSMutableArray *contacts = [NSMutableArray array];
        NSMutableArray *contactsDictArray = [SoomlaUtils jsonStringToArray:[NSString stringWithUTF8String:sUserProfilesJson]];
        if (contactsDictArray) {
            for (NSDictionary *contactDict in contactsDictArray) {
                UserProfile *contactProfile = [[UserProfile alloc] initWithDictionary:contactDict];
                if (contactProfile) {
                    [contacts addObject:contactProfile];
                }
            }
        }

        [ProfileEventHandling postGetContactsFinished:provider withType:socialActionType withContacts:contacts withPayload:payloadS withHasMore:hasMore];
    }
    void soomlaProfile_PushEventGetContactsFailed(const char* sProvider, const char* sMessage, bool fromStart, const char* payload) {
        NSString* providerIdS = [NSString stringWithUTF8String:sProvider];
        Provider provider = [UserProfileUtils providerStringToEnum:providerIdS];
        NSString *message = [NSString stringWithUTF8String:sMessage];
        SocialActionType socialActionType = SocialActionType::GET_CONTACTS;
        NSString* payloadS = [NSString stringWithUTF8String:payload];
        [ProfileEventHandling postGetContactsFailed:provider withType:socialActionType withMessage:message withFromStart: fromStart withPayload:payloadS];
    }

}

@implementation UnityProfileEventDispatcher

+ (void)initialize {
    static UnityProfileEventDispatcher* instance = nil;
    if (!instance) {
        instance = [[UnityProfileEventDispatcher alloc] init];
    }
}

- (id) init {
    if (self = [super init]) {
        LogDebug(@"UnityProfileEventDispatcher", @"INIT");
        [ProfileEventHandling observeAllEventsWithObserver:self withSelector:@selector(handleEvent:)];
    }
    
    return self;
}

- (void)handleEvent:(NSNotification*)notification{
    if ([notification.name isEqualToString:EVENT_UP_PROFILE_INITIALIZED]) {
        //TODO!: filter to GP and TW
        UnitySendMessage("ProfileEvents", "onSoomlaProfileInitialized", "");
    }
    else if ([notification.name isEqualToString:EVENT_UP_USER_PROFILE_UPDATED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_USER_PROFILE_UPDATED %@", userInfo);
        UserProfile *userProfile = [userInfo valueForKey:DICT_ELEMENT_USER_PROFILE];
        
        NSString* jsonStr = [SoomlaUtils dictToJsonString:@{@"userProfile":[userProfile toDictionary]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onUserProfileUpdated"
                                     withFilter:@([userProfile provider])];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_LOGIN_STARTED %@", userInfo);
        NSNumber *provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_LOGIN_FINISHED %@", userInfo);
        UserProfile* userProfile = [userInfo valueForKey:DICT_ELEMENT_USER_PROFILE];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"userProfile":[userProfile toDictionary],
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginFinished"
                                     withFilter:@([userProfile provider])];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_CANCELLED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSLog(@"EVENT_UP_LOGIN_CANCELLED %@", userInfo);
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLoginCancelled"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGIN_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
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
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider}];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutFinished"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_LOGOUT_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onLogoutFailed"
                                     withFilter:provider];
        
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionStarted"
                                     withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_CANCELLED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
                                                            @"payload": [userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
                                                            }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onSocialActionCancelled"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_SOCIAL_ACTION_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"socialActionType": [userInfo valueForKey:DICT_ELEMENT_SOCIAL_ACTION_TYPE],
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
        NSNumber* fromStart = [userInfo valueForKey:DICT_ELEMENT_FROM_START];

        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"fromStart":fromStart,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
        }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsStarted"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_FINISHED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber*hasMore = [userInfo valueForKey:DICT_ELEMENT_HAS_MORE];

        NSArray* contacts = [userInfo valueForKey:DICT_ELEMENT_CONTACTS];
        NSMutableArray* contactsJsonArray = [NSMutableArray array];
        for (int i = 0; i < [contacts count]; i++) {
            [contactsJsonArray addObject:[[contacts objectAtIndex:i] toDictionary]];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"contacts":contactsJsonArray,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD],
                @"hasMore": hasMore
        }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_CONTACTS_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        NSNumber* fromStart = [userInfo valueForKey:DICT_ELEMENT_FROM_START];

        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{
                @"provider":provider,
                @"message":[userInfo valueForKey:DICT_ELEMENT_MESSAGE],
                @"fromStart":fromStart,
                @"payload":[userInfo valueForKey:DICT_ELEMENT_PAYLOAD]
        }];
        
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetContactsFailed"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_STARTED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
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
            [feedsJsonArray addObject:[feeds objectAtIndex:i]];
        }
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
                                                            @"feeds":feedsJsonArray
                                                            }];
        [UnityProfileEventDispatcher sendMessage:jsonStr
                                     toRecepient:@"onGetFeedFinished"
                                      withFilter:provider];
    }
    else if ([notification.name isEqualToString:EVENT_UP_GET_FEED_FAILED]) {
        NSDictionary* userInfo = [notification userInfo];
        NSNumber* provider = [userInfo valueForKey:DICT_ELEMENT_PROVIDER];
        
        NSString *jsonStr = [SoomlaUtils dictToJsonString:@{@"provider":provider,
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
    if ([provider intValue] == 0)
        return;
    UnitySendMessage("ProfileEvents", [callbackName UTF8String], [message UTF8String]);
}

@end
