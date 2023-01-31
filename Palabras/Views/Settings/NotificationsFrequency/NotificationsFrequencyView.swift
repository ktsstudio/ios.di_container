import SwiftUI

struct NotificationsFrequencyView: View {
	@ObservedObject private var viewModel: NotificationsFrequencyViewModel
	@Environment(\.rootPresentationMode) private var rootPresentationMode
	
	init(viewModel: NotificationsFrequencyViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		VStack {
			Picker("Frequency", selection: $viewModel.frequency) {
				Text("10").tag(NotificationsFrequency.ten)
				Text("15").tag(NotificationsFrequency.fifteen)
				Text("30").tag(NotificationsFrequency.thirty)
			}
			.padding()
			Button("Save", action: onSave)
		}
	}

	private func onSave() {
		viewModel.onSave()
		rootPresentationMode.wrappedValue.dismiss()
	}
}

struct NotificationsFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
		NotificationsFrequencyAssemblyPreview().view()
    }
}
