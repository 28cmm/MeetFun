import SwiftUI
import JGProgressHUD_SwiftUI
 
struct NavigationBody: View {
    // This environment object is automatically set by JGProgressHUDPresenter.
    @EnvironmentObject var hudCoordinator: JGProgressHUDCoordinator
    var textSt:String
    
    init(textString:String) {
        self.textSt = textString
    }

    var body: some View {
        Button("Press Me") {
            // Simply call showHUD and return your HUD!
            hudCoordinator.showHUD {
                let hud = JGProgressHUD()
                hud.textLabel.text = textSt
                hud.dismiss(afterDelay: 1)
                return hud
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        // This presenter can present a fullscreen HUD.
        JGProgressHUDPresenter {
//            NavigationView {
                NavigationBody(textString: "good")
//            }
        }
    }
}
