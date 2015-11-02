using UnityEngine;
using System;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class InviteFinishedEvent : BaseSocialActionEvent
    {
        public readonly string RequestId;

        public readonly List<string> InvitedIds;

        public InviteFinishedEvent(Provider provider,
                                  SocialActionType getFeedType, string requestId, List<string> invitedIds,
                                  string payload) : base(provider, getFeedType, payload)
        {
            RequestId = requestId;
            InvitedIds = invitedIds;
        }
    }
}
