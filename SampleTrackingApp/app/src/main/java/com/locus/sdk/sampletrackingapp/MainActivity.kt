package com.locus.sdk.sampletrackingapp

import android.Manifest
import android.content.Context
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import sh.locus.lotr.sdk.LocusLotrSdk
import sh.locus.lotr.sdk.LogoutStatusListener

class MainActivity : AppCompatActivity(), LoginFragment.LoginListener,
    TrackinFragment.LogoutListener {

    private lateinit var sharedPreferences: SharedPreferences

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        sharedPreferences = getSharedPreferences("sample-app-prefs", Context.MODE_PRIVATE)

        showFragment(FRAG_TAG_LOGIN, LoginFragment())
    }

    override fun onLogin() {
        showFragment(FRAG_TAG_TRACKIN, TrackinFragment())
    }

    override fun onLogout() {
        showFragment(FRAG_TAG_LOGIN, LoginFragment())
    }

    private fun showFragment(tag: String, fragment: Fragment) {

        val fragmentManager = supportFragmentManager

        val addedFragment = fragmentManager.findFragmentByTag(tag)

        if (addedFragment != null) {
            return
        }

        supportFragmentManager.beginTransaction().replace(R.id.container, fragment, tag).commit()
    }

    override fun onStart() {
        super.onStart()

        val requiredPermissions = arrayListOf(
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION,
            Manifest.permission.WRITE_EXTERNAL_STORAGE // Required logging in sample app
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            requiredPermissions.add(Manifest.permission.ACTIVITY_RECOGNITION)
            requiredPermissions.add(Manifest.permission.ACCESS_BACKGROUND_LOCATION)
        } else {
            requiredPermissions.add(Manifest.permission.READ_PHONE_STATE)
        }

        val missingPermissions = requiredPermissions.filter {
            ActivityCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED
        }

        if (missingPermissions.isNotEmpty()) {
            ActivityCompat.requestPermissions(
                this,
                missingPermissions.toTypedArray(),
                PERMISSION_REQUEST_CODE
            )
        }
    }

    override fun onDestroy() {
        super.onDestroy()

        try {
            LocusLotrSdk.logout(true, object : LogoutStatusListener {
                override fun onFailure() {
                    // Don't care
                }

                override fun onSuccess() {
                    // Don't care
                }
            })
        } catch (e: IllegalStateException) {
            // When it wasn't even initialized
            e.printStackTrace()
        }
    }

    companion object {
        const val PERMISSION_REQUEST_CODE = 1000
        const val FRAG_TAG_LOGIN = "FRAG_TAG_LOGIN"
        const val FRAG_TAG_TRACKIN = "FRAG_TAG_TRACKIN"
    }
}
