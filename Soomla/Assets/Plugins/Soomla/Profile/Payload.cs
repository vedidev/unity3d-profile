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
using UnityEngine;
namespace Soomla.Profile
{
	/// <summary>
	/// This class represents a complex payload.
	/// Based on user payload, any additional information passed to native 
	/// can be stored here (for example reward IDs)
	/// </summary>
	public class Payload
	{
		public Payload (string userPayload, string rewardId = "")
		{
			this._userPayload = userPayload;
			this._rewardId = rewardId;
		}

		public Payload(JSONObject jsonPayload)
		{
			this._userPayload = jsonPayload [USER_PAYLOAD].str;
			this._rewardId = jsonPayload [REWARD_ID].str;
		}

		public JSONObject toJSONObject()
		{
			JSONObject obj = new JSONObject(JSONObject.Type.OBJECT);
			obj.AddField(USER_PAYLOAD, this._userPayload);
			obj.AddField(REWARD_ID, this._rewardId);
			return obj;
		}

		public string UserPayload
		{
			get 
			{ 
				return _userPayload; 
			}
			set 
			{
				_userPayload = value; 
			}
		}

		public string RewardId
		{
			get 
			{ 
				return _rewardId; 
			}
			set 
			{
				_rewardId = value; 
			}
		}

		private string _userPayload;
		private string _rewardId;

		private const string USER_PAYLOAD = "userPayload";
		private const string REWARD_ID = "rewardId";
	}
}

