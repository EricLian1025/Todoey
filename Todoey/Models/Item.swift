//
//  Item.swift
//  Todoey
//
//  Created by EricLian on 2019/1/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import RealmSwift


class Item : Object
{
  @objc  dynamic var title : String = ""
  @objc  dynamic var  done : Bool = false
    @objc dynamic var date : Date?
    
    var parentcategory = LinkingObjects(fromType: Category.self, property: "ct_items")
}
