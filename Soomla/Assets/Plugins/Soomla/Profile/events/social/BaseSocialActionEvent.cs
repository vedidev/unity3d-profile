using UnityEngine;
using System;

namespace Soomla.Profile
{
    public abstract class BaseSocialActionEvent
    {

        public readonly Provider Provider;

        public readonly string Payload;

        public readonly SocialActionType SocialActionType;

        protected BaseSocialActionEvent(Provider provider, SocialActionType socialActionType, string payload)
        {
            Provider = provider;
            SocialActionType = socialActionType;
            Payload = payload;
        }
    }
}
