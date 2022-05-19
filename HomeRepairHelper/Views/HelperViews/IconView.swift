//
//  IconView.swift
//  IconView
//
//  Created by robevans on 8/24/21.
//

import SwiftUI

struct IconView: View {

    var image: String
    var color: String
    var text: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.title2)
                .frame(width: 35, height: 35, alignment: .center)
                .background(Color(color))
                .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
            Text(text)
                .bold()
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(image: "circle", color: "SettingColor1", text: "Share")
    }
}
