import Foundation

struct Place: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let location: String
    let country: String
    let rating: Double
    let price: Int
    let imageName: String
    let duration: String
    let temperature: String
    let description: String
    
    init(
        id: UUID = UUID(),
        name: String,
        location: String,
        country: String,
        rating: Double,
        price: Int,
        imageName: String,
        duration: String,
        temperature: String,
        description: String
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.country = country
        self.rating = rating
        self.price = price
        self.imageName = imageName
        self.duration = duration
        self.temperature = temperature
        self.description = description
    }
}

// MARK: - Sample Data

extension Place {
    static let samples: [Place] = [
        Place(
            name: "Mount Fuji",
            location: "Tokyo",
            country: "Japan",
            rating: 4.8,
            price: 180,
            imageName: "Tokyo",
            duration: "6 hours",
            temperature: "12°C",
            description: "This iconic volcano is Japan's highest peak and one of the most recognized symbols of the country. Mount Fuji offers breathtaking views and a challenging climb that attracts thousands of visitors annually. The mountain is part of the Fuji-Hakone-Izu National Park and has been a sacred site for centuries."
        ),
        Place(
            name: "Andes Mountain",
            location: "South",
            country: "America",
            rating: 4.5,
            price: 230,
            imageName: "Andenes",
            duration: "8 hours",
            temperature: "16°C",
            description: "This vast mountain range is renowned for its remarkable diversity in terms of topography and climate. It features towering peaks, active volcanoes, deep canyons, expansive plateaus, and a rich variety of ecosystems. The Andes stretch along the entire western coast of South America."
        ),
        Place(
            name: "Swiss Alps",
            location: "Zurich",
            country: "Switzerland",
            rating: 4.9,
            price: 310,
            imageName: "Andenes",
            duration: "7 hours",
            temperature: "8°C",
            description: "The Swiss Alps are home to some of the most spectacular mountain scenery in the world. With pristine glaciers, charming alpine villages, and world-class ski resorts, this destination offers year-round adventure and stunning natural beauty."
        ),
        Place(
            name: "Rocky Mountains",
            location: "Colorado",
            country: "USA",
            rating: 4.7,
            price: 200,
            imageName: "Tokyo",
            duration: "9 hours",
            temperature: "14°C",
            description: "Stretching from Canada to New Mexico, the Rocky Mountains feature dramatic peaks, pristine wilderness, and abundant wildlife. The region offers incredible hiking, camping, and wildlife viewing opportunities across multiple national parks and forests."
        ),
        Place(
            name: "Mount Kilimanjaro",
            location: "Moshi",
            country: "Tanzania",
            rating: 4.6,
            price: 450,
            imageName: "Tokyo",
            duration: "12 hours",
            temperature: "18°C",
            description: "Africa's highest mountain is a dormant volcano with three volcanic cones. The climb to the summit takes you through five distinct climate zones, from tropical rainforest to arctic conditions at the peak. It's one of the world's most accessible high summits."
        ),
        Place(
            name: "Himalayan Range",
            location: "Nepal",
            country: "Nepal",
            rating: 5.0,
            price: 380,
            imageName: "Andenes",
            duration: "10 hours",
            temperature: "5°C",
            description: "Home to Mount Everest and eight of the world's fourteen highest peaks, the Himalayas are a trekker's paradise. This majestic range offers spiritual experiences, ancient monasteries, and some of the most challenging and rewarding mountaineering in the world."
        )
    ]
}
