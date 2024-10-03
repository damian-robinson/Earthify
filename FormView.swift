// Earthify FormView ©2024 SMPL LLC

import SwiftUI
import SwiftData

struct FormView: View { // Create View struct

	// Get context from environment; Set as model context
	@Environment(\.modelContext) private var modelContext: ModelContext
	
	// Display Vars
	@State private var viewObstructed: Double = 0.0
	@State private var viewVisible: Double = 0.0
	@State private var isMetric: Bool = false
	@State private var heightUnit: String = ""
	@State private var lengthUnit: String = ""
	
	// Input Vars
	@State private var observationTitle: String = ""
	@State private var observerHeight: String = ""
	@State private var objectHeight: String = ""
	@State private var objectDistance: String = ""
	
	// Calculation constants
	@State private var earthRadius: Double = 20_898_480.0
	@State private var horizonRefraction: Double = 0.000593
	@State private var atmosphericRefraction: Double = 0.077
	
	// Calculation Vars
	@State private var geometricDistance: Double = 0.0
	@State private var adjustedDistance: Double = 0.0
	@State private var horizonDistance: Double = 0.0
	@State private var initialDrop: Double = 0.0
	@State private var finalDrop: Double = 0.0
	
	var body: some View { // Create body View
		
		VStack { // Vertically stacked layout
		
			Form { // Form view for text & toggle
					
				Section(header: Text("Calculated Output Data")) { // Output section
						
					HStack { // Display obstructed amount
						Text("Obstructed Amount:")
						Spacer()
						Text("\(viewObstructed, specifier: "%.2f") \(heightUnit)")
								.bold()
					}
					
					HStack { // Display visible amount
						Text("Visible Amount:")
						Spacer()
						Text("\(viewVisible, specifier: "%.2f") \(heightUnit)")
							.bold()
					}
				}
				
				Section(header: Text("Observation Input Data")) { // Input section
						
					HStack { // Observation title input
						Text("Observation Title:")
						Spacer()
						TextField("Enter Title", text: $observationTitle)
							.inputBox()
							.keyboardType(.default)
					}
					
					HStack { // Observer height input
						Text("Observer Height:")
						Spacer()
						TextField("Enter Height", text: $observerHeight)
							.inputBox()
							.keyboardType(.decimalPad)
							.onTapGesture {
							}
							.onChange(of: observerHeight) {
								computeResults(
									isMetric: isMetric,
									observerHeight: Double(observerHeight) ?? 0.0,
									objectHeight: Double(objectHeight) ?? 0.0,
									objectDistance: Double(objectDistance) ?? 0.0
								)
							}
					}
						
						HStack {
							Text("Object Height:")
							Spacer()
							TextField("Enter Height", text: $objectHeight)
							.inputBox()
							.keyboardType(.decimalPad)
							.onChange(of: objectHeight) {
								computeResults(
									isMetric: isMetric,
									observerHeight: Double(observerHeight) ?? 0.0,
									objectHeight: Double(objectHeight) ?? 0.0,
									objectDistance: Double(objectDistance) ?? 0.0
								)
							}
						}
						
						HStack {
							Text("Object Distance")
							Spacer()
							TextField("Enter Distance", text: $objectDistance)
							.inputBox()
							.onChange(of: objectDistance) {
								computeResults(
									isMetric: isMetric,
									observerHeight: Double(observerHeight) ?? 0.0,
									objectHeight: Double(objectHeight) ?? 0.0,
									objectDistance: Double(objectDistance) ?? 0.0
								)
							}
						}
						
						Toggle(isOn: $isMetric, label: { Text("Enable Metric System") })
							.padding(.vertical)
							.onChange(of: isMetric) {
								heightUnit = isMetric ? "m" : "ft"
								lengthUnit = isMetric ? "km" : "mi"
							}
						
						Button("Save") { saveResults() }
							.padding(.vertical)
							.frame(maxWidth: .infinity)
							.buttonStyle(.bordered)
							.disabled(
								observationTitle.isEmpty ||
								observerHeight.isEmpty ||
								objectHeight.isEmpty ||
								objectDistance.isEmpty
							)
				}
				.keyboardType(.decimalPad)
			}
		}
	}
	
	private func computeResults( // Function to compute results
		
		// Input vars
		isMetric: Bool,
		observerHeight: Double,
		objectHeight: Double,
		objectDistance: Double)
	{ if observerHeight != 0.0 && objectHeight != 0.0 && objectDistance != 0.0 {
			// Computed vars
			heightUnit = isMetric ? "m" : "ft"
			lengthUnit = isMetric ? "km" : "mi"
			let convertedDistance: Double = isMetric ? objectDistance * 1000
			: objectDistance * 5280
			geometricDistance = sqrt(2 * observerHeight * earthRadius)
			adjustedDistance = geometricDistance / cos(horizonRefraction)
			horizonDistance = adjustedDistance * (1 + atmosphericRefraction)
			initialDrop = (convertedDistance * convertedDistance) /
			(2 * earthRadius)
			finalDrop = initialDrop * (convertedDistance / horizonDistance)
			
			// Display Vars
			viewObstructed = finalDrop
			viewVisible = max(0.0, objectHeight - viewObstructed)
		}
	}
	
	
	private func saveResults() { // Function to save results
			
		let newCalculation = Calculation(
			observationTitle: observationTitle,
			observerHeight:   Double(observerHeight) ?? 6.0,
			objectHeight:     Double(objectHeight) ?? 6.0,
			objectDistance:   Double(objectDistance) ?? 1.0,
			viewObstructed:   viewObstructed,
			viewVisible:      viewVisible,
			heightUnit:       heightUnit,
			lengthUnit: 			lengthUnit
		)
		
		modelContext.insert(newCalculation)
		
		do {// Save the new calculation
			try modelContext.save()

			viewObstructed   = 0.0
			viewVisible      = 0.0
			observationTitle = ""
			observerHeight   = ""
			objectHeight     = ""
			objectDistance   = ""

		} catch { // Handle save error
			print("Failed to save: \(error)")
		}
	}
}

#Preview {
	FormView()
}
