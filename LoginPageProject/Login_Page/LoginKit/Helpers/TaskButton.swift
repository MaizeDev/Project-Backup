//
//  TaskButton.swift
//  Login_Page
//
//  Created by wheat on 12/2/25.
//

import SwiftUI

// MARK: - Custom Task Button, which will disable it's button action till it's task is completed!

/// 自定义任务按钮，该按钮将在任务完成前禁用其点击功能！

struct TaskButton: View {
    var title: String
    var task: () async -> Void
    var onStatusChange: (Bool) -> Void = { _ in }
    @State private var isLoading: Bool = false

    var body: some View {
        Button {
            Task {
                isLoading = true
                await task()
                /// Little optional Delay!
                /// 轻微的可选延迟。
                try? await Task.sleep(for: .seconds(0.1))
                isLoading = false
            }
        } label: {
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .opacity(isLoading ? 0 : 1)
                .overlay {
                    ProgressView()
                        .opacity(isLoading ? 1 : 0)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
        }
        .tint(Color.primary)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .animation(.easeInOut(duration: 0.25), value: isLoading)
        /// Disabling the button when it's performing its action
        /// 当按钮执行其功能时禁用它
        .disabled(isLoading)
        .onChange(of: isLoading) { _, newValue in
            /// Optional One!
            /// 可选 1
            withAnimation(.easeInOut(duration: 0.25)) {
                onStatusChange(newValue)
            }
        }
    }
}
