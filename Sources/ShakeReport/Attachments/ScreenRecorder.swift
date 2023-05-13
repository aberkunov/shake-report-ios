import Foundation
import ReplayKit

public class ScreenRecorder {
    let screenRecorder = ScreenRecorder()
    
    
    public func startRecording() {
        let recorder = RPScreenRecorder.shared()

        recorder.startRecording{ error in
            if let error {
                print(error.localizedDescription)
            } else {
                
            }
        }
    }

    public func stopRecording() {
        let recorder = RPScreenRecorder.shared()

        recorder.stopRecording { [unowned self] (preview, error) in
            if let preview {
//                preview.previewControllerDelegate = self
//                self.present(preview, animated: true)
            }
        }
    }
}

//extension ScreenRecorder: RPPreviewViewControllerDelegate {
//    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
//        dismiss(animated: true)
//    }
//}
