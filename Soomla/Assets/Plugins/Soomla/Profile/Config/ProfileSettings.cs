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

using UnityEngine;
using System.IO;
using System;
using System.Collections.Generic;
using System.Linq;

#if UNITY_EDITOR
using UnityEditor;
#endif

namespace Soomla.Profile
{
	
	#if UNITY_EDITOR
	[InitializeOnLoad]
	#endif
	/// <summary>
	/// This class holds the store's configurations. 
	/// </summary>
	public class ProfileSettings : ISoomlaSettings
	{
		
		#if UNITY_EDITOR
		
		static ProfileSettings instance = new ProfileSettings();
		static ProfileSettings()
		{
			SoomlaEditorScript.addSettings(instance);
		}

		BuildTargetGroup[] supportedPlatforms = { BuildTargetGroup.Android, BuildTargetGroup.iPhone, 
			BuildTargetGroup.WebPlayer, BuildTargetGroup.Standalone};
		
		bool showAndroidSettings = (EditorUserBuildSettings.activeBuildTarget == BuildTarget.Android);
		bool showIOSSettings = (EditorUserBuildSettings.activeBuildTarget == BuildTarget.iPhone);

		Dictionary<string, bool?> socialIntegrationState = new Dictionary<string, bool?>();
		
		GUIContent fbAppId = new GUIContent("FB app Id:");
		GUIContent fbAppNS = new GUIContent("FB app namespace:");

		GUIContent profileVersion = new GUIContent("Profile Version [?]", "The SOOMLA Profile version. ");
		GUIContent profileBuildVersion = new GUIContent("Profile Build [?]", "The SOOMLA Profile build.");

		private ProfileSettings()
		{
			socialIntegrationState.Add(Provider.FACEBOOK.ToString(), null);
			socialIntegrationState.Add(Provider.GOOGLE.ToString(), null);
			socialIntegrationState.Add(Provider.TWITTER.ToString(), null);

			ReadSocialIntegrationState();
        }
        
        private void ReadSocialIntegrationState()
		{
			string value = string.Empty;
			SoomlaEditorScript.Instance.SoomlaSettings.TryGetValue("SocialIntegration", out value);

			if (value != null) {
				string[] savedIntegrations = value.Split(';');
				foreach (var savedIntegration in savedIntegrations) {
					string[] platformValue = savedIntegration.Split(',');
					string platform = platformValue[0];
					int state = int.Parse(platformValue[1]);

					bool? platformState = null;
					if (socialIntegrationState.TryGetValue(platform, out platformState)) {
						socialIntegrationState[platform] = (state > 0);
					}
				}
			}
		}

		private void WriteSocialIntegrationState()
		{
			List<string> savedStates = new List<string>();
			foreach (var entry in socialIntegrationState) {
				if (entry.Value != null) {
					savedStates.Add(entry.Key + "," + (entry.Value.Value ? 1 : 0));
				}
			}

			string result = string.Empty;
			if (savedStates.Count > 0) {
				result = string.Join(";", savedStates.ToArray());
			}

			SoomlaEditorScript.Instance.setSettingsValue("SocialIntegration", result);
			SoomlaEditorScript.DirtyEditor();
		}

		public void OnEnable() {
			// Generating AndroidManifest.xml
			//			ManifestTools.GenerateManifest();
		}
		
		public void OnModuleGUI() {
//			AndroidGUI();
//			EditorGUILayout.Space();
//			IOSGUI();

			IntegrationGUI();
		}
		
		public void OnInfoGUI() {
			SoomlaEditorScript.SelectableLabelField(profileVersion, "1.0");
			SoomlaEditorScript.SelectableLabelField(profileBuildVersion, "1");
			EditorGUILayout.Space();
		}
		
		public void OnSoomlaGUI() {
		}
		
