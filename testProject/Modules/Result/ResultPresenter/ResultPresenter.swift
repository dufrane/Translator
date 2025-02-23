//
//  Presenter.swift
//  testProject
//
//  Created by Dmytro Vasylenko on 15.02.2025.
//

import Foundation
import Alamofire

protocol ResultPresenterProtocol: AnyObject {
    func fetchFact()
}

final class ResultPresenter: ResultPresenterProtocol {
    weak var view: ResultViewProtocol?

    init(view: ResultViewProtocol) {
        self.view = view
    }

    func fetchFact() {
        let url = "https://uselessfacts.jsph.pl/api/v2/facts/random"

        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Fact.self) { response in
                switch response.result {
                case .success(let fact):
                    DispatchQueue.main.async {
                        self.view?.showFact(fact.text)
                    }
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                }
            }
    }
}
