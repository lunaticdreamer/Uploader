//
//  AudioPlayer.swift
//  UploaderSwiftUI
//
//  Created by Steven Rockarts on 2020-10-08.
//

import SwiftUI
import AVKit

struct AudioPlayer: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let player = AVPlayer(url: songUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.entersFullScreenWhenPlaybackBegins = true
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {

    }

    let songUrl: URL
}
