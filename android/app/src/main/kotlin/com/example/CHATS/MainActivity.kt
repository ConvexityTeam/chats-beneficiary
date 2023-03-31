package chats.cash.CHATS

// import io.flutter.embedding.android.FlutterFragmentActivity
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.plugins.GeneratedPluginRegistrant
// import io.flutter.embedding.engine.FlutterEngine
// import androidx.annotation.NonNull;

// class MainActivity: FlutterActivity() {
//     override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//         GeneratedPluginRegistrant.registerWith(flutterEngine);
//     }
// }

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
