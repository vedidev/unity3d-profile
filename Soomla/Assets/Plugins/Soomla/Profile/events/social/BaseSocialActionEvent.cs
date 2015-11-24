using System;

namespace Soomla.Profile
{
    public abstract class BaseSocialActionEvent
    {
		public readonly Provider Provider;
		public readonly string Payload;

		protected BaseSocialActionEvent(Provider provider) : this(provider, "") {

		}

		protected BaseSocialActionEvent(Provider provider, string payload) {
			this.Provider = provider;
			this.Payload = payload;
        }
    }
}
