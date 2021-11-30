//
//  TutorialView.swift
//  HomeRepairNavigator
//
//  Created by robevans on 11/23/21.
//

import SwiftUI

struct TutorialView: View {
    @AppStorage("UserDefault_FirstRun") var showFirstRun = false
    @AppStorage("UserDefault_showTutorial") var showTutorial = true



    @State var counter = 0
    @State var tutorialOne = false
    @State var tutorialTwo = false
    @State var tutorialThree = false
    @State var scale = false

    var body: some View {
        ZStack {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Home Repair Helper")
                    .font(.title)
                    .bold()
                    .kerning(2)
                    .padding()
                Text("We have compiled a series of questions for you to consider before, during and after your project to help protect you from a shady contractor and become your own quality control manager. Each question will request a yes or no answer from you, which will either prompt you to a helpful tip or move you forward to the next question. ")
                    .padding(8)

                VStack {
                    HStack {
                        if tutorialTwo {
                            CheckMarkView(checked: .constant(true), trimValue: .constant(1))
                                .padding(.leading,5)
                        }
                        Text("Have you researched the project?")
                            .strikethrough(tutorialTwo ? true : false )
                            .foregroundColor(tutorialTwo ? .gray : Color("FontColor"))
                            .font(.callout)
                            .padding()
                        Spacer()
                        Button(action: {
                        }) {
                            Image(systemName: tutorialOne ? "chevron.down" : "chevron.right")
                                .foregroundColor(Color("FontColor"))
                                .padding(.trailing,8)
                        }
                    }
                    if tutorialOne {
                        HStack {
                            Button(action: {
                            }) {
                                ButtonTextView(smallButton: true, text: "Yes")
                                    .scaleEffect(scale ? 1.2 : 1.0)
                            }
                            Button(action: {
                            }) {
                                ButtonTextView(smallButton: true, text: "No")
                                    .scaleEffect(scale ? 0.7 : 1.0)

                            }
                        }
                        .padding()
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("borderColor"), lineWidth: 1)
                )
                .padding(.horizontal)
                .frame(height: 125)
                if tutorialOne {
                Text("Tapping **Yes** the item will be marked as completed.")
                    .multilineTextAlignment(.center)
                    .padding(8)
                }
                if tutorialThree {
                    Text("Tapping **No** will provide additional information to assist you with your repairs.")
                    .multilineTextAlignment(.center)
                    .padding(8)
                }
                Button(action: {
                    withAnimation {
                        counter += 1
                        if counter == 1 {
                            // show first tutorial
                            tutorialOne = true
                        }
                        if counter == 2 {
                            // show second part of the tutorial
                            tutorialTwo = true
                            scale = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                                withAnimation {
                                    scale = false
                                }
                            }
                        }
                        if counter == 3 {
                            tutorialTwo = false
                            tutorialThree = true
                        }
                        if counter == 4 {
                            showTutorial = false
                        }
                    }
                }) {
                    ButtonTextView(smallButton: false, text: tutorialThree ? "Finish" : "Next")
                        .padding()
                }
            }
            .fullScreenCover(isPresented: $showFirstRun,
                             onDismiss: { print("dismissed!") },
                             content: { WelcomeScreen(showWelcomeScreen: .constant(false)) })
        }
    }
}

func expandButton(enable: Bool) -> Bool {
    if enable {
        return true
    } else {
        return false
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
