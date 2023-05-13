import Foundation
import ReplayKit
import AVKit

public class ScreenRecorder {
    var assetWriter: AVAssetWriter!
    var videoInput: AVAssetWriterInput!
    
    public func startRecording(recordingHandler: @escaping (Error?) -> Void) {
        let fileName = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
        let fileURL = URL(fileURLWithPath: Self.filePath(fileName))
        try? FileManager.default.removeItem(at: fileURL)
        
        assetWriter = try! AVAssetWriter(
            outputURL: fileURL,
            fileType: AVFileType.mp4
        )
        let videoOutputSettings: Dictionary<String, Any> = [
            AVVideoCodecKey : AVVideoCodecType.h264,
            AVVideoWidthKey : UIScreen.main.bounds.size.width,
            AVVideoHeightKey : UIScreen.main.bounds.size.height
        ];
        
        videoInput  = AVAssetWriterInput(mediaType: AVMediaType.video, outputSettings: videoOutputSettings)
        videoInput.expectsMediaDataInRealTime = true
        assetWriter.add(videoInput)
        
        RPScreenRecorder.shared().startCapture(handler: { (sample, bufferType, error) in
            recordingHandler(error)
            
            if CMSampleBufferDataIsReady(sample) {
                if self.assetWriter.status == AVAssetWriter.Status.unknown {
                    self.assetWriter.startWriting()
                    self.assetWriter.startSession(atSourceTime: CMSampleBufferGetPresentationTimeStamp(sample))
                }
                
                if self.assetWriter.status == AVAssetWriter.Status.failed {
                    print("Error occured, status = \(self.assetWriter.status.rawValue), \(self.assetWriter.error!.localizedDescription) \(String(describing: self.assetWriter.error))")
                    return
                }
                
                if bufferType == .video {
                    if self.videoInput.isReadyForMoreMediaData {
                        self.videoInput.append(sample)
                    }
                }
            }
            
        }) { (error) in
            recordingHandler(error)
            print("Error occured \(String(describing: error))")
        }
    }
    
    func stopRecording(handler: @escaping (Error?) -> Void) {
        RPScreenRecorder.shared().stopCapture { (error) in
            handler(error)
            self.videoInput.markAsFinished()
            self.assetWriter.finishWriting {
                print(Self.fetchAllRecordings())
            }
        }
    }
    
    private static var folderName = "ScreenRecordings"
    private class func createReplaysFolder() {
        // path to documents directory
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        if let documentDirectoryPath = documentDirectoryPath {
            // create the custom folder path
            let replayDirectoryPath = documentDirectoryPath.appending("/\(folderName)")
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: replayDirectoryPath) {
                do {
                    try fileManager.createDirectory(
                        atPath: replayDirectoryPath,
                        withIntermediateDirectories: false,
                        attributes: nil
                    )
                } catch {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    private class func filePath(_ fileName: String) -> String {
        createReplaysFolder()
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] as String
        return "\(documentsDirectory)/\(folderName)/\(fileName).mp4"
    }
    
    class func fetchAllRecordings() -> Array<URL> {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let replayPath = documentsDirectory?.appendingPathComponent("/\(folderName)")
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: replayPath!, includingPropertiesForKeys: nil, options: [])
        return directoryContents
    }
}
