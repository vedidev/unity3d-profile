using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class GetContactsStartedEvent : BaseSocialActionEvent
    {
        public readonly bool FromStart;

        public GetContactsStartedEvent(Provider provider,
                                       SocialActionType socialActionType, bool fromStart, string payload): base(provider, socialActionType, payload)
        {
            this.FromStart = fromStart;
        }
    }
}
