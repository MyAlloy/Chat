//
//  ChatCustomizationParameters.swift
//  Chat
//
//  Created by Alisa Mylnikova on 02.04.2026.
//

import SwiftUI
import ExyteMediaPicker

struct ChatCustomizationParameters {
    var isListAboveInputView: Bool = true
    var showScrollToBottomButton: Bool = true
    var showNetworkConnectionProblem: Bool = false
    var showDateHeaders: Bool = true
    var isScrollEnabled: Bool = true
    var autoFocusTextInputOnChatOpen: Bool = false
    var showMessageMenuOnLongPress: Bool = true
    var keyboardDismissMode: UIScrollView.KeyboardDismissMode = .none
    var messageMenuAnimationDuration: CGFloat = 0.3
    var contentInsets: UIEdgeInsets = .zero

    var scrollToParams: ScrollToParams?
    var onContentOffsetChange: ((CGFloat) -> Void)? // Internal → External
    var onWillDisplayCell: ((Message) -> Void)?
    var onTransactionReady: ((TableUpdateTransaction) -> Void)?

    var olderMessagesPaginationHandler: PaginationHandler?
    var newerMessagesPaginationHandler: PaginationHandler?
    var localization = ChatLocalization.defaultLocalization // these can be localized in the Localizable.strings files
    var reactionDelegate: ReactionDelegate?
    var listSwipeActions = ListSwipeActions()
    
    // MARK: Patched customizations

    /// When `true`, the chat list compensates for UIKit's automatic top
    /// safe-area content inset by applying an equal-and-opposite offset
    /// to `tableView.contentInset.top`. Useful when a host extends the
    /// chat under a system bar via `.ignoresSafeArea(.top)`: without
    /// compensation, the auto-applied top safe-area inset surfaces at
    /// the visual bottom (due to the 180° rotation in `.conversation`
    /// mode) and opens a gap above whatever sits below the list.
    /// `contentInsetAdjustmentBehavior` stays on `.automatic` so cell
    /// layout (UIHostingConfiguration) isn't disturbed.
    var cancelTopSafeAreaInset: Bool = false
    
    /// When `true`, the chat list hides the iOS 26 `UIScrollEdgeEffect`
    /// fades at both ends of the table. Pair with `.ignoresSafeArea(.top)`
    /// and `.toolbarBackgroundVisibility(.hidden, ...)` to let messages
    /// scroll cleanly under a transparent Liquid Glass nav bar.
    var disableScrollEdgeEffects: Bool = false
}

public struct ScrollToParams: Equatable {
    public enum ScrollTo: Equatable {
        case messageID(messageID: String, position: UITableView.ScrollPosition, offset: CGFloat)
        case tableOffset(CGFloat)
        case newestMessage
        case oldestMessage
    }

    let scrollTo: ScrollTo

    public init(messageID: String, position: UITableView.ScrollPosition, offset: CGFloat = 0) {
        self.scrollTo = .messageID(messageID: messageID, position: position, offset: offset)
    }

    public init(offset: CGFloat) {
        self.scrollTo = .tableOffset(offset)
    }

    public init(_ scrollTo: ScrollTo) {
        self.scrollTo = scrollTo
    }
}

struct MessageCustomizationParameters {
    var showTimeView = true
    var showUsername = false
    var linkPreviewLimit = 8
    var shouldShowPreviewForLink: (URL) -> Bool = { _ in true }
    var font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15))
    var timeFont = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 10))

    // avatar
    var showAvatar = true
    var avatarSize: CGFloat = 32
    var tapAvatarClosure: ChatView.TapAvatarClosure?
    var avatarBuilder: ((User)->(AnyView))?
}

struct InputViewCustomizationParameters {
    var externalInputText: String? // External → Internal
    var onInputTextChange: ((String) -> Void)? // Internal → External
    var availableInputs: [AvailableInputType] = [.text, .audio, .media]
    var recorderSettings = RecorderSettings()
    var mediaPickerParameters = MediaPickerParameters()
}

public typealias MediaPickerParameters = ExyteMediaPicker.MediaPickerCutomizationParameters
