using UnityEngine;
using System;
using System.Collections;

namespace Soomla.Profile
{
    public class LogoutFailedEvent
    {
        public readonly Provider Provider;

        public readonly string ErrorDescription;

        public LogoutFailedEvent(Provider provider, string errorDescription)
        {
            Provider = provider;
            ErrorDescription = errorDescription;
        }
    }
}
