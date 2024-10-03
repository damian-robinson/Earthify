// Earthify App ©2024 SMPL LLC

import SwiftUI
import SwiftData

@main
struct Earthify: App { // Create app struct
	
	var modelContainer: ModelContainer { // Create model container
		
		let schema = Schema([Calculation.self]) // Create model schema
		
		let config = ModelConfiguration(schema: schema) // Create model config
		
		do { // Instantiate model container
			return try ModelContainer(for: schema, configurations: [config])
		} catch { // Handle errors
			fatalError("Couldn't create model container: \(error).")
		}
	}
	
	var body: some Scene { // Create body scene
	
		WindowGroup { // Create window group
			ContentView() // Load a view
		}
		.modelContainer(modelContainer) // Set model container
	}
}
