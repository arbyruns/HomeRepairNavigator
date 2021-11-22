//
//  ProfileScreenView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/18/21.
//

import SwiftUI

struct ProfileScreenView: View {
//TODO: Convert this data to AppStorage. Improve zipcode box to be more front and center.

    @Binding var zipCode: String


    var body: some View {
        VStack(alignment: .leading) {
            Text("Project Information")
                .bold()
                .textCase(.uppercase)
                .font(.title)
            VStack(alignment: .leading) {
                Spacer()
                ProfileTextView(textValue: $zipCode, titleFieldName: "Zip Code", placeHolderText: "12345")
                Spacer()
            }
            .padding()
            .offset(y: -50)
        }
        .padding()
    }
}

struct ProfileScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreenView(zipCode: .constant("00000"))
    }
}

struct ProfileTextView: View {
    @Binding var textValue: String

    let titleFieldName: String
    let placeHolderText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(titleFieldName)
                .bold()
                .font(.title)
            TextField(placeHolderText, text: $textValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())

        }
    }
}
