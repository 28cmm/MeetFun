//
//  MeetFunApp.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-07.
//

import SwiftUI
import Firebase
import JGProgressHUD_SwiftUI

// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        
        //        let db = Firestore.firestore()
        //        let settings = db.settings
        //        settings.areTimestampsInSnapshotsEnabled = true
        //        db.settings = settings
        UINavigationBar.appearance().barTintColor = NAVBACKGROUNDCOLOR
        UINavigationBar.appearance().tintColor = NAVTEXTCOLOR
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : NAVTEXTCOLOR]
        
        // print(">> your code here !!")
        return true
    }
}
@main
struct MeetFunApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            
            //            AddEventView()
            //            LoginView()
            JGProgressHUDPresenter{
//                NavigationView{
                    LoginView()
                        .edgesIgnoringSafeArea(.all)
//                    TabBarView()
                    
                
            }
        }
    }
}
