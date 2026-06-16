import SwiftUI

struct CategoryCarouselPickerView: View {
    let categories: [Category]
    @Binding var selected: Category?

    // Layout constants
    private let itemWidth: CGFloat = 32
    private let itemHeight: CGFloat = 32
    private let spacing: CGFloat = 12

    @State private var scrollID: UUID? = nil

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { outer in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: spacing) {
                        ForEach(categories) { item in
                            GeometryReader { geo in
                                let frame = geo.frame(in: .named("CategoryCarouselSpace"))
                                let centerX = outer.size.width / 2
                                let distance = abs(frame.midX - centerX)
                                let maxDistance: CGFloat = 160 // scale threshold
                                let t = max(0, min(1, 1 - distance / maxDistance))
                                let scale = 1.0 + 0.12 * t

                                Image(item.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(12)
                                    .foregroundStyle(Color(item.iconColorName))
                                    .background(Color(item.iconColorName).opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .scaleEffect(scale)
                                    .animation(.spring(response: 0.3, dampingFraction: 0.9), value: scale)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
                                            scrollID = item.id
                                            selected = item
                                        }
                                    }
                            }
                            .id(item.id)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollTargetLayout()
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrollID, anchor: .center)
                .coordinateSpace(name: "CategoryCarouselSpace")
                .onAppear {
                    scrollID = selected?.id ?? categories.first?.id
                }
                .onChange(of: scrollID) { _, newID in
                    if let id = newID, let found = categories.first(where: { $0.id == id }) {
                        selected = found
                    }
                }
            }
            .frame(height: itemHeight + 16)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
        }
    }
}

#Preview {
    @Previewable @State var selected: Category? = nil
    return CategoryCarouselPickerView(categories: [], selected: $selected)
}
