using UnityEngine;
using System;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class GetFeedFailedEvent : BaseSocialActionEvent
    {
        public readonly string ErrorDescription;

        public readonly bool FromStart;

        public GetFeedFailedEvent(Provider provider,
                                  SocialActionType getFeedType,
                                  string errorDescription, bool fromStart, string payload) : base(provider, getFeedType, payload)
        {
            ErrorDescription = errorDescription;
            FromStart = fromStart;
        }
    }
}
