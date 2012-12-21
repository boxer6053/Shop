//
//  BagCell.h
//  Shop
//
//  Created by Matrix Soft on 13.12.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BagCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productColorCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *productSizeCaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *productColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *productSizeLabel;

@end
