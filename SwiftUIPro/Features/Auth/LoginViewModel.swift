import Observation

@Observable
@MainActor
final class LoginViewModel {

    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }

    func login() async -> Bool {
        guard isFormValid else {
            errorMessage = "Please enter email and password"
            return false
        }

        isLoading = true
        errorMessage = nil

        // Simulate async work (API call later)
        try? await Task.sleep(for: .seconds(1))

        isLoading = false
        return true
    }
}
