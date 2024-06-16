import Cocoa
import FlutterMacOS
import permission_handler // Ensure the plugin is imported

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    guard let flutterViewController = mainFlutterWindow?.contentViewController as? FlutterViewController else {
      fatalError("Unable to initialize Flutter view controller")
    }
    let registrar = flutterViewController.registrar(forPlugin: "permission_handler")
    PermissionHandlerPlugin.register(with: registrar) // Ensure plugin registration
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
