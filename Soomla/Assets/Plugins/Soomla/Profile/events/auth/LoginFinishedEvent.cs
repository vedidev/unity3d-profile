using System;
using System.Collections;

namespace Soomla.Profile
{
	public class LoginFinishedEvent : SoomlaEvent
	{
		public readonly UserProfile UserProfile;
		public readonly bool AutoLogin;
		public readonly string Payload;

		public LoginFinishedEvent (UserProfile userProfile, bool autoLogin, string payload):this(userProfile, autoLogin, payload,null)
		{

		}

		public LoginFinishedEvent (UserProfile userProfile, bool autoLogin, string payload, Object sender):base(sender)
		{
			UserProfile = userProfile;
			AutoLogin = autoLogin;
			Payload = payload;
		}

		public Provider getProvider ()
		{
			return UserProfile.Provider;
		}
	}
}
