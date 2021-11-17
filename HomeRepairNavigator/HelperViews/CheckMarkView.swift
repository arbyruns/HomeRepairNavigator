//
//  CheckMarkView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/17/21.
//

import SwiftUI

struct CheckMarkView: View {

    @Binding var checked: Bool
    @Binding var trimValue: CGFloat

    var animateData: CGFloat {
        get {trimValue}
        set { trimValue = newValue }
    }

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: trimValue)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 35, height: 35)
                .foregroundColor(checked ? Color.blue : Color.gray.opacity(0.2))
            Circle()
                .trim(from: 0, to: 1)
                .fill(checked ? Color.blue : Color.gray.opacity(0.2))
                .frame(width: 25, height: 25)
            if checked {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
        }
    }
}

struct CheckMarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckMarkView(checked: .constant(false), trimValue: .constant(1))
    }
}
