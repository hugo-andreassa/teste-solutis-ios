//
//  ExtratoService.swift
//  teste-solutis
//
//  Created by Virtual Machine on 03/09/21.
//

import Foundation

protocol ExtractServiceDelegate {
    func didUpdateExtract(_ extractService: ExtractService, extractList: [ExtractModel])
    func didFailWithoutError(_ extractService: ExtractService, message: String)
    func didFailWithError(_ extractService: ExtractService, error: Error)
}

class ExtractService {
    var delegate: ExtractServiceDelegate?
    
    let apiUrl = NSLocalizedString("ApiURL", comment: "")
    
    func getExtract(token: String) {
        let url = apiUrl + "extrato"
        performRequest(with: url, token: token)
    }
    
    func performRequest(with urlString: String, token: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(token, forHTTPHeaderField: "token")
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(self, error: error!)
                    return
                }
                
                if (response as! HTTPURLResponse).statusCode > 299 {
                    self.delegate?.didFailWithoutError(self, message: "Ocorreu um erro desconhecido")
                    return
                }
                
                if let safeData = data {
                    if let extractList = self.parseJson(safeData) {
                        self.delegate?.didUpdateExtract(self, extractList: extractList)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(_ data: Data) -> [ExtractModel]? {
        do {
            let extractData = try JSONDecoder().decode([ExtractData].self, from: data)
            var extractList: [ExtractModel] = []
            
            for item in extractData {
                let extract = ExtractModel(description: item.descricao, value: item.valor, date: item.data)
                extractList.append(extract)
            }
            
            return extractList
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}
