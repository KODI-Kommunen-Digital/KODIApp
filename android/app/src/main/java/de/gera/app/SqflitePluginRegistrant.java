package de.gera.cityapp
;

import com.tekartik.sqflite.SqflitePlugin;
import io.flutter.embedding.engine.FlutterEngine;

public final class SqflitePluginRegistrant {
    public static void registerWith(FlutterEngine flutterEngine) {
        flutterEngine.getPlugins().add(new SqflitePlugin());
    }
}
