using UnityEngine;
using System.Collections.Generic;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace Soomla.Profile
{
	#if UNITY_EDITOR
	[InitializeOnLoad]
	#endif
	public class ProfilePostBuildTool : ISoomlaPostBuildTool {

		#if UNITY_EDITOR

		static ProfilePostBuildTool instance = new ProfilePostBuildTool();
		static ProfilePostBuildTool()
		{
			SoomlaPostBuildTools.AddTool("Profile", instance);
		}

		#region ISoomlaPostBuildTool implementation

		public string GetToolMetaData (BuildTarget target)
		{
			if (target == BuildTarget.iPhone) {
				return GetProfileMetaIOS();
			}

			return null;
		}

		#endregion

		private string GetProfileMetaIOS ()
		{
			JSONObject result = new JSONObject();
			Dictionary<string, bool?> state = ProfileSettings.IntegrationState;

			foreach (var entry in state) {
				Provider targetProvider = Provider.fromString(entry.Key);
				if (entry.Value.HasValue && entry.Value.Value) {
					if (targetProvider == Provider.GOOGLE) {
						JSONObject googleJson = new JSONObject();
						googleJson.SetField("clientId", ProfileSettings.GPClientId);

						result.SetField(entry.Key, googleJson);
					}
					else if (targetProvider == Provider.TWITTER) {
						JSONObject twitterJson = new JSONObject();
						twitterJson.SetField("consumerKey", ProfileSettings.TwitterConsumerKey);
						
						result.SetField(entry.Key, twitterJson);
					}
				}
			}

			return result.ToString();
		}

		#endif
	}
}