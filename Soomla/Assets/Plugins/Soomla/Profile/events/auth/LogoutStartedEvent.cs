using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class LogoutStartedEvent
    {
        public readonly Provider Provider;

        public LogoutStartedEvent(Provider provider)
        {
            Provider = provider;
        }
    }
}
