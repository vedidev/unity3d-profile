using UnityEngine;
using System;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class InviteCancelledEvent : BaseSocialActionEvent
    {
        public InviteCancelledEvent(Provider provider,
                                          SocialActionType socialActionType, string payload) : base(provider, socialActionType, payload)
        {
        }
    }
}
