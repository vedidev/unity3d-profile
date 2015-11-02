using UnityEngine;
using System;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class GetFeedStartedEvent : BaseSocialActionEvent
    {
        public readonly bool FromStart;

        public GetFeedStartedEvent(Provider provider,
                                   SocialActionType getFeedType, bool fromStart, string payload) : base(provider, getFeedType, payload)
        {
            FromStart = fromStart;
        }
    }
}
