//
//  LottieView.swift
//  LottieView
//
//  Created by robevans on 9/7/21.
//

import Foundation
import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView

    let filename: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
    let view = UIView(frame: .zero)

//      Loading the Animation
      let animationView = AnimationView()
//      let animation = Animation.named("58558-work-from-home-treadmill")
        let animation = Animation.named(filename)
      animationView.animation = animation
      animationView.loopMode = .loop
      animationView.contentMode = .scaleAspectFit
      animationView.play()

      animationView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(animationView)

// Adding the constraints
      NSLayoutConstraint.activate([
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
      ])

    return view
  }

  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) { }
}
