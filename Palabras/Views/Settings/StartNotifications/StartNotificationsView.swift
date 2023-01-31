import SwiftUI

struct StartNotificationsView: View {
	@ObservedObject private var viewModel: StartNotificationsViewModel

	init(viewModel: StartNotificationsViewModel) {
		self.viewModel = viewModel
	}

    var body: some View {
		NavigationView {
			VStack {
				DatePicker("Start date", selection: $viewModel.date, displayedComponents: .hourAndMinute)
					.padding()
				NavigationLink {
					viewModel.stopNotificationsView()
				} label: {
					Text("Next")
				}
				.isDetailLink(false)
			}
		}
    }
}

struct StartNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
		StartNotificationsAssemblyPreview().view()
    }
}
