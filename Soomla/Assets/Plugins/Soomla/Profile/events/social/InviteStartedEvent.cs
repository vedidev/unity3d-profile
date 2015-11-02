using UnityEngine;
using System;

namespace Soomla.Profile
{
    public class InviteStartedEvent : BaseSocialActionEvent
    {
        public InviteStartedEvent(Provider provider,
                                   SocialActionType getFeedType, string payload) : base(provider, getFeedType, payload)
        {

        }
    }
}
