//
//  ZdlModel.m
//  ZDL_FMDB
//
//  Created by apple on 16/2/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZdlModel.h"
#import "SDImageCache.h"
@implementation ZdlModel
-(instancetype)initWithJson:(id)node
{
    self=[super init];
    if (self) {
        self.userName=[node objectForKey:@"newsID"];
        self.text=[node objectForKey:@"title"];
        self.imageUrl=[[[node objectForKey:@"images"] lastObject] objectForKey:@"url"];
        
    }
    return self;
}
@end
