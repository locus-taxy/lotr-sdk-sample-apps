package com.locus.sdk.sampletrackingapp

import androidx.multidex.MultiDexApplication
import sh.locus.lotr.sdk.LocusLotrSdk

class SampleApplication : MultiDexApplication() {

    override fun onCreate() {
        super.onCreate()
        LocusLotrSdk.setBaseUrls("https://lotr.locus-api.com", "https://api.locus-api.com")
    }
}