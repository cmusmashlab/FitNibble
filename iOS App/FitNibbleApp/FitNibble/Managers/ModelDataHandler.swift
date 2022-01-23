////
////  ModelDataHandler.swift
////  FitByteTrial
////
////  Created by Yuchen Liang on 6/16/21.
////
//
//import Foundation
//import TensorFlowLite
//
///// Information about a model file or labels file.
//typealias FileInfo = (name: String, extension: String)
//enum MobileNet {
//    static let modelInfo: FileInfo = (name: "five-classes-Lite-TF-model-1-new", extension: "tflite")
//    static let labelsInfo: FileInfo = (name: "labelmap", extension: "txt")
//}
//
//
//class ModelDataHandler: ObservableObject {
//    let threadCount: Int
//    /// List of labels from the given labels file.
//    private var labels: [String] = ["silent","walking","drinking","talking","eating"]
//    
//    /// TensorFlow Lite `Interpreter` object for performing inference on a given model.
//    private var interpreter: Interpreter
//    public var inputData : [[Float32]]!
//    //    private var inputData : [[Float32]] = [[1.0, 2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.2]]
//    //    private var inputData : [[Float32]] = [[75.01 ,5 ,3 ,5,3,5,3,4,4,4,3,3,2,3,2,1,1,1,1,0,1,0,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0, 0,0,1,0,0,0,1,0,1,0,0,0,0,0,0, 0,0,0,0,0,0,0, 0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,1 ,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,0,0,0,0,0,0,0,75.01 ,5 ,3 ,5,3,5,3,4,4,4,3,3,2,3,2,1,1,1,1,0,1,0,1,0,0,1,0,1,0,1,0,1,0,0,0,0,0, 0,0,1,0,0,0,1,0,1,0,0,0,0,0,0, 0,0,0,0,0,0,0, 0,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,1 ,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,0,0,0,0,0,0,0]]
//    
//    //    private var inputData  = {[1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,1.0,2.2]}
//    
//    //    private var inputData = [0,1,2].compactMap({ _ in Float.random(in: 1.0 ..< 10.0) })
//    init?(modelFileInfo: FileInfo, labelsFileInfo: FileInfo, threadCount: Int = 42) {
//        //        self.inputData = [[0.0, 0.0,0.0,4.0,5.0,0.0,7.0,8.0,9.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,0.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,0.0,10.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,0.0,10.0,1.0,2.2]]
//        let modelFilename = modelFileInfo.name
//        // Construct the path to the model file.
//        guard let modelPath = Bundle.main.path(
//            forResource: modelFilename,
//            ofType: modelFileInfo.extension
//        ) else {
//            print("Failed to load the model file with name: \(modelFilename).")
//            return nil
//        }
//        
//        // MARK: Specify the options for the `Interpreter`.
//        self.threadCount = threadCount
//        var options = Interpreter.Options()
//        options.threadCount = threadCount
//        do {
//            // Create the `Interpreter`.
//            interpreter = try Interpreter(modelPath: modelPath, options: options)
//            // Allocate memory for the model's input `Tensor`s.
//            try interpreter.allocateTensors()
//        } catch let error {
//            print("Failed to create the interpreter with error: \(error.localizedDescription)")
//            return nil
//        }
//        // Load the classes listed in the labels file.
//        //        loadLabels(fileInfo: labelsFileInfo)
//        
//    }
//    // Loads the labels from the labels file and stores them in the `labels` property.
//    private func loadLabels(fileInfo: FileInfo) {
//        let filename = fileInfo.name
//        let fileExtension = fileInfo.extension
//        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: fileExtension) else {
//            fatalError("Labels file not found in bundle. Please add a labels file with name " +
//                        "\(filename).\(fileExtension) and try again.")
//        }
//        do {
//            let contents = try String(contentsOf: fileURL, encoding: .utf8)
//            labels = contents.components(separatedBy: .newlines)
//        } catch {
//            fatalError("Labels file named \(filename).\(fileExtension) cannot be read. Please add a " +
//                        "valid labels file and try again.")
//        }
//    }
//    func runModel(dataInput inputFeatures: [[Float32]]) -> String?
//    {
//        
//        //        let tt = inputFeatures
//        ////        let tt = [makeList(42)]
//        //        print (tt)
//        
//        
//        do{
//            try interpreter.allocateTensors()
//            
//            let byteData = float32ArrayToData(inputFeatures)
//            
//            try interpreter.copy(byteData, toInputAt: 0)
//            
//            
//            print("copied to input")
//            
//        }
//        catch {
//            // Couldn't create audio player object, log the error
//            print("Couldn't copy interpreter input")
//        }
//        
//        do {
//            
//            
//            try interpreter.invoke()
//            print("invoke")
//            let out : Tensor
//            out = try interpreter.output(at: 0)
//            
//            let size = MemoryLayout<Float32>.stride
//            
//            let predictions = out.data.withUnsafeBytes {
//                Array(UnsafeBufferPointer<Float32>(start: $0, count: out.data.count / size))}
//            print (predictions)
//            //            predictions = [0.0]
//            //            return labels[1]
//            if let unwrapped = predictions.max() {
//                print(unwrapped)
//                if let unrapped2 = predictions.firstIndex(of: unwrapped){
//                    print(labels[unrapped2])
//                    return labels[unrapped2]
//                    
//                }else{print("unrap error")}
//                //                print()
//                //                print(predictions[11])
//            } else {
//                print("Missing name.")
//            }
//            
//            
//            
//        }
//        catch{ print("Couldn't invoke interpreter")}
//        return "nil"
//        
//    }
//    private func makeList(_ n: Int) -> [Float32] {
//        return (0..<n).map { _ in .random(in: 1...50) }
//    }
//    private func float32ArrayToData(_ buffer: [[Float32]]) -> Data {
//        let floatData = buffer[0].map { $0 }
//        return floatData.withUnsafeBufferPointer(Data.init)
//    }
//    
//    func floatValue(data: Data) -> Float {
//        return Float(bitPattern: UInt32(bigEndian: data.withUnsafeBytes { $0.load(as: UInt32.self) }))
//    }
//    private func dataToFloatArray(_ data: Data) -> [Float]? {
//        guard data.count % MemoryLayout<Float>.stride == 0 else { return nil }
//        
//        #if swift(>=5.0)
//        return data.withUnsafeBytes { .init($0.bindMemory(to: Float.self)) }
//        #else
//        return data.withUnsafeBytes {
//            .init(UnsafeBufferPointer<Float>(
//                start: $0,
//                count: unsafeData.count / MemoryLayout<Element>.stride
//            ))
//        }
//        #endif // swift(>=5.0)
//    }
//    
//}
//
//// MARK: - Data
//extension Data {
//    /// Creates a new buffer by copying the buffer pointer of the given array.
//    ///
//    /// - Warning: The given array's element type `T` must be trivial in that it can be copied bit
//    ///     for bit with no indirection or reference-counting operations; otherwise, reinterpreting
//    ///     data from the resulting buffer has undefined behavior.
//    /// - Parameter array: An array with elements of type `T`.
//    init<T>(copyingBufferOf array: [T]) {
//        self = array.withUnsafeBufferPointer(Data.init)
//    }
//    
//    /// Convert a Data instance to Array representation.
//    func toArray<T>(type: T.Type) -> [T] where T: AdditiveArithmetic {
//        var array = [T](repeating: T.zero, count: self.count / MemoryLayout<T>.stride)
//        _ = array.withUnsafeMutableBytes { self.copyBytes(to: $0) }
//        return array
//    }
//}
//
//// MARK: - Wrappers
///// Struct for handling multidimension `Data` in flat `Array`.
//struct FlatArray<Element: AdditiveArithmetic> {
//    private var array: [Element]
//    var dimensions: [Int]
//    
//    init(tensor: Tensor) {
//        dimensions = tensor.shape.dimensions
//        array = tensor.data.toArray(type: Element.self)
//    }
//    
//    private func flatIndex(_ index: [Int]) -> Int {
//        guard index.count == dimensions.count else {
//            fatalError("Invalid index: got \(index.count) index(es) for \(dimensions.count) index(es).")
//        }
//        
//        var result = 0
//        for i in 0..<dimensions.count {
//            guard dimensions[i] > index[i] else {
//                fatalError("Invalid index: \(index[i]) is bigger than \(dimensions[i])")
//            }
//            result = dimensions[i] * result + index[i]
//        }
//        return result
//    }
//    
//    subscript(_ index: Int...) -> Element {
//        get {
//            return array[flatIndex(index)]
//        }
//        set(newValue) {
//            array[flatIndex(index)] = newValue
//        }
//    }
//}
