// Earthify App Item View ©2024 SMPL LLC

import SwiftUI
import SwiftData

struct CalculationView: View {
	
	@Environment(\.modelContext) private var context: ModelContext
	var calculation: Calculation
	
	var body: some View {
	
		Form {
				
			Text("\(calculation.observationTitle)")
				.padding(.vertical)
				.frame(maxWidth: .infinity)
				.font(.largeTitle)
				.bold()
			
			HStack {
				Text("Observer Height:")
				Spacer()
				Text("\(calculation.observerHeight, specifier: "%.2f") \(calculation.heightUnit)")
			}
			.padding(.vertical)
			
			HStack {
				Text("Object Height:")
				Spacer()
				Text("\(calculation.objectHeight, specifier: "%.2f") \(calculation.heightUnit)")
			}
			.padding(.vertical)
			
			HStack {
				Text("Object Distance:")
				Spacer()
				Text("\(calculation.objectDistance, specifier: "%.0f") \(calculation.lengthUnit)")
			}
			.padding(.vertical)
			
			HStack {
				Text("View Obstructed:")
				Spacer()
				Text("\(calculation.viewObstructed, specifier: "%.2f") \(calculation.heightUnit)")
			}
			.padding(.vertical)
			
			HStack {
				Text("View Visible:")
				Spacer()
				Text("\(calculation.viewVisible, specifier: "%.2f") \(calculation.heightUnit)")
			}
			.padding(.vertical)
		}
		.font(.title2)
	}
}
