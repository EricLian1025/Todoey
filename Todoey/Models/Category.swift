//
//  Category.swift
//  Todoey
//
//  Created by EricLian on 2019/1/23.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object
{
    @objc dynamic var name :String = ""
    let ct_items = List<Item>() 

    //ex.
    let array = Array<String>() // new an empty array.
}


