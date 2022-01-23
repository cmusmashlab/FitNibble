//
//  MLModelDataManager.swift
//  FitByteTrial
//
//  Created by Yuchen Liang on 6/11/21.
//

import Foundation
import TensorFlowLite

typealias FileInfo = (name: String, extension: String)
enum MobileNet {
    static let modelInfo: FileInfo = (name: "Lite-TF-model-15", extension: "tflite")
}


class ModelDataHandler {
    let threadCount: Int
    /// List of labels from the given labels file.
//    private var labels: [String] = ["backward","forward","hold","left","right"]
    
    private var labels: [String] = ["drinking", "drinking_talking", "drinking_walking","drinking_walking_talking", "eating" ,"eating_drinking",
                                    "eating_drinking_talking", "eating_talking", "eating_walking",
                                    "eating_walking_talking" ,"none", "silent" ,"talking", "walking",
                                    "walking_talking"]

    /// TensorFlow Lite `Interpreter` object for performing inference on a given model.
    private var interpreter: Interpreter
    private var inputData : [[Float32]] = [[1.0, 2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.2]]
//    private var inputData : [[Float32]] = [[75.01 ,5 ,3 ,5,3,5,3,4,4,4,3,3,2,3,2,1,1,1,1,0,1,0,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0, 0,0,1,0,0,0,1,0,1,0,0,0,0,0,0, 0,0,0,0,0,0,0, 0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,1 ,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,0,0,0,0,0,0,0,75.01 ,5 ,3 ,5,3,5,3,4,4,4,3,3,2,3,2,1,1,1,1,0,1,0,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0, 0,0,1,0,0,0,1,0,1,0,0,0,0,0,0, 0,0,0,0,0,0,0, 0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,1 ,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,0,0,0,0,0,0,0]]
    
    
    init?(modelFileInfo: FileInfo, labelsFileInfo: FileInfo, threadCount: Int = 42) {
      let modelFilename = modelFileInfo.name
        // Construct the path to the model file.
        guard let modelPath = Bundle.main.path(
          forResource: modelFilename,
          ofType: modelFileInfo.extension
        ) else {
          print("Failed to load the model file with name: \(modelFilename).")
          return nil
        }

        // Specify the options for the `Interpreter`.
        self.threadCount = threadCount
        var options = Interpreter.Options()
        options.threadCount = threadCount
        do {
          // Create the `Interpreter`.
          interpreter = try Interpreter(modelPath: modelPath, options: options)
          // Allocate memory for the model's input `Tensor`s.
          try interpreter.allocateTensors()
        } catch let error {
          print("Failed to create the interpreter with error: \(error.localizedDescription)")
          return nil
        }
        // Load the classes listed in the labels file.
//        loadLabels(fileInfo: labelsFileInfo)
        
    }
    // Loads the labels from the labels file and stores them in the `labels` property.
    private func loadLabels(fileInfo: FileInfo) {
      let filename = fileInfo.name
      let fileExtension = fileInfo.extension
      guard let fileURL = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
        fatalError("Labels file not found in bundle. Please add a labels file with name " +
                     "\(filename).\(fileExtension) and try again.")
      }
      do {
        let contents = try String(contentsOf: fileURL, encoding: .utf8)
        labels = contents.components(separatedBy: .newlines)
      } catch {
        fatalError("Labels file named \(filename).\(fileExtension) cannot be read. Please add a " +
                     "valid labels file and try again.")
      }
    }
    
    func runModel()
    {

//        let inputTensor: Tensor
        do{

            let byteData = float32ArrayToData(inputData)
//
        try interpreter.copy(byteData, toInputAt: 0)
            
//            try interpreter.copy(inputData, toInputAt: 0)

        print("copied to input")
        
        }
        catch {
            // Couldn't create audio player object, log the error
            print("Couldn't copy interpreter input")
        }
        
        do {
            try interpreter.invoke()
            print("invoke")
            let out : Tensor
            out = try interpreter.output(at: 0)
            //convert output
            let size = MemoryLayout<Float32>.stride
            let predictions = out.data.withUnsafeBytes {
                Array(UnsafeBufferPointer<Float32>(start: $0, count: out.data.count / size))}
//            if let unwrapped = predictions.max() {
//                print(unwrapped)
//                print(predictions.firstIndex(of: unwrapped))
//                print(predictions[11])
//            } else {
//                print("Missing name.")
//            }

            print ( predictions)
//            print("invoke2")
        }
        catch{ print("Couldn't invoke interpreter")}
    }
    private func float32ArrayToData(_ buffer: [[Float32]]) -> Data {
       let floatData = buffer[0].map { $0 }
       return floatData.withUnsafeBufferPointer(Data.init)
     }
    
    
    
}
