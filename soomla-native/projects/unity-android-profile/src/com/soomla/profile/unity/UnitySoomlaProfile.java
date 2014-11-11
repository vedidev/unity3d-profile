package com.soomla.profile.unity;

import android.app.Activity;

import com.soomla.profile.SoomlaProfile;
import com.soomla.profile.data.UserProfileStorage;
import com.soomla.profile.domain.UserProfile;
import com.soomla.profile.exceptions.ProviderNotFoundException;
import com.soomla.profile.exceptions.UserProfileNotFoundException;

import org.json.JSONException;
import org.json.JSONObject;

import static com.soomla.profile.domain.IProvider.Provider;

public class UnitySoomlaProfile {

    public static void login(Activity activity, String providerStr, String payload) throws ProviderNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        SoomlaProfile.getInstance().login(activity, provider, payload, null);
    }

    public static void logout(String providerStr) throws ProviderNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        SoomlaProfile.getInstance().logout(provider);
    }

    public static void isLoggedIn(Activity activity, String providerStr) throws ProviderNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        SoomlaProfile.getInstance().isLoggedIn(activity, provider);
    }

    public static void updateStatus(String providerStr, String status, String payload) throws ProviderNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        SoomlaProfile.getInstance().updateStatus(provider, status, payload, null);
    }

    public static void updateStory(String providerStr, String message, String name,
                                   String caption, String description, String link,
                                   String pictureUrl, String payload) throws ProviderNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        SoomlaProfile.getInstance().updateStory(provider, message, name, caption, description,
                link, pictureUrl, payload, null);
    }

    public static void uploadImage(String providerStr, String message, String filePath, String payload) throws ProviderNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        SoomlaProfile.getInstance().uploadImage(provider, message, filePath, null);
    }

    public static void getContacts(String providerStr, String payload) throws ProviderNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        SoomlaProfile.getInstance().getContacts(provider, payload, null);
    }

    public static String getStoredUserProfile(String providerStr) throws ProviderNotFoundException, UserProfileNotFoundException {
        Provider provider = Provider.getEnum(providerStr);
        UserProfile userProfile = SoomlaProfile.getInstance().getStoredUserProfile(provider);
        return userProfile == null ? null : userProfile.toJSONObject().toString();
    }

    public static void storeUserProfile(String userJSON)
            throws ProviderNotFoundException, JSONException {
        JSONObject jsonObject = new JSONObject(userJSON);
        final UserProfile userProfile = new UserProfile(jsonObject);

        UserProfileStorage.setUserProfile(userProfile);
    }

    public static void openAppRatingPage(Activity activity) {
        SoomlaProfile.getInstance().openAppRatingPage(activity.getApplicationContext());
    }

    private static String TAG = "SOOMLA UnitySoomlaProfile";
}
