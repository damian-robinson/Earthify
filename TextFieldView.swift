// Earthify TextField View ©2024 SMPL LLC

import SwiftUI

extension TextField {
		
	func inputBox() -> some View { // Return some view
								
		self // Set customizations on self
			.frame(maxWidth: 150)
			.multilineTextAlignment(.trailing)
			.lineLimit(1)
			.textFieldStyle(.roundedBorder)
			.padding(.vertical)
	}
}
