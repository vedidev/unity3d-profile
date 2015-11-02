using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class LoginFinishedEvent
    {
        public readonly UserProfile UserProfile;

        public readonly bool AutoLogin;

        public readonly string Payload;

        public LoginFinishedEvent(UserProfile userProfile, bool autoLogin, string payload)
        {
            UserProfile = userProfile;
            AutoLogin = autoLogin;
            Payload = payload;
        }

        public Provider getProvider()
        {
            return UserProfile.getProvider();
        }

    }
}
