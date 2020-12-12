//
//  Message.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-10.
//

import Foundation
import Firebase


struct Message:Hashable{
    var message,receivedUid,sendUid:String?
    var time:Timestamp?

    init(dictionary:[String:Any]) {
        self.message = dictionary["message"] as? String
        self.receivedUid = dictionary["receivedUid"] as? String
        self.sendUid = dictionary["sendUid"] as? String
        self.time = dictionary["time"] as? Timestamp
    }
}
