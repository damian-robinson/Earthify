// Earthify Calculation Data Model ©2024 SMPL LLC

import Foundation
import SwiftData

@Model class Calculation { // Create data model class
		
		// Declare property vars
		var observationTitle: String
		var observerHeight:   Double
		var objectHeight:     Double
		var objectDistance:   Double
		var viewObstructed:   Double
		var viewVisible:      Double
		var heightUnit:       String
		var lengthUnit:			  String
		
		init( // Initialize model
				observationTitle: String,
				observerHeight:   Double,
				objectHeight:     Double,
				objectDistance:   Double,
				viewObstructed:   Double,
				viewVisible:      Double,
				heightUnit:       String,
				lengthUnit:			  String
		) {
				self.observationTitle = observationTitle
				self.observerHeight   = observerHeight
				self.objectHeight     = objectHeight
				self.objectDistance   = objectDistance
				self.viewObstructed   = viewObstructed
				self.viewVisible      = viewVisible
				self.heightUnit       = heightUnit
			self.lengthUnit					= lengthUnit
		}
}
