import Foundation

enum AppRoute: Hashable {
    case login
    case dashboard
    case portfolioDetail(id: UUID)
}

