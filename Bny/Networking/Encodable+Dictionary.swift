//
//  Encodable+Dictionary..swift
//  Bny
//
//  Created by Abirami on 12/07/26.
//

import Foundation

extension Encodable {

    func toDictionary() -> [String: Any]? {

        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }

        guard let object = try? JSONSerialization.jsonObject(with: data) else {
            return nil
        }

        return object as? [String: Any]
    }
}
