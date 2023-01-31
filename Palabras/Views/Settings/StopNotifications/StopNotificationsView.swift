import SwiftUI

struct StopNotificationsView: View {
	@ObservedObject private var viewModel: StopNotificationsViewModel

	init(viewModel: StopNotificationsViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		VStack {
			DatePicker("Stop date", selection: $viewModel.date, displayedComponents: .hourAndMinute)
				.padding()
			NavigationLink {
				viewModel.notificationsFrequencyView()
			} label: {
				Text("Next")
			}
		}
	}
}

struct StopNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
		StopNotificationsAssemblyPreview().view()
    }
}
