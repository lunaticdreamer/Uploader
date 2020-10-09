//
//  UploaderSwiftUIApp.swift
//  UploaderSwiftUI
//
//  Created by Steven Rockarts on 2020-10-08.
//

import SwiftUI

@main
struct UploaderSwiftUIApp: App {
    let musicItem = MusicItem(
      id: 192678693,
      artistName: "Leonard Cohen",
      trackName: "Hallelujah",
      collectionName: "The Essential Leonard Cohen",
      preview: "https://audio-ssl.itunes.apple.com/itunes-assets/Music/16/10/b2/mzm.muynlhgk.aac.p.m4a",
      artwork: "https://is1-ssl.mzstatic.com/image/thumb/Music/v4/77/17/ab/7717ab31-46f9-48ca-7250-9f565306faa7/source/1000x1000bb.jpg")

    var body: some Scene {
        WindowGroup {
            SongDetailView(musicItem: .constant(musicItem))
        }
    }
}
