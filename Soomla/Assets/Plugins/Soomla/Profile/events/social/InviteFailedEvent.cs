using UnityEngine;
using System;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class InviteFailedEvent : BaseSocialActionEvent
    {
        public readonly string ErrorDescription;

        public InviteFailedEvent(Provider provider,
                                  SocialActionType getFeedType,
                                  string errorDescription, string payload) : base(provider, getFeedType, payload)
        {
            ErrorDescription = errorDescription;
        }
    }
}
