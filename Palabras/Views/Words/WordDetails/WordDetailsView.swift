import SwiftUI

struct WordDetailsView: View {

	@ObservedObject private var viewModel: WordDetailsViewModel

	init(viewModel: WordDetailsViewModel) {
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
	}
}

struct WordDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		WordDetailsAssemblyPreview().view()
    }
}