		private void IOSGUI()
		{
			showIOSSettings = EditorGUILayout.Foldout(showIOSSettings, "iOS Build Settings");
			if (showIOSSettings)
			{
				EditorGUILayout.BeginHorizontal();
				SoomlaEditorScript.SelectableLabelField(fbAppId, FB_APP_ID_DEFAULT);
				EditorGUILayout.EndHorizontal();
				
				EditorGUILayout.Space();
				
				EditorGUILayout.BeginHorizontal();
				SoomlaEditorScript.SelectableLabelField(fbAppNS, PlayerSettings.productName);
				EditorGUILayout.EndHorizontal();
			}
			EditorGUILayout.Space();
		}
		
		private void AndroidGUI()
		{
			showAndroidSettings = EditorGUILayout.Foldout(showAndroidSettings, "Android Settings");
			if (showAndroidSettings)
			{
				EditorGUILayout.BeginHorizontal();
				SoomlaEditorScript.SelectableLabelField(fbAppId, FB_APP_ID_DEFAULT);
				EditorGUILayout.EndHorizontal();

				EditorGUILayout.Space();

				EditorGUILayout.BeginHorizontal();
				SoomlaEditorScript.SelectableLabelField(fbAppNS, PlayerSettings.productName);
				EditorGUILayout.EndHorizontal();

//				EditorGUILayout.Space();
//				EditorGUILayout.HelpBox("Social Provider Selection", MessageType.None);
			}
			EditorGUILayout.Space();
		}

		void IntegrationGUI()
		{
			EditorGUILayout.LabelField("Social Platforms:", EditorStyles.boldLabel);

			ReadSocialIntegrationState();

			EditorGUI.BeginChangeCheck();

			Dictionary<string, bool?>.KeyCollection keys = socialIntegrationState.Keys;
			for (int i = 0; i < keys.Count; i++) {
				string socialPlatform = keys.ElementAt(i);
				bool? socialPlatformState = socialIntegrationState[socialPlatform];

				EditorGUILayout.BeginHorizontal();
				
				bool doIntegrate = false;
				if (socialPlatformState != null) {
					socialIntegrationState[socialPlatform] = EditorGUILayout.Toggle(socialPlatform, socialPlatformState.Value);
					doIntegrate = socialPlatformState.Value;
				}
				else {
					doIntegrate = IsSocialPlatformDetected(socialPlatform);
					bool result = EditorGUILayout.Toggle(socialPlatform, doIntegrate);
					
					// User changed automatic value
					if (doIntegrate != result) {
						doIntegrate = result;
						socialIntegrationState[socialPlatform] = doIntegrate;
					}
				}
				
				if (doIntegrate) {
					foreach (var buildTarget in supportedPlatforms) {
						TryAddRemoveSocialPlatformFlag(buildTarget, socialPlatform, false);
					}
				}
				else {
					foreach (var buildTarget in supportedPlatforms) {
						TryAddRemoveSocialPlatformFlag(buildTarget, socialPlatform, true);
					}
				}
				EditorGUILayout.EndHorizontal();
			}

			EditorGUILayout.Space();

			if (EditorGUI.EndChangeCheck()) {
				WriteSocialIntegrationState();
			}
		}		

		bool IsSocialPlatformDetected(string platform)
		{
			if (Provider.fromString(platform) == Provider.FACEBOOK) {
				Type fbType = Type.GetType("FB");
				return (fbType != null);
			}

			return false;
		}

		/** Profile Providers util functions **/
		
		private void setCurrentBPUpdate(string bpKey) {
			spUpdate[bpKey] = true;
			var buffer = new List<string>(spUpdate.Keys);
			foreach(string key in buffer) {
				if (key != bpKey) {
					spUpdate[key] = false;
				}
			}
		}

