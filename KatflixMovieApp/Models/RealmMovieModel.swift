//
//  RealmMovieModel.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 5.03.24.
//

import Foundation
import RealmSwift

class RealmMovieModel: Object {
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var poster: String
    @Persisted var addedDate: Date
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
