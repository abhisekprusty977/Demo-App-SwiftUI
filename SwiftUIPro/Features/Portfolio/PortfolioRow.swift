import SwiftUI

struct PortfolioRow: View, Equatable {
    let model: Portfolio

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.model.id == rhs.model.id
    }

    var body: some View {
        HStack {
            Image(systemName: "chart.bar.fill")
                .foregroundColor(Color("AppPrimary"))
                .font(.title2)
            
            Text(model.name)
                .font(.body)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    List {
        PortfolioRow(model: Portfolio(id: UUID(), name: "Apple"))
        PortfolioRow(model: Portfolio(id: UUID(), name: "Tesla"))
    }
}
