//
//  CoverFlowLayout.m
//  Cover Flow Layout
//
//  Created by Anthony Coelho on 2016-05-19.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import "CoverFlowLayout.h"

@implementation CoverFlowLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(self.collectionView.bounds.size.height * .6, self.collectionView.bounds.size.height * .6);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    CGRect visibleRegion;
    visibleRegion.origin = self.collectionView.contentOffset;
    visibleRegion.size = self.collectionView.bounds.size;


    for (UICollectionViewLayoutAttributes *cellAttributes in attributes) {
        
        double distanceFromCenter =  fabs(cellAttributes.center.x - (visibleRegion.origin.x + (visibleRegion.size.width/2)));
        
        double ratio = 1.0 -(distanceFromCenter / visibleRegion.size.width);

        
        cellAttributes.alpha = ratio;
        CATransform3D scale = CATransform3DMakeScale(ratio, ratio, 1.0);
        CATransform3D rotate = CATransform3DMakeRotation(ratio * 2 * M_PI, 0, 1, 0);

        cellAttributes.transform3D = CATransform3DConcat(scale,rotate);
    }
    
    
    return attributes;
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}


@end
