import SwiftUI
import UIKit

struct ContentView: View {
    @State private var text = ""
    @State private var image: UIImage?

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Button(action: paste) {
                    Text("粘贴")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .font(.title3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.4))
                        )
                    if text.isEmpty {
                        Text("复制内容后，点击「粘贴」显示在这里")
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 8)
                            .allowsHitTesting(false)
                    }
                }
                .frame(minHeight: 160)

                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("剪贴板")
        }
    }

    /// 读取系统剪贴板：文本（含 Emoji 表情）和图片类表情（贴纸等）
    private func paste() {
        let pasteboard = UIPasteboard.general
        text = pasteboard.string ?? ""
        image = pasteboard.image
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
