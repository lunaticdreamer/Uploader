//
//  SongDetailView.swift
//  UploaderSwiftUI
//
//  Created by Steven Rockarts on 2020-10-08.
//

import SwiftUI

struct SongDetailView: View {

    @Binding var musicItem: MusicItem
    @State private var playMusic = false
    @ObservedObject var download = SongDownload()
    var musicImage: UIImage? = nil


    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    Image("c_urlsession_card_artwork")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: reader.size.height / 2)
                        .cornerRadius(50)
                        .padding()
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    Text("\(self.musicItem.trackName) - \(self.musicItem.artistName)")
                    Text("\(self.musicItem.collectionName)")
                    Button(action: self.downloadButtonTapped){
                        Text(self.download.downloadLocation == nil ? "Download" : "Listen")
                    }
                }
            }
        }.sheet(isPresented: self.$playMusic) {
            return AudioPlayer(songUrl: self.download.downloadLocation!)
        }
    }

    func downloadButtonTapped() {
        if self.download.downloadLocation == nil {
            guard let previewUrl = self.musicItem.previewUrl else {
                return
            }
            self.download.fetchSongAtUrl(previewUrl)
        } else {
            self.playMusic = true
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView()
    }
}
