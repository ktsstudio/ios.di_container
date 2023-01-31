//
//  WordDetailsView.swift
//  Palabras
//
//  Created by Aleksandr Anosov on 15.09.22.
//

import SwiftUI

struct WordDetailsView: View {

	@ObservedObject private var viewModel: WordDetailsViewModel

	init(viewModel: WordDetailsViewModel) {
		self.viewModel = viewModel
	}

    var body: some View {
		Text(viewModel.text)
    }
}

struct WordDetailsView_Previews: PreviewProvider {
    static var previews: some View {
		WordDetailsAssemblyPreview().view()
    }
}
