//
//  ContentView.swift
//  LocalAuth
//
//  Created by JD Patel on 10/01/20.
//  Copyright © 2020 JD. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var bgColor = Color.red
    
    var body: some View {
     
        ZStack {
            bgColor
                .edgesIgnoringSafeArea(.all)
            Button("Logout") {
                self.bgColor = .red
            }
        }
        .onAppear(perform: authenticate)
        
    }
    
    func authenticate() {
        
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
         
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.bgColor = .green
                    } else {
                        self.bgColor = .red
                    }
                }
            }
        } else {
            self.bgColor = .red
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
