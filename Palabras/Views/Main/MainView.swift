import SwiftUI

struct MainView: View {
	@ObservedObject private var viewModel: MainViewModel

	init(viewModel: MainViewModel) {
		self.viewModel = viewModel
	}

    var body: some View {
		TabView {
			viewModel.wordsView()
				.tabItem {
					Label("Words", systemImage: "w.square")
				}
			viewModel.settingsView()
				.tabItem {
					Label("Settings", systemImage: "gear")
				}
		}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
		MainAssemblyPreview().view()
    }
}
