//
//  RewardsViewModel.swift
//  Bny
//
//  Created by Abirami on 20/07/26.
//

import Foundation

protocol RewardViewModelDelegate: AnyObject {

    func didReceiveRewards()

    func didReceiveRewardsError(_ message: String)
}

final class RewardsViewModel {

    weak var delegate: RewardViewModelDelegate?

    private let rewardService = RewardService()

    var rewards: [RewardData] = []

    func getRewards() {

        self.rewardService.getRewards { [weak self] result in

            switch result {

            case .success(let response):

                self?.rewards = response.data ?? []

                self?.delegate?.didReceiveRewards()

            case .failure(let error):

                self?.delegate?.didReceiveRewardsError(error.localizedDescription)
            }
        }
    }
}
