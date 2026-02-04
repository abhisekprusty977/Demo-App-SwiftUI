import SwiftUI

struct MainTabView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Content
            Group {
                switch selectedTab {
                case .home:
                    PlacesHomeView()
                case .schedule:
                    ScheduleView()
                case .favorites:
                    FavoritesView()
                case .profile:
                    ProfileView()
                }
            }
            
            // Custom Tab Bar
            customTabBar
        }
        .ignoresSafeArea(.keyboard)
    }
    
    var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 16)
        .padding(.bottom, 24)
        .background(
            RoundedRectangle(cornerRadius: 32)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 20, y: -5)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

// MARK: - Tab Bar Button

struct TabBarButton: View {
    let tab: Tab
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: isSelected ? tab.selectedIcon : tab.icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .primary : .gray)
                    .frame(height: 24)
                
                if isSelected {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 6, height: 6)
                } else {
                    Color.clear
                        .frame(width: 6, height: 6)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Tab Enum

enum Tab: CaseIterable {
    case home
    case schedule
    case favorites
    case profile
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .schedule: return "clock"
        case .favorites: return "heart"
        case .profile: return "person"
        }
    }
    
    var selectedIcon: String {
        switch self {
        case .home: return "house.fill"
        case .schedule: return "clock.fill"
        case .favorites: return "heart.fill"
        case .profile: return "person.fill"
        }
    }
}

// MARK: - Placeholder Views

struct ScheduleView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 60))
                    .foregroundColor(Color("AppPrimary"))
                
                Text("Schedule")
                    .font(.system(size: 28, weight: .bold))
                
                Text("Your upcoming trips will appear here")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
}

struct FavoritesView: View {
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
                
                Text("Favorites")
                    .font(.system(size: 28, weight: .bold))
                
                Text("Save places you love to visit later")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
}

struct ProfileView: View {
    @Environment(AppCoordinator.self) private var coordinator
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color("AppPrimary"))
                
                VStack(spacing: 8) {
                    Text("Abhisek Prusty")
                        .font(.system(size: 28, weight: .bold))
                    
                    Text("abhisek@example.com")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                }
                
                VStack(spacing: 16) {
                    ProfileMenuItem(icon: "gear", title: "Settings")
                    ProfileMenuItem(icon: "bell", title: "Notifications")
                    ProfileMenuItem(icon: "questionmark.circle", title: "Help & Support")
                    
                    Button {
                        coordinator.logout()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 20))
                            
                            Text("Logout")
                                .font(.system(size: 17, weight: .medium))
                            
                            Spacer()
                        }
                        .foregroundColor(.red)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                        )
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
            }
            .padding(.top, 40)
        }
    }
}

struct ProfileMenuItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button {
            // Action
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color("AppPrimary"))
                
                Text(title)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
        }
    }
}

// MARK: - Preview

#Preview {
    MainTabView()
        .environment(AppCoordinator())
}
