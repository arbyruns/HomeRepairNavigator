//
//  BudgetView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/18/21.
//

import SwiftUI

struct BudgetView: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var userBudget: String

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Please indicate your project estimate:")
                    .font(.headline)
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(budgetInfo) { item in
                            BudgetItemView(budgetSelection: $userBudget, text: item.item, image: item.image)
                        }
                    }
                    .padding(.top)
                Spacer()
            }
        }
    }
}


struct BudgetItemView: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var budgetSelection: String
    let text: String
    let image: String

    var body: some View {
        RoundedRectangle(cornerRadius: 13, style: .continuous)
        //                .stroke(style: StrokeStyle(lineWidth: 2))
            .fill(budgetSelection == text ? Color("buttonColorRed") : Color("Background"))
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.6), radius: 3, x: 0, y: 0)
            .shadow(color: Color("Shadow").opacity(colorScheme == .dark ? 1.0 : 0.3), radius: 6, x: 0, y: 0)
            .frame(width: 155, height: 65)
            .overlay(
                VStack {
                    HStack {
                        Image(systemName: image)
                        Text(text)
                            .font(.subheadline)
                    }
                    .font(.title2)
                }
            )
            .onTapGesture {
                playHaptic(style: "light")
                withAnimation {
                    if budgetSelection == text {
                        budgetSelection = ""
                    } else {
                        budgetSelection = text
                    }
                }
            }
    }
}


struct BudgetInfo: Identifiable {
    let id = UUID()
    var item: String
    var image: String
}

var budgetInfo = [
    BudgetInfo(item: "-", image: "dollarsign.circle"),
    BudgetInfo(item: "0 - 5,000", image: "dollarsign.circle"),
    BudgetInfo(item: "5,001 - 10,000", image: "dollarsign.circle"),
    BudgetInfo(item: "10,001 - 25,000", image: "dollarsign.circle"),
    BudgetInfo(item: "25,001 - 50,000", image: "dollarsign.circle"),
    BudgetInfo(item: "50,001 - or more", image: "dollarsign.circle")
]

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView(userBudget: .constant("50,000"))
    }
}
