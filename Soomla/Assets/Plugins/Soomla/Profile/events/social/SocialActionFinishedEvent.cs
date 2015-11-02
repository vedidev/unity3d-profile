using UnityEngine;
using System;

namespace Soomla.Profile
{
    public class SocialActionFinishedEvent : BaseSocialActionEvent
    {
        public SocialActionFinishedEvent(Provider provider,
                                         SocialActionType socialActionType, string payload) : base(provider, socialActionType, payload)
        {

        }
    }
}
