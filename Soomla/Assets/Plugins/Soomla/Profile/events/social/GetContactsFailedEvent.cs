using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class GetContactsFailedEvent : BaseSocialActionEvent
    {
        public readonly string ErrorDescription;

        public readonly bool FromStart;

        public GetContactsFailedEvent(Provider provider,
                                      SocialActionType socialActionType,
                                      string errorDescription, bool fromStart, string payload): base(provider, socialActionType, payload)
        {
            this.ErrorDescription = errorDescription;
            this.FromStart = fromStart;
        }
    }
}
