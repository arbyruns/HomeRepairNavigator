//
//  PhotoAlbumView.swift
//  HomeRepairHelper
//
//  Created by robevans on 5/20/22.
//

import SDWebImageSwiftUI
import SwiftUI

struct PhotoAlbumView: View {
    @State private var showImagePhotoPicker = false
    @State private var pickedImage = UIImage(named: "placeHolder")! // not currently being used
    @State private var imageURL: [NSURL] = []
    @State private var imageView = ""
    @State private var fullScreenImage = false
    @StateObject var coredataVM = CoreDataManager()
    @StateObject var projectData = ProjectData()


    @Binding var showProjectView: Bool

    var body: some View {
        ZStack {
            Color("Background")
            NavigationView {
                VStack {
                    if !imageView.isEmpty {
                    ZoomableScrollView {
                        WebImage(url: URL(string: imageView))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: fullScreenImage ? nil : 350, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                            .onTapGesture {
                                withAnimation {
                                    fullScreenImage.toggle()
                                }
                            }
                    }
                    } else {
                        Spacer()
                        Text("Click **Add Photo** to track \nphotos related to your project.")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    if !fullScreenImage {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(spacing: 25) {
                                ForEach(coredataVM.savedEntities) { entity in
                                    if entity.projectName == projectData.projectName {
                                        ForEach(entity.photoURL ?? [], id: \.self) { item in
                                            let string = String(describing: item)
                                            if string.isValidURL {
                                                ZStack(alignment: .top) {
                                                    WebImage(url: URL(string: string))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 125, height: 125, alignment: .center)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                        .padding(.bottom)
                                                        .onTapGesture {
                                                            imageView = string
                                                        }
                                                    HStack {
                                                        Spacer()
                                                        Image(systemName: "xmark.circle.fill")
                                                            .font(.title3)
                                                            .padding(.trailing, 6)
                                                            .padding(.top, 6)
                                                            .onTapGesture {
                                                                withAnimation {
                                                                    coredataVM.deletePhoto(entity, item)
                                                                }
                                                            }
                                                    }
                                                }
                                                .onAppear {
                                                    // setting the first image on appearance
                                                    if let image = entity.photoURL?.first {
                                                        imageView = String(describing: image)
                                                    }
                                                }
                                            }

                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        Spacer()
                        Button(action: {
                            playHaptic(style: "medium")
                            withAnimation {
                                showImagePhotoPicker = true
                            }
                        })
                        {
                            ButtonTextView(smallButton: false, text: "Add Photo")
                                .padding()
                        }
                        .sheet(isPresented: $showImagePhotoPicker, onDismiss: {
                            for entity in coredataVM.savedEntities {
                                if entity.projectName == projectData.projectName {
                                    print(imageURL)
                                    if let imageURL = imageURL.last {
                                        print("save \(imageURL)")
                                        coredataVM.savePhoto(entity, imageURL)
                                    }
                                }
                            }
                        }) {
                            PhotoPicker(pickedImage: $pickedImage, imageURL: $imageURL)
                        }
                    }
                }

                .navigationBarTitle("Project Photos")
                .navigationBarItems(trailing:
                                        Button(action: {
                    showProjectView = false
                    playHaptic(style: "medium")
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title3)
                })
            }
        }
    }
}

struct PhotoAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoAlbumView(showProjectView: .constant(false))
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
