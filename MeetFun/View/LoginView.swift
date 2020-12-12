//
//  Login.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-07.
//

import SwiftUI
import JGProgressHUD_SwiftUI

struct LoginView: View {
    @ObservedObject private var registerVM = RegisterVM()
    @ObservedObject private var loginVM = LoginVm()
    @State var pushActive = false
    @EnvironmentObject var hudCoordinator: JGProgressHUDCoordinator
    var body: some View {
        NavigationView{
            ScrollView{
                //body
                VStack{
                    HStack{
                        Spacer()
                        Image("m1")
                            .normalImage()
                            .foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
                            .frame(width:HEIGHTSPACE*8, height:HEIGHTSPACE*8)
                        Spacer()
                    }.padding()
                    VStack{
                        TextField("name", text: $registerVM.name)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .normalShadow()
                            .padding()
                        
                        TextField("Email", text: $registerVM.emailz)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .normalShadow()
                            .padding()
                            
                        SecureField("Password",text: $registerVM.passwordz)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .normalShadow()
                            .padding()
                    }
                    //.padding(.horizontal,WIDTHSPACE*2)
                    .normalText()
                    
                    
                    Button("Sign Up"){
                        if registerVM.passwordz.isEmpty == false && registerVM.emailz.isEmpty == false && registerVM.name.isEmpty == false{
                            hudCoordinator.showHUD {
                                let hud = JGProgressHUD()
                                hud.textLabel.text = "Signing Up"
                                hud.dismiss(afterDelay: 1)
                                return hud
                            }
                            registerVM.register(email: registerVM.emailz, password: registerVM.passwordz) { uid in
                                FireBase.shared.addUser(email: registerVM.emailz, uid: uid, name: registerVM.name)
                                self.pushActive = true
                            }
                        }else{
                            hudCoordinator.showHUD {
                                let hud = JGProgressHUD()
                                hud.textLabel.text = "Email or password or userName is missing"
                                hud.dismiss(afterDelay: 1)
                                return hud
                            }
                        }
                    }
                    .padding()
                    .frame(width:WIDTHSPACE*6)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(6)
                    .normalShadow()
                    Button("Login"){
                        if registerVM.passwordz.isEmpty == false && registerVM.emailz.isEmpty == false{
                            hudCoordinator.showHUD {
                                let hud = JGProgressHUD()
                                hud.textLabel.text = "Login"
                                hud.dismiss(afterDelay: 1)
                                return hud
                            }
                            loginVM.login(email: registerVM.emailz, password: registerVM.passwordz) {
                                print("successfully Login: ",registerVM.emailz)
                                self.pushActive = true
                            }
                        }else{
                            hudCoordinator.showHUD {
                                let hud = JGProgressHUD()
                                hud.textLabel.text = "Email or password is missing"
                                hud.dismiss(afterDelay: 1)
                                return hud
                            }
                        }
                        
                    }
                    .padding()
                    .frame(width:WIDTHSPACE*6)
                    .foregroundColor(Color.white)
                    .background(Color(#colorLiteral(red: 0.3513801396, green: 0.7654538751, blue: 0.1472723484, alpha: 1)))
                .cornerRadius(6)
                    .normalShadow()
                    
                    Spacer()
                    NavigationLink(
                        destination: NavigationLazyView(TabBarView()),
                        isActive: self.$pushActive
                    ){EmptyView()}
                }.padding(.horizontal)
            }
            .background(Color.white)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
        
    }
    
    
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
