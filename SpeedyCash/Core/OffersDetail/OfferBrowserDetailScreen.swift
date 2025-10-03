//
//  LoginScreen.swift
//  PayDay
//
//  Created by Bhavananda das on 20.12.2024.
//

import SwiftUI

struct OfferBrowserDetailScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    
    @StateObject var viewModel: LoginViewModel
    
    @State private var progress: Double = 0.0
    @State private var zoomScale: CGFloat = 1.0
    
    @State var shareText: ShareText?
    
    init(urlString: String) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(urlString: urlString))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            topBar
            
            if let url =  URL(string: viewModel.urlString) {
                WebView(zoomScale: $zoomScale, url: url, viewModel: viewModel, progress: $progress)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Please, enter a url.")
            }
            
            //bottomBar
        }
        .sheet(item: $shareText) { shareText in
            ActivityView(text: shareText.text)
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
        }
    }
    
    private var topBar: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack(spacing: 4) {
                    Image(systemName: "lock.fill")
                    Text("URL"
                        .replacingOccurrences(of: "https://", with: "")
                        .replacingOccurrences(of: "http://", with: ""))
                    .font(.system(size: 15, weight: .semibold))
                }
                .foregroundStyle(.white)
                
                HStack {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                    }

                    Spacer()
                    Button {
                        dismiss()
        //              if zoomScale < 1.5 {
        //                zoomScale += 0.1
        //              }
                    } label: {
                      Image(systemName: "xmark")
                        .foregroundStyle(.black)
                    }
                   // HStack(spacing: 16) {
//                        Button {
//                            if zoomScale < 1.5 {
//                                zoomScale += 0.1
//                            }
//                        } label: {
//                            Image(systemName: "textformat.size")
//                                .foregroundStyle(.blue)
//                        }
//                        .disabled(zoomScale >= 1.5)
//                        .opacity(zoomScale >= 1.5 ? 0.5 : 1)
                        
//                        Button {
//                            viewModel.reload()
//                            zoomScale = 1.0
//                        } label: {
//                            Image(systemName: "arrow.clockwise")
//                                .foregroundStyle(.blue)
//                        }
                    //}
                    
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
            .background(.white)
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle())
                .frame(height: 2)
                .opacity(progress < 1.0 ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: progress)
        }
    }
    
    private var bottomBar: some View {
        HStack {
            Button(action: {
                viewModel.goBack()
            }) {
                Image(systemName: "chevron.backward")
            }
            .disabled(!(viewModel.webView?.canGoBack ?? false))
            .opacity(!(viewModel.webView?.canGoBack ?? false) ? 0.5 : 1)
            
            //Spacer()
            
            
            
            Spacer()
            Button(action: {
                viewModel.goForward()
                print("forward")
            }) {
                Image(systemName: "chevron.forward")
            }
            .disabled(!(viewModel.webView?.canGoForward ?? false))
            .opacity(!(viewModel.webView?.canGoForward ?? false) ? 0.5 : 1)
            Spacer()
            
            Button("Home", systemImage: "house.fill") {
                viewModel.loadURLString()
            }
        }
        .padding()
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(.black)
        .foregroundStyle(.blue)
    }
}

//#Preview {
//    LoginScreen()
//}

struct ActivityView: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: [text], applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>) {}
}

struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}
