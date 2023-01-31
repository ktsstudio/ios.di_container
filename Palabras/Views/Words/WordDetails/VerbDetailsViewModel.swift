//
//  WordDetailsViewModel.swift
//  Palabras
//
//  Created by Aleksandr Anosov on 15.09.22.
//

import Foundation

@MainActor
final class WordDetailsViewModel: ObservableObject {

	@Published var text: String

	private var service: WordsService

	init(service: WordsService, text: String) {
		self.service = service
		self.text = text
	}
}
