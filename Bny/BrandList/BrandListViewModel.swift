//
//  BrandListViewModel.swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//


import Foundation

protocol BrandViewModelDelegate: AnyObject {

    func didReceiveBrandList()

    func didReceiveError(_ message: String)
}




class BrandViewModel {
    
    var didFetchBrandList: (([BrandListResponseModel]) -> Void)?

    var didReceiveError: ((String) -> Void)?

    weak var delegate: BrandViewModelDelegate?

    private let service = BrandService()

    var brandsList = [BrandListResponseModel]()

    func getBrandList(categoryId: Int) {

        let request = BrandRequestModel(categoryId: String(categoryId),
                                        latitude: "12.8658005",
                                        longitude: "80.2053196",
                                        userId: UserSession.shared.userId,
                                        favourite: "0", radius: "")

        service.getBrandList(request: request) { [weak self] result in

            switch result {

            case .success(let response):

                self?.brandsList = response.data ?? []

                DispatchQueue.main.async {

                    self?.didFetchBrandList?(response.data ?? [])
                }

            case .failure(let error):

                DispatchQueue.main.async {

                    self?.delegate?.didReceiveError(error.localizedDescription)
                }
            }
        }
    }
}
