//
//  Model.swift
//  OriginalApp
//
//  Created by Yoshinori Shibahara on 2020/10/05.
//

import Foundation
import Realm
import RealmSwift

class Model: Object {
    
    @objc dynamic var date: String? = nil
    @objc dynamic var text: String? = nil
    @objc dynamic var accessDate: String? = nil
}
