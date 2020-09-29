import Foundation

/** A container for client specific configuration to be applied to Locus delivery app. */

open class ClientAppConfig: Codable {

    public enum UrlHandler: String, Codable {
        case webview = "WEBVIEW"
        case chrome = "CHROME"
    }

    public enum PhoneCallMethod: String, Codable {
        case phone = "PHONE"
        case cloudTelephony = "CLOUD_TELEPHONY"
    }

    /** Default locale to use on the delivery boy app. */
    public var defaultLocale: Locale?
    /** Location polling frequency for the user */
    public var userLocationPollingParam: LocationPollingParam?
    /** Boolean to denote that all tasks should be enabled to be actioned upon. */
    public var enableAllTasks: Bool?
    /** Boolean to denote that next visit should be auto triggered, if it is eligible. */
    public var autoTriggerNext: Bool?
    /** Boolean to denote that next visit, if homebase, should be auto triggered, if it is eligible. */
    public var autoTriggerNextHomebase: Bool?
    /** List of statuses for which actions should be skipped from the app. */
    public var skipStatuses: [String]?
    /** List of statuses for which notifications should be generated if transition was not user initiated. */
    public var notifyStatuses: [String]?
    /** Boolean to denote task should be auto accepted */
    public var autoAccept: Bool?
    /** Boolean to denote that all actions should be offline */
    public var offlineActions: Bool?
    /** Boolean to denote that task should be auto started after accepted */
    public var autoStartOnAccept: Bool?
    /** Boolean to denote that task should not be allowed to be cancelled */
    public var hideCancel: Bool?
    /** Boolean to denote that task should not be allowed to be rejected */
    public var hideReject: Bool?
    /** Boolean to denote that rescheduling visits is allowed */
    public var allowVisitReschedule: Bool?
    /** Boolean to denote that mobile device should collect locations */
    public var collectLocations: Bool?
    /** Time in seconds after which a location should be considered stale */
    public var locationStaleTime: Int?
    /** Frequency at which app will poll for eta updates */
    public var etaPollingPeriod: Int?
    /** Max number of updates to send in one bulk update */
    public var bulkUpdateLimit: Int?
    /** Specifies what will handle url links in the application */
    public var urlHandler: UrlHandler?
    /** Specifies the method to make phone calls to contact at visit */
    public var phoneCallMethod: PhoneCallMethod?
    public var hideChangeUserStatus: Bool?
    /** Requires the mobile device&#39;s wifi to be switched ON */
    public var requiresWifiEnabled: Bool?
    /** Specifies if UI dialogs are blocking */
    public var enableUiBlockingDialogs: Bool?
    public var sensorPollingParam: SensorPollingParam?
    public var locationSetting: LocationSetting?
    public var asyncCommunicationSetting: AsyncCommunicationSetting?
    public var taskAppConfig: TaskAppConfig?
    public var visitAppConfig: VisitAppConfig?
    public var clientProfile: ClientProfile?
    public var checklistSetting: ChecklistSetting?
    /** Time Interval at which Accept/Reject Task Popup is shown */
    public var acceptTaskPopupFrequency: Int?
    public var notifyTaskCompletionConfig: NotifyTaskCompletionConfig?
    public var displayConfig: DisplayConfig?
    public var navigationConfig: NavigationConfig?
    public var securityConfig: SecurityConfig?
    /** Boolean to denote enabling single task start */
    public var enableSingleStartedTask: Bool?
    /** Boolean to indicate that photo can be updated or not */
    public var canUpdatePhoto: Bool?
    /** Boolean to indicate that name can be updated or not */
    public var canUpdateName: Bool?
    /** Whether Overview Map is to be displayed */
    public var showOverviewMap: Bool?
    /** Boolean to indicate if multiple trips can be started */
    public var allowStartMultipleTrips: Bool?
    /** Boolean to indicate if password change is allowed */
    public var allowChangePassword: Bool?
    /** Boolean to indicate if homebase clubbing should be done */
    public var shouldClubHomebases: Bool?
    public var appPermissionsConfig: AppPermissionsConfig?
    /** Boolean to indicate if task should only be allowed to be marked complete in geofence */
    public var enforceGeofenceForCompletion: Bool?
    /** Radius in meters for task completetion geofence */
    public var taskCompletionGeofenceRadius: Int?
    public var phoneVerificationConfig: PhoneVerificationConfig?
    public var lotrFeatureConfig: LotrFeatureConfig?

