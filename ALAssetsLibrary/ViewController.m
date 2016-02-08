//
//  ViewController.m
//  ALAssetsLibrary
//
//  Created by apple on 08/02/16.
//  Copyright (c) 2016 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
    NSMutableArray  *photoArray;

    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mutableArray   =   [[NSMutableArray alloc] init];
    library   =   [[ALAssetsLibrary alloc] init];
    
    
    [self callingMethod];
  
 }



-(void)callingMethod{
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(group)
        {
          
            photoArray = [self getContentFrom:group withAssetFilter:[ALAssetsFilter allPhotos]];
            
            NSLog(@"%@", photoArray);
            float  topMargin    =   64;
            for(int i=3; i<photoArray.count; i++){
                
                UIImageView  *img   =   [[UIImageView alloc] initWithFrame: CGRectMake(10, topMargin, 50, 50)];
                
                img.image   =   [photoArray objectAtIndex:i];
                
                [self.view addSubview:img];
                
                topMargin+=100;
                
                
            }
            
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"Error Description %@",[error description]);
    }];
}
-(NSMutableArray *) getContentFrom:(ALAssetsGroup *) group withAssetFilter:(ALAssetsFilter *)filter
{
    NSMutableArray *contentArray = [NSMutableArray array];
    [group setAssetsFilter:filter];
      NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
             if(result)
        {
            
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
              
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                [contentArray addObject:url];
           
                          [mutableArray addObject:[UIImage imageWithCGImage:[[result defaultRepresentation] fullScreenImage]]];
                             }
                         }
              }];
    return mutableArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

@end


