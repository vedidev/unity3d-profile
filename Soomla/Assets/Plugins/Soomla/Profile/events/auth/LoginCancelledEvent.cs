using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class LoginCancelledEvent
    {
        public Provider Provider;

        public readonly bool AutoLogin;

        public readonly string Payload;

        public LoginCancelledEvent(Provider provider, bool autoLogin, string payload)
        {
            Provider = provider;
            AutoLogin = autoLogin;
            Payload = payload;
        }
    }
}