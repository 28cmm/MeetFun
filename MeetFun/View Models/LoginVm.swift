//
//  LoginVm.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-08.
//

import Foundation
import Firebase

class LoginVm: ObservableObject{
    var emailz:String = ""
    var passwordz:String = ""
    @Published var pushActive = false
    
    func login(email:String, password:String, completion:@escaping()->Void){
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let err = err{
                print(err.localizedDescription)
            }else{
                self.pushActive = true
                completion()
            }
        }
    }
}
