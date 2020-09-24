//
//  TodoModel.swift
//  todoRealm
//
//  Created by Yoshinori Shibahara on 2020/09/25.
//

import Foundation
import RealmSwift

class TodoModel: Object {
    @objc dynamic var title: String? = nil
    @objc dynamic var date: String? = nil
}
