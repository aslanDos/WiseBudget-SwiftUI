import SwiftUI

protocol SwitcherItem: Hashable {
    var title: String { get }
    var icon: String { get }
    var color: Color { get }
}

struct TypeSwitcher<T>: View
where T: SwitcherItem & CaseIterable,
      T.AllCases: RandomAccessCollection {

    @Binding var selectedItem: T
    @Namespace private var namespace

    var body: some View {
        HStack(spacing: 0) {
            ForEach(T.allCases, id: \.self) { item in
                Button {
                    withAnimation(
                        .spring(
                            response: 0.35,
                            dampingFraction: 0.8
                        )
                    ) {
                        selectedItem = item
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: item.icon)
                            .poppins(.regular, 10, selectedItem == item ? .onAppSecondary : .textPrimary)

                        if selectedItem == item {
                            Text(item.title)
                                .poppins(.regular, 10, selectedItem == item ? .onAppSecondary : .textPrimary)
                                .transition(
                                    .opacity
                                        .combined(
                                            with: .move(edge: .trailing)
                                        )
                                )
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .foregroundStyle(
                        selectedItem == item
                            ? .white
                            : .primary
                    )
                    .background {
                        if selectedItem == item {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(item.color)
                                .matchedGeometryEffect(
                                    id: "selected",
                                    in: namespace
                                )
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(.cardBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: 14)
        )
    }
}

