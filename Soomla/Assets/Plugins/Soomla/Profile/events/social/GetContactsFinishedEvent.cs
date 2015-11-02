using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class GetContactsFinishedEvent : BaseSocialActionEvent
    {
        public readonly List<UserProfile> Contacts;
        public readonly bool HasMore;

        public GetContactsFinishedEvent(Provider provider,
                                        SocialActionType socialActionType,
                                        List<UserProfile> contacts, string payload, bool hasMore) : base(provider, socialActionType, payload)
        {
            this.Contacts = contacts;
            this.HasMore = hasMore;
        }
    }
}
