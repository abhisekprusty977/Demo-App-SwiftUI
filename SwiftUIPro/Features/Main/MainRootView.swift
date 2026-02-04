import SwiftUI

struct MainRootView: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        @Bindable var coordinator = coordinator
        
        NavigationStack(path: $coordinator.mainPath) {
            MainTabView()
                .navigationDestination(for: MainRoute.self) { route in
                    switch route {
                    case .placeDetail(let place):
                        PlaceDetailView(place: place)
                    }
                }
        }
    }
}