		private void TryAddRemoveSocialPlatformFlag(BuildTargetGroup buildTarget, string socialPlatform, bool remove) {
			string targetFlag = GetSocialPlatformFlag(socialPlatform);
			string scriptDefines = PlayerSettings.GetScriptingDefineSymbolsForGroup(buildTarget);
			List<string> flags = new List<string>(scriptDefines.Split(';'));

			if (flags.Contains(targetFlag)) {
				if (remove) {
					flags.Remove(targetFlag);
				}
			}
			else {
				if (!remove) {
					flags.Add(targetFlag);
				}
			}

			string result = string.Join(";", flags.ToArray());
			if (scriptDefines != result) {
				PlayerSettings.SetScriptingDefineSymbolsForGroup(buildTarget, result);
			}
		}

		private string GetSocialPlatformFlag(string socialPlatform) {
			return "SOOMLA_" + socialPlatform.ToUpper();
		}
		
		private Dictionary<string, bool> spUpdate = new Dictionary<string, bool>();
		private static string spRootPath = Application.dataPath + "/Soomla/compilations/android-social-services/";
		
		public static void handleFBJars(bool remove) {
			try {
				if (remove) {
					FileUtil.DeleteFileOrDirectory(Application.dataPath + "/Plugins/Android/AndroidStoreGooglePlay.jar");
					FileUtil.DeleteFileOrDirectory(Application.dataPath + "/Plugins/Android/AndroidStoreGooglePlay.jar.meta");
				} else {
					FileUtil.CopyFileOrDirectory(spRootPath + "google-play/AndroidStoreGooglePlay.jar",
					                             Application.dataPath + "/Plugins/Android/AndroidStoreGooglePlay.jar");
				}
			}catch {}
		}
		
		public static void handleSocialAuthJars(bool remove) {
			try {
				if (remove) {
					FileUtil.DeleteFileOrDirectory(Application.dataPath + "/Plugins/Android/AndroidStoreAmazon.jar");
					FileUtil.DeleteFileOrDirectory(Application.dataPath + "/Plugins/Android/AndroidStoreAmazon.jar.meta");
					FileUtil.DeleteFileOrDirectory(Application.dataPath + "/Plugins/Android/in-app-purchasing-1.0.3.jar");
					FileUtil.DeleteFileOrDirectory(Application.dataPath + "/Plugins/Android/in-app-purchasing-1.0.3.jar.meta");
				} else {
					FileUtil.CopyFileOrDirectory(spRootPath + "amazon/AndroidStoreAmazon.jar",
					                             Application.dataPath + "/Plugins/Android/AndroidStoreAmazon.jar");
					FileUtil.CopyFileOrDirectory(spRootPath + "amazon/in-app-purchasing-1.0.3.jar",
					                             Application.dataPath + "/Plugins/Android/in-app-purchasing-1.0.3.jar");
				}
			}catch {}
		}
		
		
		
		#endif
		
		

		
		/** Profile Specific Variables **/
		
		
		public static string FB_APP_ID_DEFAULT = "YOUR FB APP ID";
		
		public static string FBAppId
		{
			get {
				string value;
				return SoomlaEditorScript.Instance.SoomlaSettings.TryGetValue("FBAppId", out value) ? value : FB_APP_ID_DEFAULT;
			}
			set 
			{
				string v;
				SoomlaEditorScript.Instance.SoomlaSettings.TryGetValue("FBAppId", out v);
				if (v != value)
				{
					SoomlaEditorScript.Instance.setSettingsValue("FBAppId",value);
					SoomlaEditorScript.DirtyEditor ();
				}
			}
		}

		public static string FB_APP_NS_DEFAULT = "YOUR FB APP ID";
		
		public static string FBAppNamespace
		{
			get {
				string value;
				return SoomlaEditorScript.Instance.SoomlaSettings.TryGetValue("FBAppNS", out value) ? value : FB_APP_NS_DEFAULT;
			}
			set 
			{
				string v;
				SoomlaEditorScript.Instance.SoomlaSettings.TryGetValue("FBAppNS", out v);
				if (v != value)
				{
					SoomlaEditorScript.Instance.setSettingsValue("FBAppNS",value);
					SoomlaEditorScript.DirtyEditor ();
				}
			}
		}
	}
}