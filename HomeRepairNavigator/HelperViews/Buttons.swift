//
//  Buttons.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/15/21.
//

import SwiftUI

struct ButtonTextView: View {
    let smallButton: Bool
    let text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: smallButton ? 35 : 55)
            .frame(maxWidth: .infinity)
            .background(Color("buttonColorPurple"))
            .cornerRadius(10)
    }
}



struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        ButtonTextView(smallButton: false, text: "Next")
        ButtonTextView(smallButton: true, text: "Yes")
    }
}
