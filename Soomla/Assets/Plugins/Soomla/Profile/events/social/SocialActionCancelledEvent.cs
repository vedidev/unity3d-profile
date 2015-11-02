using UnityEngine;
using System;

namespace Soomla.Profile
{
    public class SocialActionCancelledEvent : BaseSocialActionEvent
    {
        public SocialActionCancelledEvent(Provider provider,
                                          SocialActionType socialActionType, string payload) : base(provider, socialActionType, payload)
        {

        }
    }
}
