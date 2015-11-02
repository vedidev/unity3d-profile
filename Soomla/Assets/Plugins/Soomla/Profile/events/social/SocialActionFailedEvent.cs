using UnityEngine;
using System;

namespace Soomla.Profile
{
    public class SocialActionFailedEvent : BaseSocialActionEvent
    {
        public readonly string ErrorDescription;

        public SocialActionFailedEvent(Provider provider,
                                       SocialActionType socialActionType,
                                       string errorDescription, string payload) : base(provider, socialActionType, payload)
        {
            ErrorDescription = errorDescription;
        }
    }
}
