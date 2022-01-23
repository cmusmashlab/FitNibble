////
////  RefreshScrollView.swift
////  FitByteTrial
////
////  Created by Yuchen Liang on 6/6/21.
////
//
//import Foundation
//import SwiftUI
//import UIKit
//
//struct RefreshScrollView: UIViewRepresentable {
//    
//    var width: CGFloat
//    var height: CGFloat
//    @ObservedObject var manager: BLEManager
//    
//    func makeUIView(context: Context) -> UIScrollView {
//        let scrollView = UIScrollView()
//        scrollView.refreshControl = UIRefreshControl()
//        scrollView.refreshControl?.addTarget(context, action: #selector(Coordinator.handleRefreshControl(sender:)), for: .valueChanged)
//        
//        let refreshVC = UIHostingController(rootView: BLEDeviceView(bleManager: manager, isConnected: .constant(true), isScanning: .constant(true)))
//        refreshVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
//        
//        scrollView.addSubview(refreshVC.view)
//        
//        return scrollView
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {}
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self, manager: manager)
//    }
//    
//    class Coordinator: NSObject {
//        var refreshScrollView: RefreshScrollView
//        var manager: BLEManager
//        
//        init(_ refreshScrollView: RefreshScrollView, manager: BLEManager) {
//            self.refreshScrollView = refreshScrollView
//            self.manager = manager
//        }
//        
//        @objc func handleRefreshControl(sender: UIRefreshControl) {
//            sender.endRefreshing()
//            self.manager.stopScanning()
//            self.manager.startScanning()
//        }
//    }
//}
//
//struct RefreshScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader { geometry in
//            NavigationView {
//                RefreshScrollView(width: geometry.size.width, height: geometry.size.height, manager: BLEManager())
//            }
//        }
//    }
//}
