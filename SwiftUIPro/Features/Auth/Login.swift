import SwiftUI

struct LoginView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @State private var viewModel = LoginViewModel()

    var body: some View {
        ZStack {
            Color("Background").edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                Image(uiImage: #imageLiteral(resourceName: "LaunchImage"))
                    .resizable()
                    .scaledToFit()
                    .clipped()
                formCard
            }
            .padding()
        }
    }
}

private extension LoginView {

    // MARK: - Form Card

    var formCard: some View {
        VStack(spacing: 20) {
            header
            emailField
            passwordField
            errorView
            loginButton
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
        )
    }

    // MARK: - Header

    var header: some View {
        VStack(spacing: 8) {
            Text("Welcome Back")
                .font(.largeTitle.bold())
                .foregroundColor(Color("AppPrimary"))

            Text("Sign in to continue")
                .foregroundColor(Color("AppPrimary").opacity(0.8))
        }
    }

    // MARK: - Fields

    var emailField: some View {
        TextField("Email", text: $viewModel.email)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .keyboardType(.emailAddress)
            .modifier(AuthTextFieldStyle())
    }

    var passwordField: some View {
        SecureField("Password", text: $viewModel.password)
            .modifier(AuthTextFieldStyle())
    }

    // MARK: - Error

    @ViewBuilder
    var errorView: some View {
        if let error = viewModel.errorMessage {
            Text(error)
                .foregroundColor(.red)
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Button

    var loginButton: some View {
        Button(action: loginTapped) {
            if viewModel.isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text("Login")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(Color("AppPrimary"))
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .disabled(viewModel.isLoading)
    }

    // MARK: - Action

    func loginTapped() {
        Task {
            let success = await viewModel.login()
            if success {
                coordinator.loginSucceeded()
            }
        }
    }
}

struct AuthTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.9))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.3))
            )
    }
}

#Preview {
    LoginView()
        .environment(AppCoordinator())
}
