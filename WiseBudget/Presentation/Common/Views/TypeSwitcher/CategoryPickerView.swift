import SwiftUI

struct CategoryPickerView: View {
    @Environment(\.dismiss) private var dismiss

    let title: String
    let categories: [Category]
    let selected: Category?
    let onSelect: (Category) -> Void

    init(title: String = "Categories", categories: [Category], selected: Category?, onSelect: @escaping (Category) -> Void) {
        self.title = title
        self.categories = categories
        self.selected = selected
        self.onSelect = onSelect
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            SheetHeader(title: title) {
                EmptyView()
            }

            ScrollView {
                VStack(spacing: 8) {
                    ForEach(categories) { item in
                        let isSelected = (selected?.id == item.id)
                        ZStack(alignment: .bottomTrailing) {
                            CategoryCard(
                                categoryName: item.name,
                                categoryIconName: item.iconName,
                                categoryIconColor: Color(item.iconColorName)
                            )

                            if isSelected {
                                Image("star.fill")
                                    .poppins(.semibold, 10, AppPalette.yellow800.color)
                                    .padding(6)
                                    .offset(x: -4, y: -4)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onSelect(item)
                            dismiss()
                        }
                    }
                }
                .padding(.vertical)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .background(Color.mainBackground)
    }
}

#Preview {
    CategoryPickerView(categories: [], selected: nil, onSelect: { _ in })
}
