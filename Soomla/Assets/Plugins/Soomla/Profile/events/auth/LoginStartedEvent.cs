using UnityEngine;
using System;
using System.Collections;

namespace Soomla.Profile
{
    public readonly Provider Provider;

    public readonly bool AutoLogin;

    public readonly string Payload;

    public class LoginStartedEvent
    {

        public LoginStartedEvent(Provider provider, bool autoLogin, String payload)
        {
            Provider = provider;
            AutoLogin = autoLogin;
            Payload = payload;
        }
    }
}
