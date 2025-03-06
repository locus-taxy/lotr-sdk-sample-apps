package com.locus.sdk.sampletrackingapp;

import android.content.Context;

import sh.locus.lotr.model.User;
import sh.locus.lotr.sdk.LocusLotrSdk;
import sh.locus.lotr.sdk.LocusLotrSdkState;
import sh.locus.lotr.sdk.exception.LotrSdkError;
import sh.locus.lotr.sdk.exception.MissingPermissionsException;

// Just to check java interoperability
public class Utils {

    // Check error code enums
    public void checkErrorCode(LotrSdkError lotrSdkError) {

        switch (lotrSdkError.getCode()) {

            case BAD_AUTH:
                break;
            case SERVER_ERROR:
                break;
            case ACTIVITY_RECOGNITION_FAILURE:
                break;
            case RESOLVABLE_API_EXCEPTION:
                break;
            case FUSED_LOCATION_SETTING_ERROR:
                break;
            case MISSING_PERMISSIONS:
                break;
            case FUSED_LOCATION_NOT_AVAILABLE:
                break;
        }
    }

    // Check string array accessible from java code
    public String[] getMissingPermissions(Throwable throwable) {

        if (throwable instanceof MissingPermissionsException) {
            MissingPermissionsException exception = (MissingPermissionsException) throwable;
            return exception.getMissingPermissions();
        }

        return null;
    }

    // Initialise SDK when it's already authenticated
    public boolean initSdkIfLoggedIn(Context context) {

        if (LocusLotrSdk.getSdkState() != LocusLotrSdkState.AUTHENTICATED) {
            return false;
        }

        User user = new User();
        // Set fields if available. Not actually required.
        user.setClientId("");
        user.setUserId("");

        LocusLotrSdk.setContext(context, user);
        return true;
    }
}
