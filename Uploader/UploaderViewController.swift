

import UIKit

class UploaderViewController: UIViewController, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
  
  //SimpleHTTPServerWithUpload.py
  let url = "http://127.0.0.1:8000"
  var responseData = Data()
  @IBOutlet weak var progressView: UIProgressView!
  
  lazy var sampleImageURLs: [URL] = Bundle.main.urls(forResourcesWithExtension: "jpg",
                                                     subdirectory: nil) ?? []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let path = Bundle.main.url(forResource: "swift", withExtension: "jpg")
    let data: Data = try! Data(contentsOf: path!)
    
    var request = URLRequest(url: URL(string: "http://c66e380731f2.ngrok.io/swift.jpg")!)
    request.httpMethod = "POST"
    request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
    uploadFiles(request: request, data: data)
  }
  
  func uploadFiles(request: URLRequest, data: Data) {
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
    let task = session.uploadTask(with: request, from: data)
    task.resume()
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    if error != nil {
      print("session \(session) occurred error \(String(describing: error?.localizedDescription))")
    } else {
      print("session \(session) upload completed, response: \(String(describing: String(data: responseData, encoding: .utf8)))")
    }
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
    let uploadProgress: Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
    print("session \(session) uploaded \(uploadProgress * 100)%.")
    progressView.progress = uploadProgress
  }

  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    responseData.append(data)
  }

  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
    print("session \(session), received response \(response)")
    completionHandler(URLSession.ResponseDisposition.allow)
  }

}
