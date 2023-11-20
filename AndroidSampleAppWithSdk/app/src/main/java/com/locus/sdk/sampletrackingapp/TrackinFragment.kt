package com.locus.sdk.sampletrackingapp

import android.annotation.SuppressLint
import android.content.Context
import android.content.IntentSender
import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import com.google.android.gms.common.api.ResolvableApiException
import com.locus.sdk.sampletrackingapp.databinding.FragmentTrackinBinding
import io.reactivex.schedulers.Schedulers
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import sh.locus.lotr.sdk.LocusLocation
import sh.locus.lotr.sdk.LocusLotrSdk
import sh.locus.lotr.sdk.LogoutStatusListener
import sh.locus.lotr.sdk.TrackingListener
import sh.locus.lotr.sdk.TrackingRequestParams
import sh.locus.lotr.sdk.exception.LotrSdkError
import sh.locus.lotr.sdk.logging.LotrSdkEventType
import java.util.Date

class TrackinFragment : Fragment(), TrackingListener {

    private var _binding: FragmentTrackinBinding? = null
    private val binding get() = _binding!!

    private lateinit var sharedPreferences: SharedPreferences
    private lateinit var logger: Logger
    private lateinit var logoutListener: LogoutListener

    private lateinit var toggleButton: Button

    private var isTracking: Boolean = false

    @SuppressLint("CheckResult")
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        val context = context

        context ?: return null

        _binding = FragmentTrackinBinding.inflate(inflater, container, false)
        val view = binding.root

        sharedPreferences = context.getSharedPreferences("sample-app-prefs", Context.MODE_PRIVATE)
        isTracking = sharedPreferences.getBoolean(KEY_IS_TRACKING, false)

        logger = LoggerFactory.getLogger(this::class.java)

        toggleButton = view.findViewById(R.id.bt_start_stop)

        setToggleButtonText()

        toggleButton.setOnClickListener {
            toggleTracker()
        }

        view.findViewById<Button>(R.id.bt_logout).setOnClickListener {
            LocusLotrSdk.logout(false, true, object : LogoutStatusListener {
                override fun onFailure() {
                    Toast.makeText(context, R.string.error_logout_fail, Toast.LENGTH_SHORT).show()
                }

                override fun onSuccess() {
                    logoutListener.onLogout()
                }
            })
        }

        val lastLocationText = LocusLotrSdk.getLastKnownLocation()?.let {
            getString(R.string.last_known_location, it.toIndentedString())
        } ?: "Last known location not available"
        view.findViewById<TextView>(R.id.tv_location).text = lastLocationText

        LocusLotrSdk.getSdkEventsObservable()
            .subscribeOn(Schedulers.io())
            .observeOn(Schedulers.io())
            .subscribe({ lotrSdkEvent ->

                when (lotrSdkEvent.type) {

                    LotrSdkEventType.PASSWORD_EXPIRED -> Toast.makeText(
                        getContext(),
                        lotrSdkEvent.message,
                        Toast.LENGTH_SHORT
                    ).show()

                    LotrSdkEventType.AUTH_FAILURE -> Toast.makeText(
                        getContext(),
                        lotrSdkEvent.message,
                        Toast.LENGTH_SHORT
                    ).show()

                    else -> Log.v("TAG", "${lotrSdkEvent.type} ${lotrSdkEvent.message}")
                }
            }, { throwable ->
                throwable.printStackTrace()
            })

        return view
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        logoutListener = context as LogoutListener
    }

    private fun setToggleButtonText() {
        toggleButton.text = if (isTracking) {
            "STOP"
        } else {
            "START"
        }
    }

    private fun toggleTracker() {

        isTracking = !isTracking
        setToggleButtonText()

        if (isTracking) {

            val requestParams = TrackingRequestParams.Builder()
                .setNotificationTitleText(R.string.notification_text) // Customize the notification text
                //.setNotificationChannelId("") // Customize channel Id if required
                //.setNotificationChannelName("") // Customize channel name if required
                .build()
            LocusLotrSdk.startTracking(this, requestParams)

            binding.tvErrorMessage.text = ""
            binding.tvErrorTime.text = ""
        } else {
            LocusLotrSdk.stopTracking()
        }
    }

    override fun onLocationUpdated(location: LocusLocation) {
        val locationString = location.toIndentedString()
        binding.tvLocation.text = locationString
        logger.info(locationString.replace('\n', ' '))
    }

    override fun onLocationError(lotrSdkError: LotrSdkError) {

        if (lotrSdkError.code == LotrSdkError.Code.RESOLVABLE_API_EXCEPTION) {
            try {
                val resolvableApiException = lotrSdkError.throwable as ResolvableApiException
                // Show the dialog by calling startResolutionForResult() and check the result in onActivityResult().
                resolvableApiException.startResolutionForResult(requireActivity(), 1001)
            } catch (sendEx: IntentSender.SendIntentException) {
                // Ignore the error.
            }
            return
        }

        binding.tvErrorMessage.text = lotrSdkError.message
        binding.tvErrorTime.text = getString(R.string.error_time, Date().toString())
        lotrSdkError.throwable?.let {
            logger.error("Error", it)
        }
    }

    override fun onLocationUploaded(location: LocusLocation) {
        // Nothing to do
    }

    interface LogoutListener {
        fun onLogout()
    }

    companion object {
        const val KEY_IS_TRACKING = "KEY_IS_TRACKING"
    }
}
