//
//  HomeViewModal.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation

final class HomeViewModel {

    private let homeService = HomeService()

    var didFetchCategories: (([CategoryResponseModel]) -> Void)?

    var didReceiveError: ((String) -> Void)?

    func getCategories() {

        let request = CategoryRequest(
            latitude: "12.865796",
            longitude: "80.2053096",
            userId: UserSession.shared.userId,
            favourite: "0"
        )

        self.homeService.getCategories(request: request) { result in

            switch result {

            case .success(let response):

                self.didFetchCategories?(response.data ?? [])

            case .failure(let error):

                self.didReceiveError?(error.localizedDescription)
            }
        }
    }
}
