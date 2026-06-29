//
//  RewardsEntity.swift
//  Bny
//
//  Created by Abirami on 28/06/26.
//

import Foundation

enum RewardTab {
    case rewards
    case specials
    case history

    var title: String {
        switch self {
        case .rewards: return AppStrings.Rewards_Title
        case .specials: return AppStrings.Specials
        case .history: return AppStrings.History
        }
    }
}
