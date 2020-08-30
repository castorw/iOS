import Foundation
import UIKit
import PromiseKit

@available(iOS 13, *)
final class WebViewSceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    var windowController: WebViewWindowController?
    var urlHandler: IncomingURLHandler?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = scene as? UIWindowScene else { return }

        let window = UIWindow(haScene: scene)
        let windowController = WebViewWindowController(
            window: window,
            restorationActivity: session.stateRestorationActivity
        )
        let urlHandler = IncomingURLHandler(windowController: windowController)
        self.window = window
        self.windowController = windowController
        self.urlHandler = urlHandler

        windowController.setup()

        #if targetEnvironment(macCatalyst)
        if let titlebar = scene.titlebar {
            // disabling this also disables the "show tab bar" window tab bar (aka not uitabbar)
            titlebar.titleVisibility = .hidden
            titlebar.toolbar = nil
        }
        #endif

        if !connectionOptions.urlContexts.isEmpty {
            self.scene(scene, openURLContexts: connectionOptions.urlContexts)
        }

        if let shortcutItem = connectionOptions.shortcutItem {
            self.windowScene(scene, performActionFor: shortcutItem, completionHandler: { _ in })
        }

        if !connectionOptions.userActivities.isEmpty {
            for activity in connectionOptions.userActivities {
                self.scene(scene, continue: activity)
            }
        }

        informManager(from: connectionOptions)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        windowController = nil
        window = nil
        urlHandler = nil
    }

    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        urlHandler?.handle(shortcutItem: shortcutItem)
            .done {
                completionHandler(true)
            }.catch { _ in
                completionHandler(false)
            }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        for url in URLContexts.map(\.url) {
            urlHandler?.handle(url: url)
        }
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        windowController?.stateRestorationActivity()
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        urlHandler?.handle(userActivity: userActivity)
    }
}