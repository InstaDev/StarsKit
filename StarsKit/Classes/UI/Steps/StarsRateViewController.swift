// The MIT License (MIT)
//
// Copyright (c) 2018 Smart&Soft
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import Cosmos

public class StarsRateViewController: StepViewController {
  
  weak var ibStarsRateView: StarsView!
  @IBOutlet weak var ibSmileyRateView: SmileyRateView!
  @IBOutlet weak var ibStackView: UIStackView!
  
  @IBOutlet var ibRateViews: [RateView]!
  
  init(graphicContext: StarsKitGraphicContext, coordinator: RatingCoordinator) {
    let nibName = "StarsRateViewController"
    let bundle: Bundle = Bundle.bundleForResource(name: nibName, ofType: "nib")
    super.init(nibName: nibName, bundle: bundle)
    self.graphicContext = graphicContext
    self.coordinator = coordinator
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareViews() {
    super.prepareViews()
    
    if !StarsKit.shared.validateRatingButtonEnable {
      self.ibActionButton?.isHidden = true
    } else {
      self.ibActionButton?.isHidden = false
      self.ibActionButton?.isEnabled = false
    }
    
    for rateView in self.ibRateViews {
      rateView.delegate = self
    }
    
    if StarsKit.shared.customImageMode {
     self.ibStarsRateView.removeFromSuperview()
      self.ibSmileyRateView.computeView()
    } else {
      self.ibSmileyRateView.removeFromSuperview()
    }
  }
  
  @IBAction func didTapActionButton(_ sender: Any) {
    self.coordinator?.validateRating(to: StarsKit.shared.customImageMode ?self.ibSmileyRateView.rating : self.ibStarsRateView.rating )
  }
  
  @IBAction public func didChooseDismissAction(_ sender: Any) {
    self.coordinator?.later()
  }
  
}

extension StarsRateViewController: RateViewDelegate {
  
  public func onSelectRate(rating: Double) {
    self.coordinator?.endRating(to: rating)
    self.ibActionButton?.isEnabled = true
  }
  
}
