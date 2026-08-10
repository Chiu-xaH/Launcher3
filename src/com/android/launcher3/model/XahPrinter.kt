package com.android.launcher3.model

import com.android.launcher3.model.data.AppInfo
import android.util.Log

object XahPrinter {
    fun logApps(apps : List<AppInfo>) {
        Log.d("xah","apps=${apps.joinToString(",") { it.componentName.packageName }}")
    }
}