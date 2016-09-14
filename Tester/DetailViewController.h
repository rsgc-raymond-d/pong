//
//  DetailViewController.h
//  Tester
//
//  Created by Daniel Raymond on 2016-09-14.
//  Copyright © 2016 Daniel Raymond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

