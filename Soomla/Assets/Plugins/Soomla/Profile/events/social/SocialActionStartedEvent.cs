using UnityEngine;
using System;

namespace Soomla.Profile
{
    public class SocialActionStartedEvent : BaseSocialActionEvent
    {
        public SocialActionStartedEvent(Provider provider,
                                        SocialActionType socialActionType, String payload) : base(provider, socialActionType, payload)
        {

        }
    }
}
