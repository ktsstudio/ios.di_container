import SwiftUI

struct SettingsView: View {
	@ObservedObject private var viewModel: SettingsViewModel
	@State var isNotificationsConfigurationShown = false

	init(viewModel: SettingsViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		NavigationView {
			List {
				Button("Configure notifications", action: onConfigureNotifications)
				.sheet(isPresented: $isNotificationsConfigurationShown) {
					viewModel.startNotificationsView()
				}
				Toggle("Notifications are on", isOn: $viewModel.isNotificationsOn)
			}
		}
		.environment(\.rootPresentationMode, self.$isNotificationsConfigurationShown)
	}

	func onConfigureNotifications() {
		isNotificationsConfigurationShown = true
	}
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
		SettingsAssemblyPreview().view()
    }
}
