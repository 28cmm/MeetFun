//
//  User.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-10.
//

import Foundation
import Firebase

struct User:Hashable{
    var userName,uid,email:String?
    var timeCreated:Timestamp?
    
    init(dictionary:[String:Any]) {
        self.timeCreated = dictionary["timeCreated"] as? Timestamp
        self.userName = dictionary["userName"] as? String
        self.uid = dictionary["uid"] as? String
        self.email = dictionary["email"] as? String
    }
}