    public init(defaultLocale: Locale?, userLocationPollingParam: LocationPollingParam?, enableAllTasks: Bool?, autoTriggerNext: Bool?, autoTriggerNextHomebase: Bool?, skipStatuses: [String]?, notifyStatuses: [String]?, autoAccept: Bool?, offlineActions: Bool?, autoStartOnAccept: Bool?, hideCancel: Bool?, hideReject: Bool?, allowVisitReschedule: Bool?, collectLocations: Bool?, locationStaleTime: Int?, etaPollingPeriod: Int?, bulkUpdateLimit: Int?, urlHandler: UrlHandler?, phoneCallMethod: PhoneCallMethod?, hideChangeUserStatus: Bool?, requiresWifiEnabled: Bool?, enableUiBlockingDialogs: Bool?, sensorPollingParam: SensorPollingParam?, locationSetting: LocationSetting?, asyncCommunicationSetting: AsyncCommunicationSetting?, taskAppConfig: TaskAppConfig?, visitAppConfig: VisitAppConfig?, clientProfile: ClientProfile?, checklistSetting: ChecklistSetting?, acceptTaskPopupFrequency: Int?, notifyTaskCompletionConfig: NotifyTaskCompletionConfig?, displayConfig: DisplayConfig?, navigationConfig: NavigationConfig?, securityConfig: SecurityConfig?, enableSingleStartedTask: Bool?, canUpdatePhoto: Bool?, canUpdateName: Bool?, showOverviewMap: Bool?, allowStartMultipleTrips: Bool?, allowChangePassword: Bool?, shouldClubHomebases: Bool?, appPermissionsConfig: AppPermissionsConfig?, enforceGeofenceForCompletion: Bool?, taskCompletionGeofenceRadius: Int?, phoneVerificationConfig: PhoneVerificationConfig?, lotrFeatureConfig: LotrFeatureConfig?) {
        self.defaultLocale = defaultLocale
        self.userLocationPollingParam = userLocationPollingParam
        self.enableAllTasks = enableAllTasks
        self.autoTriggerNext = autoTriggerNext
        self.autoTriggerNextHomebase = autoTriggerNextHomebase
        self.skipStatuses = skipStatuses
        self.notifyStatuses = notifyStatuses
        self.autoAccept = autoAccept
        self.offlineActions = offlineActions
        self.autoStartOnAccept = autoStartOnAccept
        self.hideCancel = hideCancel
        self.hideReject = hideReject
        self.allowVisitReschedule = allowVisitReschedule
        self.collectLocations = collectLocations
        self.locationStaleTime = locationStaleTime
        self.etaPollingPeriod = etaPollingPeriod
        self.bulkUpdateLimit = bulkUpdateLimit
        self.urlHandler = urlHandler
        self.phoneCallMethod = phoneCallMethod
        self.hideChangeUserStatus = hideChangeUserStatus
        self.requiresWifiEnabled = requiresWifiEnabled
        self.enableUiBlockingDialogs = enableUiBlockingDialogs
        self.sensorPollingParam = sensorPollingParam
        self.locationSetting = locationSetting
        self.asyncCommunicationSetting = asyncCommunicationSetting
        self.taskAppConfig = taskAppConfig
        self.visitAppConfig = visitAppConfig
        self.clientProfile = clientProfile
        self.checklistSetting = checklistSetting
        self.acceptTaskPopupFrequency = acceptTaskPopupFrequency
        self.notifyTaskCompletionConfig = notifyTaskCompletionConfig
        self.displayConfig = displayConfig
        self.navigationConfig = navigationConfig
        self.securityConfig = securityConfig
        self.enableSingleStartedTask = enableSingleStartedTask
        self.canUpdatePhoto = canUpdatePhoto
        self.canUpdateName = canUpdateName
        self.showOverviewMap = showOverviewMap
        self.allowStartMultipleTrips = allowStartMultipleTrips
        self.allowChangePassword = allowChangePassword
        self.shouldClubHomebases = shouldClubHomebases
        self.appPermissionsConfig = appPermissionsConfig
        self.enforceGeofenceForCompletion = enforceGeofenceForCompletion
        self.taskCompletionGeofenceRadius = taskCompletionGeofenceRadius
        self.phoneVerificationConfig = phoneVerificationConfig
        self.lotrFeatureConfig = lotrFeatureConfig
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(defaultLocale, forKey: "defaultLocale")
        try container.encodeIfPresent(userLocationPollingParam, forKey: "userLocationPollingParam")
        try container.encodeIfPresent(enableAllTasks, forKey: "enableAllTasks")
        try container.encodeIfPresent(autoTriggerNext, forKey: "autoTriggerNext")
        try container.encodeIfPresent(autoTriggerNextHomebase, forKey: "autoTriggerNextHomebase")
        try container.encodeIfPresent(skipStatuses, forKey: "skipStatuses")
        try container.encodeIfPresent(notifyStatuses, forKey: "notifyStatuses")
        try container.encodeIfPresent(autoAccept, forKey: "autoAccept")
        try container.encodeIfPresent(offlineActions, forKey: "offlineActions")
        try container.encodeIfPresent(autoStartOnAccept, forKey: "autoStartOnAccept")
        try container.encodeIfPresent(hideCancel, forKey: "hideCancel")
        try container.encodeIfPresent(hideReject, forKey: "hideReject")
        try container.encodeIfPresent(allowVisitReschedule, forKey: "allowVisitReschedule")
        try container.encodeIfPresent(collectLocations, forKey: "collectLocations")
        try container.encodeIfPresent(locationStaleTime, forKey: "locationStaleTime")
        try container.encodeIfPresent(etaPollingPeriod, forKey: "etaPollingPeriod")
        try container.encodeIfPresent(bulkUpdateLimit, forKey: "bulkUpdateLimit")
        try container.encodeIfPresent(urlHandler, forKey: "urlHandler")
        try container.encodeIfPresent(phoneCallMethod, forKey: "phoneCallMethod")
        try container.encodeIfPresent(hideChangeUserStatus, forKey: "hideChangeUserStatus")
        try container.encodeIfPresent(requiresWifiEnabled, forKey: "requiresWifiEnabled")
        try container.encodeIfPresent(enableUiBlockingDialogs, forKey: "enableUiBlockingDialogs")
        try container.encodeIfPresent(sensorPollingParam, forKey: "sensorPollingParam")
        try container.encodeIfPresent(locationSetting, forKey: "locationSetting")
        try container.encodeIfPresent(asyncCommunicationSetting, forKey: "asyncCommunicationSetting")
        try container.encodeIfPresent(taskAppConfig, forKey: "taskAppConfig")
        try container.encodeIfPresent(visitAppConfig, forKey: "visitAppConfig")
        try container.encodeIfPresent(clientProfile, forKey: "clientProfile")
        try container.encodeIfPresent(checklistSetting, forKey: "checklistSetting")
        try container.encodeIfPresent(acceptTaskPopupFrequency, forKey: "acceptTaskPopupFrequency")
        try container.encodeIfPresent(notifyTaskCompletionConfig, forKey: "notifyTaskCompletionConfig")
        try container.encodeIfPresent(displayConfig, forKey: "displayConfig")
        try container.encodeIfPresent(navigationConfig, forKey: "navigationConfig")
        try container.encodeIfPresent(securityConfig, forKey: "securityConfig")
        try container.encodeIfPresent(enableSingleStartedTask, forKey: "enableSingleStartedTask")
        try container.encodeIfPresent(canUpdatePhoto, forKey: "canUpdatePhoto")
        try container.encodeIfPresent(canUpdateName, forKey: "canUpdateName")
        try container.encodeIfPresent(showOverviewMap, forKey: "showOverviewMap")
        try container.encodeIfPresent(allowStartMultipleTrips, forKey: "allowStartMultipleTrips")
        try container.encodeIfPresent(allowChangePassword, forKey: "allowChangePassword")
        try container.encodeIfPresent(shouldClubHomebases, forKey: "shouldClubHomebases")
        try container.encodeIfPresent(appPermissionsConfig, forKey: "appPermissionsConfig")
        try container.encodeIfPresent(enforceGeofenceForCompletion, forKey: "enforceGeofenceForCompletion")
        try container.encodeIfPresent(taskCompletionGeofenceRadius, forKey: "taskCompletionGeofenceRadius")
        try container.encodeIfPresent(phoneVerificationConfig, forKey: "phoneVerificationConfig")
        try container.encodeIfPresent(lotrFeatureConfig, forKey: "lotrFeatureConfig")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        defaultLocale = try container.decodeIfPresent(Locale.self, forKey: "defaultLocale")
        userLocationPollingParam = try container.decodeIfPresent(LocationPollingParam.self, forKey: "userLocationPollingParam")
        enableAllTasks = try container.decodeIfPresent(Bool.self, forKey: "enableAllTasks")
        autoTriggerNext = try container.decodeIfPresent(Bool.self, forKey: "autoTriggerNext")
        autoTriggerNextHomebase = try container.decodeIfPresent(Bool.self, forKey: "autoTriggerNextHomebase")
        skipStatuses = try container.decodeIfPresent([String].self, forKey: "skipStatuses")
        notifyStatuses = try container.decodeIfPresent([String].self, forKey: "notifyStatuses")
        autoAccept = try container.decodeIfPresent(Bool.self, forKey: "autoAccept")
        offlineActions = try container.decodeIfPresent(Bool.self, forKey: "offlineActions")
        autoStartOnAccept = try container.decodeIfPresent(Bool.self, forKey: "autoStartOnAccept")
        hideCancel = try container.decodeIfPresent(Bool.self, forKey: "hideCancel")
        hideReject = try container.decodeIfPresent(Bool.self, forKey: "hideReject")
        allowVisitReschedule = try container.decodeIfPresent(Bool.self, forKey: "allowVisitReschedule")
        collectLocations = try container.decodeIfPresent(Bool.self, forKey: "collectLocations")
        locationStaleTime = try container.decodeIfPresent(Int.self, forKey: "locationStaleTime")
        etaPollingPeriod = try container.decodeIfPresent(Int.self, forKey: "etaPollingPeriod")
        bulkUpdateLimit = try container.decodeIfPresent(Int.self, forKey: "bulkUpdateLimit")
        urlHandler = try container.decodeIfPresent(UrlHandler.self, forKey: "urlHandler")
        phoneCallMethod = try container.decodeIfPresent(PhoneCallMethod.self, forKey: "phoneCallMethod")
        hideChangeUserStatus = try container.decodeIfPresent(Bool.self, forKey: "hideChangeUserStatus")
        requiresWifiEnabled = try container.decodeIfPresent(Bool.self, forKey: "requiresWifiEnabled")
        enableUiBlockingDialogs = try container.decodeIfPresent(Bool.self, forKey: "enableUiBlockingDialogs")
        sensorPollingParam = try container.decodeIfPresent(SensorPollingParam.self, forKey: "sensorPollingParam")
        locationSetting = try container.decodeIfPresent(LocationSetting.self, forKey: "locationSetting")
        asyncCommunicationSetting = try container.decodeIfPresent(AsyncCommunicationSetting.self, forKey: "asyncCommunicationSetting")
        taskAppConfig = try container.decodeIfPresent(TaskAppConfig.self, forKey: "taskAppConfig")
        visitAppConfig = try container.decodeIfPresent(VisitAppConfig.self, forKey: "visitAppConfig")
        clientProfile = try container.decodeIfPresent(ClientProfile.self, forKey: "clientProfile")
        checklistSetting = try container.decodeIfPresent(ChecklistSetting.self, forKey: "checklistSetting")
        acceptTaskPopupFrequency = try container.decodeIfPresent(Int.self, forKey: "acceptTaskPopupFrequency")
        notifyTaskCompletionConfig = try container.decodeIfPresent(NotifyTaskCompletionConfig.self, forKey: "notifyTaskCompletionConfig")
        displayConfig = try container.decodeIfPresent(DisplayConfig.self, forKey: "displayConfig")
        navigationConfig = try container.decodeIfPresent(NavigationConfig.self, forKey: "navigationConfig")
        securityConfig = try container.decodeIfPresent(SecurityConfig.self, forKey: "securityConfig")
        enableSingleStartedTask = try container.decodeIfPresent(Bool.self, forKey: "enableSingleStartedTask")
        canUpdatePhoto = try container.decodeIfPresent(Bool.self, forKey: "canUpdatePhoto")
        canUpdateName = try container.decodeIfPresent(Bool.self, forKey: "canUpdateName")
        showOverviewMap = try container.decodeIfPresent(Bool.self, forKey: "showOverviewMap")
        allowStartMultipleTrips = try container.decodeIfPresent(Bool.self, forKey: "allowStartMultipleTrips")
        allowChangePassword = try container.decodeIfPresent(Bool.self, forKey: "allowChangePassword")
        shouldClubHomebases = try container.decodeIfPresent(Bool.self, forKey: "shouldClubHomebases")
        appPermissionsConfig = try container.decodeIfPresent(AppPermissionsConfig.self, forKey: "appPermissionsConfig")
        enforceGeofenceForCompletion = try container.decodeIfPresent(Bool.self, forKey: "enforceGeofenceForCompletion")
        taskCompletionGeofenceRadius = try container.decodeIfPresent(Int.self, forKey: "taskCompletionGeofenceRadius")
        phoneVerificationConfig = try container.decodeIfPresent(PhoneVerificationConfig.self, forKey: "phoneVerificationConfig")
        lotrFeatureConfig = try container.decodeIfPresent(LotrFeatureConfig.self, forKey: "lotrFeatureConfig")
    }
}
