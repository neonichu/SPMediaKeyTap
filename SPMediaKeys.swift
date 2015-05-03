import AppKit

public enum SPMediaKey {
    case PlayPause
    case Rewind
    case Forward
}

public typealias SPMediaKeyObserver = ((mediaKey: SPMediaKey) -> Void)

public class SPMediaKeys: NSObject {
    public override class func initialize() {
        NSUserDefaults.standardUserDefaults().registerDefaults([kMediaKeyUsingBundleIdentifiersDefaultsKey: SPMediaKeyTap.defaultMediaKeyUserBundleIdentifiers()])
    }


    private var keyTap: SPMediaKeyTap!
    private var observer: SPMediaKeyObserver?

    public func watch(newObserver: SPMediaKeyObserver) {
        keyTap = SPMediaKeyTap(delegate: self)

        if SPMediaKeyTap.usesGlobalMediaKeyTap() {
            keyTap.startWatchingMediaKeys()
        }

        observer = newObserver
    }

    public override func mediaKeyTap(keyTap: SPMediaKeyTap!, receivedMediaKeyEvent event: NSEvent!) {
        let keyCode = ((event.data1 & 0xFFFF0000) >> 16)
        let keyFlags = (event.data1 & 0x0000FFFF)
        let keyIsPressed = (((keyFlags & 0xFF00) >> 8)) == 0xA
        let keyRepeat = (keyFlags & 0x1)

        if keyIsPressed {
            switch Int32(keyCode) {
            case NX_KEYTYPE_PLAY:
                observer?(mediaKey:.PlayPause)
                break

            case NX_KEYTYPE_FAST:
                observer?(mediaKey:.Forward)
                break

            case NX_KEYTYPE_REWIND:
                observer?(mediaKey:.Rewind)
                break

            default:
                break
                
                // More cases defined in hidsystem/ev_keymap.h
            }
        }
    }
}
