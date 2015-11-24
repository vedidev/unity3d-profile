using System;
using System.Collections;
using System.Collections.Generic;

namespace Soomla.Profile
{
    public class UserProfileUpdatedEvent
    {
        public readonly UserProfile UserProfile;

        public UserProfileUpdatedEvent(UserProfile userProfile)
        {
            this.UserProfile = userProfile;
        }
    }
}
