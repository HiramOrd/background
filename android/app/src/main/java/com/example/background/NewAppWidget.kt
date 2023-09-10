package com.example.background

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

// ManagerH: import class -----------------------
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.File

    // ManagerH: import class -----------------------
import es.antonborri.home_widget.HomeWidgetPlugin

/**
 * Implementation of App Widget functionality.
 */
class NewAppWidget : AppWidgetProvider() {

    // ManagerH: Custome onUpdate method -----------------------
    override fun onUpdate(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray,
    ) {
        for (appWidgetId in appWidgetIds) {
            // Get reference to SharedPreferences
            val widgetData = HomeWidgetPlugin.getData(context)
            val views = RemoteViews(context.packageName, R.layout.new_app_widget).apply {

               // Get image and put it in the widget, if it exists
               val imageName = widgetData.getString("filename", null)
               val imageFile = File(imageName)
               val imageExists = imageFile.exists()
               if (imageExists) {
                   val myBitmap: Bitmap = BitmapFactory.decodeFile(imageFile.absolutePath)
                   setImageViewBitmap(R.id.widget_image, myBitmap)
               } else {
                   println("image not found!, looked @: ${imageName}")
               }

               // Create an intent to open the MainActivity of your app
                val intent = Intent(context, MainActivity::class.java)
                val pendingIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_IMMUTABLE)

                // Set the click action for the widget
                setOnClickPendingIntent(R.id.widget_image, pendingIntent)
            }

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
    // ManagerH: Custome onUpdate method -----------------------


    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

    // ManagerH: Delete auto generate method -----------------------
