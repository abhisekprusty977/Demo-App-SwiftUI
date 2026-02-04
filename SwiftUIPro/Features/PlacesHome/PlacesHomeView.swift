import SwiftUI

struct PlacesHomeView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @State private var searchText = ""
    @State private var selectedFilter: PlaceFilter = .mostViewed
    @State private var places = Place.samples
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    header
                    searchBar
                    popularPlaces
                    placesGrid
                }
                .padding(.horizontal, 0)
                .padding(.bottom, 120)
            }
        }
    }
}

// MARK: - Components

private extension PlacesHomeView {
    
    var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Dashboard")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("Hi, Abhisek 👋")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text("Explore the world")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "person.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(Color("AppPrimary"))
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    var searchBar: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search places", text: $searchText)
                    .textFieldStyle(.plain)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
            )
            
            Button {
                // Filter action
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                    )
            }
        }
        .padding(.horizontal, 20)
    }
    
    var popularPlaces: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Popular places")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button {
                    // View all
                } label: {
                    Text("View all")
                        .font(.system(size: 14))
                        .foregroundColor(Color("AppPrimary"))
                }
            }
            
            filterButtons
        }
        .padding(.horizontal, 20)
    }
    
    var filterButtons: some View {
        HStack(spacing: 12) {
            FilterButton(
                title: "Most Viewed",
                isSelected: selectedFilter == .mostViewed
            ) {
                selectedFilter = .mostViewed
            }
            
            FilterButton(
                title: "Nearby",
                isSelected: selectedFilter == .nearby
            ) {
                selectedFilter = .nearby
            }
            
            FilterButton(
                title: "Latest",
                isSelected: selectedFilter == .latest
            ) {
                selectedFilter = .latest
            }
            
            Spacer()
        }
    }
    
    var placesGrid: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(places) { place in
                    PlaceCard(place: place) {
                        coordinator.showPlaceDetail(place: place)
                    }
                }
            }
            .padding(.horizontal, 20)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .contentMargins(.horizontal, 0, for: .scrollContent)
    }
}

// MARK: - Filter Button

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.primary : Color.white)
                )
        }
    }
}

// MARK: - Place Card

struct PlaceCard: View {
    let place: Place
    let action: () -> Void
    @State private var isFavorite = false
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 0) {
                    Image(place.imageName)
                        .resizable()
                        .frame(width: 270, height: 405)
                    
                    // Info overlay at bottom
                    VStack(alignment: .leading, spacing: 8) {
                        Text(place.name + ", \(place.location)")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                        
                        HStack(spacing: 12) {
                            HStack(spacing: 4) {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 14))
                                Text("\(place.location), \(place.country)")
                                    .font(.system(size: 14))
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.yellow)
                                Text(String(format: "%.1f", place.rating))
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        }
                        .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: 270, height: 405)
                .clipShape(RoundedRectangle(cornerRadius: 32))
                .shadow(color: .black.opacity(0.15), radius: 15, y: 8)
                
                // Favorite button
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 20))
                        .foregroundColor(isFavorite ? .red : .white)
                        .frame(width: 48, height: 48)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(0.3))
                                .blur(radius: 2)
                        )
                }
                .padding(16)
            }
        }
        .buttonStyle(.plain)
        .scrollTransition { content, phase in
            content
                .scaleEffect(phase.isIdentity ? 1.0 : 0.85)
                .opacity(phase.isIdentity ? 1.0 : 0.7)
        }
    }
}

// MARK: - Filter Enum

enum PlaceFilter {
    case mostViewed
    case nearby
    case latest
}

// MARK: - Preview

#Preview {
    NavigationStack {
        PlacesHomeView()
    }
    .environment(AppCoordinator())
}
