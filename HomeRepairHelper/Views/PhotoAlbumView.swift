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
    @State private var pickedImage = UIImage(named: "placeHolder")!
    @State private var imageURL: [NSURL] = []
    @StateObject var coredataVM = CoreDataManager()
    @StateObject var projectData = ProjectData()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(spacing: 10) {
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
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "xmark.circle.fill")
                                                        .padding(.trailing, 8)
                                                        .padding(.top, 8)
                                                        .onTapGesture {
                                                            withAnimation {
                                                                coredataVM.deletePhoto(entity, item)
                                                            }
                                                        }
                                                }
                                            }
                                        }

                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    Image(uiImage: pickedImage)
                        .resizable()
                        .frame(width: 350, height: 350, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
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
                        .sheet(isPresented: $showImagePhotoPicker) {
                            PhotoPicker(pickedImage: $pickedImage, imageURL: $imageURL)
                        }
                    Button("Save") {

                        for entity in coredataVM.savedEntities {
                            print("photo url \(imageURL.last)")
                            if entity.projectName == projectData.projectName {
                                print(imageURL)
                                if let imageURL = imageURL.last {
                                    print("save \(imageURL)")
                                    coredataVM.savePhoto(entity, imageURL)
                                }
                            }
                        }

                    }
                }
                .navigationBarTitle("Project Photos")
            }
        }
    }
}

struct PhotoAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoAlbumView()
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
