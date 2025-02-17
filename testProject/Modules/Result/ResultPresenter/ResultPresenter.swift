//
//  Presenter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 15.02.2025.
//

import Foundation

protocol ResultPresenterProtocol: AnyObject {
    func fetchFact()
}

final class ResultPresenter: ResultPresenterProtocol {
    weak var view: ResultViewProtocol?

    init(view: ResultViewProtocol) {
        self.view = view
    }

    func fetchFact() {
        guard let url = URL(string: "https://uselessfacts.jsph.pl/api/v2/facts/random") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }

            do {
                let fact = try JSONDecoder().decode(Fact.self, from: data)
                DispatchQueue.main.async {
                    self?.view?.showFact(fact.text)
                }
            } catch {
                print("Failed to decode:", error)
            }
        }
        task.resume()
    }
}
