package com.locus.sdk.sampletrackingapp

import android.app.Application
import sh.locus.lotr.sdk.LocusLotrSdk

class SampleApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        LocusLotrSdk.setBaseUrls("https://lotr.locus-api.com", "https://api.locus-api.com")
    }
}