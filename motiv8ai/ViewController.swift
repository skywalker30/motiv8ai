//
//  ViewController.swift
//  motiv8ai
//
//  Created by Roman Sukner on 12/04/2021.
//

import UIKit
import Starscream


class ViewController: UIViewController,WebSocketDelegate {

    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    var products: [Product] = []
    var viewModel: ProductsViewModel?
    
    @IBOutlet var tView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ProductsViewModel()
        tView?.dataSource = viewModel
        tView?.delegate = viewModel
        tView?.estimatedRowHeight = 100
        tView?.rowHeight = UITableView.automaticDimension
        
        
        var request = URLRequest(url: URL(string: "ws://superdo-groceries.herokuapp.com/receive")!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        
        
        self.viewModel?.startClick = {
            
            self.socket.connect()
        }
        
        self.viewModel?.stopClick = {
            
            self.socket.disconnect()
        }

        
        self.viewModel?.clearClick = {
            
            self.tView.reloadData();
        }

        
        
    }
    
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
                
                if let data = string.data(using: String.Encoding.utf8) as Data? {
                
                    let jsonDecoder = JSONDecoder()
                    guard let product = try? jsonDecoder.decode(Product.self, from: data) else { return  }
                    self.viewModel?.appendItem(product: product)
                    self.tView.reloadData()
                    
                }
                
                
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
                handleError(error)
        }
    }
    
    func handleError(_ error: Error?) {
        if let e = error as? WSError {
            print("websocket encountered an error: \(e.message)")
        } else if let e = error {
            print("websocket encountered an error: \(e.localizedDescription)")
        } else {
            print("websocket encountered an error")
        }
    }


}

