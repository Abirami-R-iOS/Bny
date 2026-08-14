//
//  RewardsService.swift
//  Bny
//
//  Created by Abirami on 20/07/26.
//

import Foundation
import Alamofire

final class RewardService {
    
    func getRewards(completion: @escaping(Result<RewardsResponse, NetworkError>) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserSession.shared.accessToken)"
        ]
        
        APIManager.shared.request(
            APIEndPoints.rewards,
            method: .get,
            headers: headers,
            responseModel: RewardsResponse.self
        ) { result in
            
            completion(result)
        }
    }
    
    func getHistory(completion: @escaping(Result<HistoryResponse, NetworkError>) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(UserSession.shared.accessToken)"
        ]
        
        APIManager.shared.request(
            APIEndPoints.history,
            method: .get,
            headers: headers,
            responseModel: HistoryResponse.self
        ) { result in
            
            completion(result)
        }
        
    }
}
