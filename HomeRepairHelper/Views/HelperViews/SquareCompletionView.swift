//
//  CompletedView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/18/21.
//

import SwiftUI

struct SquareCompletionView: View {
    @Binding var checked: Bool
    @Binding var trimValue: CGFloat

    var animateData: CGFloat {
        get {trimValue}
        set { trimValue = newValue }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .trim(from: 0, to: trimValue)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 25, height: 25)
                .foregroundColor(checked ? Color("buttonColorRed") : Color.gray.opacity(0.2))
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .trim(from: 0, to: 1)
                .fill(checked ? Color("buttonColorRed") : Color.gray.opacity(0.2))
                .frame(width: 20, height: 20)
        }
    }
}

struct SquareCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        SquareCompletionView(checked: .constant(false), trimValue: .constant(1))
    }
}
