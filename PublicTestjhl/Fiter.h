//
//  Fiter.h
//
//  Created by 焦梓杰 on 2019/4/17.
//  Copyright © 2019年 焦梓杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NZEROS 10
#define NPOLES 10

@interface Fiter : NSObject {
    float xv[NZEROS+1], yv[NPOLES+1];
}

- (float)processValue:(float)value;


@end
