//
//  FavoriteTabTableViewController.h
//  honsulzip
//
//  Created by 박종찬 on 2017. 4. 16..
//  Copyright © 2017년 Jongchan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentDelegate.h"

@interface FavoriteTabTableViewController : UITableViewController

@property IBOutlet id <CustomSegmentDelegate> delegate;

@end
