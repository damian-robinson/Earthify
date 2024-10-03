// Earthify ContentView ©2024 SMPL LLC

import SwiftData
import SwiftUI

struct ContentView: View { // Create content View
	
	@State private var selectedTab: String = "FormTab" // Create selection var
	
	var body: some View { // Create body View
		
		TabView(selection: $selectedTab) { // Create tab view
			
			FormView() // Display FormView
				.tabItem { // Set tab text & icon
					Image(systemName: "ruler")
					Text("New")
				}
			
			ListView() // Display ListView
				.tabItem { // Set tab text & icon
					Image(systemName: "list.bullet")
					Text("Saved")
				}
		}
	}
}

#Preview {
	ContentView()
}
