using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class LogoutFinishedEvent
    {
        public readonly IProvider.Provider Provider;

        public LogoutFinishedEvent(Provider provider)
        {
            Provider = provider;
        }
    }
}