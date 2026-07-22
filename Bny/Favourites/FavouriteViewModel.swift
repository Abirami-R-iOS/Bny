//
//  FavouriteViewModel.swift
//  Bny
//
//  Created by Abirami on 21/07/26.
//

import Foundation

final class FavouriteViewModel {

    private let favouriteService = FavouriteService()

    var didFetchFavouriteCategories: (([FavouriteResponseModel]) -> Void)?

    var didReceiveFavouriteCategoriesError: ((String) -> Void)?

    func getFavourites() {

        let request = FavouriteRequest(
            latitude: "12.865796",
            longitude: "80.2053096",
            userId: UserSession.shared.userId,
            favourite: "1"
        )

        self.favouriteService.getFavourites(request: request) { result in

            switch result {

            case .success(let response):

                self.didFetchFavouriteCategories?(response.data ?? [])

            case .failure(let error):

                self.didReceiveFavouriteCategoriesError?(error.localizedDescription)
            }
        }
    }
}
