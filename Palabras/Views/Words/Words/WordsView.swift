import SwiftUI
import CoreData

struct WordsView: View {

	@ObservedObject private var viewModel: WordsViewModel
	@State var presentingNewWordView = false

	init(viewModel: WordsViewModel) {
		self.viewModel = viewModel
	}

    var body: some View {
        NavigationView {
            List {
				ForEach(viewModel.words) { word in
                    NavigationLink {
						viewModel.detailView(by: word.id)
                    } label: {
						HStack {
							VStack(alignment: .leading) {
								Text(word.word)
								word.translation.map {
									Text($0)
										.font(.system(.footnote))
										.foregroundColor(.gray)
								}
							}
							Spacer()
							Image(systemName: word.imageName)
								.foregroundColor(word.imageColor)
						}
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
					.sheet(isPresented: $presentingNewWordView) {
						viewModel.newWordView()
					}
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
		presentingNewWordView = true
    }

    private func deleteItems(offsets: IndexSet) {
		viewModel.deleteWords(at: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		WordsAssemblyPreview().view()
    }
}
