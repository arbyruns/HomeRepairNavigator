//
//  PhotoAlbumView.swift
//  HomeRepairHelper
//
//  Created by robevans on 5/20/22.
//

import SDWebImageSwiftUI
import SwiftUI

struct PhotoAlbumView: View {
    @AppStorage("UserDefaults_photoAlbumTabBar") var photoAlbumTabBar = false

    @State private var showImagePhotoPicker = false
    @State private var pickedImage = UIImage(named: "placeHolder")! // not currently being used
    @State private var imageURL: [NSURL] = []
    @State private var imageView = ""
    @State private var fullScreenImage = false
    @StateObject var coredataVM = CoreDataManager()
    @StateObject var projectData = ProjectData()
    @StateObject var telemtryData = TelemetryData()

    @Binding var showPhotoAlbumView: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if !imageView.isEmpty {
                        ZoomableScrollView {
                            WebImage(url: URL(string: imageView))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: fullScreenImage ? nil : 350, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.bottom)
                                .background(Color("Background"))
                                .onTapGesture {
                                    withAnimation {
                                        fullScreenImage.toggle()
                                    }
                                }
                        }
                        .background(Color("Background"))
                    } else {
                        Spacer()
                        Text("Click **Add Photo** to add all your before, \nduring, and after photos related to \nyour project.")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                    Spacer()
                    // MARK: - FullScreen Image
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
                                                    UITableView.appearance().backgroundColor = .clear
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
                                telemtryData.sendScreen(screen: "AddPhoto")
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
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: fullScreenImage ? nil :
                                        Button(action: {
                    showPhotoAlbumView = false
                    playHaptic(style: "medium")
                }) {
                    
                    Image(systemName: photoAlbumTabBar ? "" : "xmark.circle")
                        .font(.title3)
                })
            }
        }
    }
}

struct PhotoAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoAlbumView(showPhotoAlbumView: .constant(false))
            .colorScheme(.dark)
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
