import SwiftUI

struct NewWordView: View {
	@ObservedObject private var viewModel: NewWordViewModel
	@Environment(\.presentationMode) var presentationMode

	init(viewModel: NewWordViewModel) {
		self.viewModel = viewModel
	}

	var body: some View {
		VStack {
			Text("Word")
			TextField("Word", text: $viewModel.word)
			Text("Translation")
			TextField("Translation", text: $viewModel.translation)
			Text("Is for learning")
			Toggle("Is for learning", isOn: $viewModel.isForLearning)
			Spacer()
			Button("Save", action: onSave)
			Spacer()
		}
		.padding()
    }

	private func onSave() {
		viewModel.onSave()
		presentationMode.wrappedValue.dismiss()
	}
}

struct NewWordView_Previews: PreviewProvider {
    static var previews: some View {
		NewWordAssemblyPreview().view()
    }
}
