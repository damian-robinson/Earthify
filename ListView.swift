// Earthify List View ©2024 SMPL LLC

import SwiftData
import SwiftUI

struct ListView: View {
		
		@Environment(\.modelContext) var context: ModelContext
		@Query var calculations: [Calculation]
		
		var body: some View {
				NavigationSplitView {
						
						if calculations.isEmpty {
								VStack {
										ContentUnavailableView(
												"No calculations, yet.",
												systemImage: "list.bullet"
										)
										.foregroundStyle(.secondary)
								}
						} else {
								List {
										ForEach(calculations, id: \.self) { calculation in
												NavigationLink {
														CalculationView(calculation: calculation)
												} label: {
														Text("\(calculation.observationTitle)")
												}
										}
										.onDelete(perform: deleteItems)
								}
						}
				} detail: {
						Text("Select an item")
				}
				.navigationTitle("Calculations")
		}
		
		// Function to delete items
		private func deleteItems(offsets: IndexSet) {
				withAnimation {
						for index in offsets {
								context.delete(calculations[index])
						}
				}
		}
}

#Preview {
		ListView()
}


