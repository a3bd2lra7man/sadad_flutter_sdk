import Foundation


class ArgumentMapper{
    
    
    private func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func toSadadTransaction(arguments:Any)->SadadTransaction {
        let dataDic = convertToDictionary(text: arguments as! String);
        return SadadTransaction(dic: dataDic!)
    }
}
