import Observation

@Observable
@MainActor
final class AppState {
    var isAuthenticated: Bool = false
}
