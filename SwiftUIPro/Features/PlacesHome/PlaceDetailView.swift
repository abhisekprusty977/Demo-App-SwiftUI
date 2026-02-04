import SwiftUI

struct PlaceDetailView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(\.dismiss) private var dismiss
    let place: Place
    @State private var selectedTab: DetailTab = .overview
    @State private var isFavorite = false
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    heroImage
                    contentSection
                }
            }
            .ignoresSafeArea(edges: .top)
            
            // Top buttons
            VStack {
                HStack {
                    backButton
                    Spacer()
                    favoriteButton
                }
                .padding(.horizontal, 20)
                .padding(.top, 60)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Components

private extension PlaceDetailView {
    
    var heroImage: some View {
        ZStack(alignment: .bottomLeading) {
            // Mountain gradient (placeholder for actual image)
            mountainGradient
                .frame(height: 500)
            
            // Gradient overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    .clear,
                    .clear,
                    .black.opacity(0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            
            // Title and location
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(place.name)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Price")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.8))
                        Text("$\(place.price)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 14))
                    Text("\(place.location), \(place.country)")
                        .font(.system(size: 16))
                }
                .foregroundColor(.white.opacity(0.9))
            }
            .padding(24)
            .padding(.bottom, 20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 32))
        .padding(.horizontal, 20)
        .padding(.top, 120)
    }
    
    var contentSection: some View {
        VStack(spacing: 24) {
            tabSelector
            
            if selectedTab == .overview {
                overviewContent
            } else {
                detailsContent
            }
            
            bookButton
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
        .padding(.bottom, 40)
    }
    
    var tabSelector: some View {
        HStack(spacing: 0) {
            TabButton(
                title: "Overview",
                isSelected: selectedTab == .overview
            ) {
                selectedTab = .overview
            }
            
            TabButton(
                title: "Details",
                isSelected: selectedTab == .details
            ) {
                selectedTab = .details
            }
            
            Spacer()
        }
    }
    
    var overviewContent: some View {
        VStack(spacing: 20) {
            // Stats
            HStack(spacing: 16) {
                StatBadge(
                    icon: "clock.fill",
                    value: place.duration
                )
                
                StatBadge(
                    icon: "thermometer.medium",
                    value: place.temperature
                )
                
                StatBadge(
                    icon: "star.fill",
                    value: String(format: "%.1f", place.rating)
                )
                
                Spacer()
            }
            
            // Description
            Text(place.description)
                .font(.system(size: 15))
                .foregroundColor(.secondary)
                .lineSpacing(6)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var detailsContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            DetailRow(title: "Location", value: "\(place.location), \(place.country)")
            DetailRow(title: "Duration", value: place.duration)
            DetailRow(title: "Temperature", value: place.temperature)
            DetailRow(title: "Best Season", value: "Spring & Autumn")
            DetailRow(title: "Difficulty", value: "Moderate")
            DetailRow(title: "Altitude", value: "3,776m")
        }
        .padding(.vertical, 8)
    }
    
    var bookButton: some View {
        Button {
            // Book action
        } label: {
            HStack(spacing: 12) {
                Text("Book Now")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.primary)
            )
        }
        .padding(.top, 8)
    }
    
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.3))
                        .blur(radius: 4)
                )
        }
    }
    
    var favoriteButton: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: isFavorite ? "bookmark.fill" : "bookmark")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(Color.black.opacity(0.3))
                        .blur(radius: 4)
                )
        }
    }
    
    var mountainGradient: some View {
        let gradients: [Gradient] = [
            Gradient(colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.9)]),
            Gradient(colors: [Color.cyan.opacity(0.7), Color.blue.opacity(0.9)]),
            Gradient(colors: [Color.indigo.opacity(0.7), Color.blue.opacity(0.8)]),
            Gradient(colors: [Color.teal.opacity(0.7), Color.cyan.opacity(0.8)]),
        ]
        
        let index = abs(place.name.hashValue) % gradients.count
        
        return LinearGradient(
            gradient: gradients[index],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Tab Button

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 18, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                if isSelected {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.primary)
                        .frame(width: 40, height: 3)
                } else {
                    Color.clear
                        .frame(width: 40, height: 3)
                }
            }
            .padding(.trailing, 24)
        }
    }
}

// MARK: - Stat Badge

struct StatBadge: View {
    let icon: String
    let value: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
    }
}

// MARK: - Detail Row

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Detail Tab Enum

enum DetailTab {
    case overview
    case details
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PlaceDetailView(place: Place.samples[0])
    }
    .environment(AppCoordinator())
}
