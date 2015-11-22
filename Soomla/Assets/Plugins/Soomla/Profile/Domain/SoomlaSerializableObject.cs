/// Copyright (C) 2012-2015 Soomla Inc.
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

using UnityEngine;
using System.Runtime.InteropServices;
using System;
using System.Collections.Generic;

namespace Soomla.Profile {


	public class SoomlaSerializableObject {

		private const string TAG = "SOOMLA UserProfile";

		/// <summary>
		/// The provider that this user profile belongs to, such as Facebook, Twitter, etc.
		/// </summary>
		public Provider Provider;

		/** User profile information **/
		public string ProfileId;
		public string Email;
		public string Username;
		public string FirstName;
		public string LastName;
		public string AvatarLink;
		public string Location;
		public string Gender;
		public string Language;
		public string Birthday;
		public readonly Dictionary<String, JSONObject> Extra;

		/// <summary>
		/// Constructor.
		/// </summary>
		/// <param name="provider">The provider this object belongs to.</param>
		protected SoomlaSerializableObject(Provider provider)
		{
			this.Provider = provider;
		}


		/// <summary>
		/// Constructor.
		/// Generates an instance of class from the given <c>JSONObject</c>.
		/// </summary>
		/// <param name="jsonUP">A JSONObject representation of the wanted class.</param>
		public virtual SoomlaSerializableObject(JSONObject jsonUP) {
			this.Provider = Provider.fromString(jsonUP[PJSONConsts.UP_PROVIDER].str);
		}

		/// <summary>
		/// Converts the current class to a JSONObject.
		/// </summary>
		/// <returns>A <c>JSONObject</c> representation of the current class.</returns>
		public virtual JSONObject toJSONObject() {
			JSONObject obj = new JSONObject(JSONObject.Type.OBJECT);
			obj.AddField(JSONConsts.SOOM_CLASSNAME, SoomlaUtils.GetClassName(this));
			obj.AddField(PJSONConsts.UP_PROVIDER, this.Provider.ToString());

			return obj;
		}

	}
}

