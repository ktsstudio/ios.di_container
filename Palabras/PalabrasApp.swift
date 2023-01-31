import SwiftUI

@main
struct PalabrasApp: App {
	@StateObject private var container = AppContainer()

    var body: some Scene {
        WindowGroup {
			container.makeMainAssembly().view()
        }
    }
}
