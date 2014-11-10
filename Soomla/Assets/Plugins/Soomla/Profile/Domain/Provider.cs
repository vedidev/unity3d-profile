/// Copyright (C) 2012-2014 Soomla Inc.
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///      http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

using System;
namespace Soomla.Profile
{
	/// <summary>
	/// A string enumeration of available social providers. Currently, the only Provider available 
	/// with SOOMLA is Facebook, but in the future more providers will be supported. 
	/// </summary>
	public sealed class Provider
	{
		private readonly string name;

		public static readonly Provider FACEBOOK = new Provider ("facebook");
		public static readonly Provider FOURSQUARE = new Provider ("foursquare");
		public static readonly Provider GOOGLE = new Provider ("google");
		public static readonly Provider LINKEDIN = new Provider ("linkedin");
		public static readonly Provider MYSPACE = new Provider ("myspace");
		public static readonly Provider TWITTER = new Provider ("twitter");
		public static readonly Provider YAHOO = new Provider ("yahoo");
		public static readonly Provider SALESFORCE = new Provider ("salesforce");
		public static readonly Provider YAMMER = new Provider ("yammer");
		public static readonly Provider RUNKEEPER = new Provider ("runkeeper");
		public static readonly Provider INSTAGRAM = new Provider ("instagram");
		public static readonly Provider FLICKR = new Provider ("flickr");

		/// <summary>
		/// Constructor.
		/// </summary>
		/// <param name="name">Name of the social provider.</param>
		private Provider(string name){
			this.name = name;
		}

		//// <summary>
		/// Converts this provider into a string. 
		/// </summary>
		/// <returns>A string representation of the current <c>Provider</c>.</returns>
		public override string ToString(){
			return name;
		}

		/// <summary>
		/// Converts the given string into a <c>Provider</c>
		/// </summary>
		/// <returns>The string.</returns>
		/// <param name="providerTypeStr">The string to convert into a <c>Provider</c>.</param>
		public static Provider fromString(string providerTypeStr) {
			switch(providerTypeStr) {
			case("facebook"):
				return FACEBOOK;
			case("foursquare"):
				return FOURSQUARE;
			case("google"):
				return GOOGLE;
			case("linkedin"):
				return LINKEDIN;
			case("myspace"):
				return MYSPACE;
			case("twitter"):
				return TWITTER;
			case("yahoo"):
				return YAHOO;
			case("salesforce"):
				return SALESFORCE;
			case("yammer"):
				return YAMMER;
			case("runkeeper"):
				return RUNKEEPER;
			case("instagram"):
				return INSTAGRAM;
			case("flickr"):
				return FLICKR;
			default:
				return null;
			}
		}

		/// <summary>
		/// Converts the given int into a <c>Provider</c>
		/// </summary>
		/// <returns>The int.</returns>
		/// <param name="providerTypeInt">The string to convert into a <c>Provider</c>.</param>
		public static Provider fromInt(int providerTypeInt) {
			switch(providerTypeInt) {
			case 0:
				return FACEBOOK;
			case 1:
				return FOURSQUARE;
			case 2:
				return GOOGLE;
			case 3:
				return LINKEDIN;
			case 4:
				return MYSPACE;
			case 5:
				return TWITTER;
			case 6:
				return YAHOO;
			case 7:
				return SALESFORCE;
			case 8:
				return YAMMER;
			case 9:
				return RUNKEEPER;
			case 10:
				return INSTAGRAM;
			case 11:
				return FLICKR;
			default:
				return null;
			}
		}
	}
}

