//
//  RegisterVM.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-08.
//

import Foundation
import Firebase

class RegisterVM: ObservableObject{
    var emailz:String = ""
    var passwordz:String = ""
    var name:String = ""
    @Published var pushActive = false
    
    func register(email:String, password:String, completion:@escaping(String)->Void){
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let err = err{
                print(err.localizedDescription)
            }else{
                self.pushActive = true
                completion(Auth.auth().currentUser!.uid)
            }
        }
    }
}
