import SwiftUI

@main
struct SwiftUIProApp: App {
    @State private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environment(coordinator)
        }
    }
}

