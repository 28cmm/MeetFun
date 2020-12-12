//
//  AddEventView.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-08.
//

import SwiftUI
import JGProgressHUD_SwiftUI
struct AddEventView: View {
    @State private var edit = "Enter your bio"
    @ObservedObject var addEventVM = AddEventVm()
    @ObservedObject var fireVM = FireBase()
    @EnvironmentObject var hudCoordinator: JGProgressHUDCoordinator
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @State private var birthDate = Date()
    
    var body: some View {
        //title
        VStack(alignment:.center){
            //body
            ScrollView(.vertical, showsIndicators: false){
                HStack{
                    Text("tittle")
                    Spacer()
                    TextField("tittle", text: $addEventVM.tittle)
                        .padding()
                        .background(Color.discoverBackground)
                        .frame(width:WIDTHSPACE*5)
                        .cornerRadius(5)
                }.normalText()
                .padding(.vertical)
                
                HStack{
                    Text("Location")
                    Spacer()
                    TextField("location", text: $addEventVM.location)
                        .padding()
                        .background(Color.discoverBackground)
                        .frame(width:WIDTHSPACE*5)
                        .cornerRadius(5)
                }.normalText()
                .padding(.vertical)
                
                HStack{
                    Text("when")
                    Spacer()
                    VStack {
                        DatePicker(selection: $addEventVM.time, in: Date()..., displayedComponents: .date) {
                        }
                        .colorInvert()
                        .colorMultiply(Color.discoverBackground)
                        
                        .frame(width:WIDTHSPACE*5)
                           // .background(Color.discoverBackground)
                        .foregroundColor(Color.white)
                            .cornerRadius(5)
                    }
//                    TextField("When", text: $addEventVM.time)
                    
                }.normalText()
                .padding(.vertical)
                
                HStack{
                    Text("Description")
                    Spacer()
                    TextField("description", text: $addEventVM.description)
                        .padding()
                        .background(Color.discoverBackground)
                        .frame(width:WIDTHSPACE*5)
                        .cornerRadius(5)
                    
                }.normalText()
                .padding(.vertical)
            }.padding(.vertical)
            .padding()
            Spacer(minLength: 0)
            //event
            Button("Create Event"){
                if addEventVM.tittle.isEmpty == false && addEventVM.location.isEmpty == false && addEventVM.description.isEmpty == false{
                    hudCoordinator.showHUD {
                        let hud = JGProgressHUD()
                        hud.textLabel.text = "Creating.."
                        hud.dismiss(afterDelay: 1)
                        return hud
                    }
                    addEventVM.addEvent {
                        
                    }
                }else{
                    hudCoordinator.showHUD {
                        let hud = JGProgressHUD()
                        hud.textLabel.text = "Please fill out everything"
                        hud.dismiss(afterDelay: 1)
                        return hud
                    }
                }
                
            }
            .font(.system(size: 15, weight: .bold))
            .frame(width:WIDTHSPACE*3)
            .padding()
            .background(Color(#colorLiteral(red: 0.3513801396, green: 0.7654538751, blue: 0.1472723484, alpha: 1)))
            .foregroundColor(.white)
            .cornerRadius(10)
            .normalShadow()
            .padding(.bottom,HEIGHTSPACE10*1.2)
            
        }
        
        .background(Color.white)
        .navigationBarHidden(true)
        
        
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
