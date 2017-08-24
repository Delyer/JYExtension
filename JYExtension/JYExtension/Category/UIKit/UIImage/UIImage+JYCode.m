//
//  UIImage+JYCode.m
//  JYExtension
//
//  Created by Dely on 2017/8/18.
//  Copyright © 2017年 Dely. All rights reserved.
//

//
//  UIImage+JYCode.m
//  JYCode
//
//  Created by Dely on 2017/8/17.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIImage+JYCode.h"

@implementation UIImage (JYCode)

#pragma mark - --------------------公共二维码和条形码方法--------------------
/*生成二维码(黑白色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size{
    UIImage *QRImage = [self getQRWithString:string size:size foreColor:nil logoImage:nil logoRadius:0.0];
    return QRImage;
}

/*生成二维码(前景色)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor{
    UIImage *QRImage = [self getQRWithString:string size:size foreColor:foreColor logoImage:nil logoRadius:0.0];
    return QRImage;
}

/*生成二维码(前景色、logo)*/
+ (UIImage *)getQRWithString:(NSString *)string size:(CGFloat)size foreColor:(UIColor *)foreColor logoImage:(UIImage *)logo logoRadius:(CGFloat)radius{
    
    if (!string || [string class] == [NSNull null]) {
        return nil;
    }
    size = [self validateQRCodeSize:size];
    CIImage *QRCIImage = [self getQRCIImageWithString:string];
    
    //清晰化处理 这个就是黑白二维码图片可以直接使用了
    UIImage *QRImage = [self getImageWithCIImage:QRCIImage size:CGSizeMake(size, size)];
    
    //处理颜色log二维码图片
    UIImage *handleQRImage = [self getColorOrLogoQRImage:QRImage foreColor:foreColor logo:logo logoRadius:radius];
    
    return handleQRImage;
}

/* 生成线性渐变二维码(渐变颜色数组)*/
+ (UIImage *)getLineGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors{
    UIImage *QRImage = [self getLineGradientQRWithString:string size:size gradientColor:colors logoImage:nil logoRadius:0.0];
    return QRImage;
}

/* 生成线性渐变二维码(渐变颜色数组、logo、logo的圆角大小)*/
+ (UIImage *)getLineGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors logoImage:(UIImage *)logo logoRadius:(CGFloat)radius{
    if (!string || [string class] == [NSNull null]) {
        return nil;
    }
    size = [self validateQRCodeSize:size];
    CIImage *QRCIImage = [self getQRCIImageWithString:string];
    
    //清晰化处理 这个就是黑白二维码图片可以直接使用了
    UIImage *QRImage = [self getImageWithCIImage:QRCIImage size:CGSizeMake(size, size)];
    
    //线性渐变处理
    UIImage *lineQRImage = [self getLineGradientQRWithImage:QRImage size:size gradientColor:colors];
    
    //处理颜色log二维码图片
    UIImage *handleQRImage = [self getLogoQRImage:lineQRImage logo:logo logoRadius:radius];
    
    return handleQRImage;
}

/* 生成圆形渐变二维码(渐变颜色数组)*/
+ (UIImage *)getRoundGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors{
    
    UIImage *QRImage = [self getRoundGradientQRWithString:string size:size gradientColor:colors logoImage:nil logoRadius:0.0];
    return QRImage;
}

/* 生成圆形渐变二维码(渐变颜色数组、logo、logo的圆角大小)*/
+ (UIImage *)getRoundGradientQRWithString:(NSString *)string size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors logoImage:(UIImage *)logo logoRadius:(CGFloat)radius{
    if (!string || [string class] == [NSNull null]) {
        return nil;
    }
    size = [self validateQRCodeSize:size];
    CIImage *QRCIImage = [self getQRCIImageWithString:string];
    
    //清晰化处理 这个就是黑白二维码图片可以直接使用了
    UIImage *QRImage = [self getImageWithCIImage:QRCIImage size:CGSizeMake(size, size)];
    
    //圆形渐变处理
    UIImage *lineQRImage = [self getRoundGradientQRWithImage:QRImage size:size gradientColor:colors];
    
    //处理颜色log二维码图片
    UIImage *handleQRImage = [self getLogoQRImage:lineQRImage logo:logo logoRadius:radius];
    
    return handleQRImage;
}


/* 生成条形码*(iOS8.0以上适用)*/
+ (UIImage *)getBarWithString:(NSString *)string size:(CGSize)size{
    
    if (!string || [string class] == [NSNull null]) {
        return nil;
    }
    CIImage *barCIImage = [self getBarCIImageWithString:string];
    
    //清晰化处理
    UIImage *barImage = [self getImageWithCIImage:barCIImage size:size];
    
    return barImage;
}


#pragma mark - --------------------私有方法--------------------
//获取二维码尺寸合理性的大小（200~屏幕宽度-40）
+ (CGFloat)validateQRCodeSize:(CGFloat)size{
    size = MAX(200, size);
    size = MIN(CGRectGetWidth([UIScreen mainScreen].bounds) - 40, size);
    return size;
}

//获取二维码CIImage
+ (CIImage *)getQRCIImageWithString:(NSString *)string{
    
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *QRFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //通过kvo方式给一个字符串，生成二维码
    [QRFilter setValue:stringData forKey:@"inputMessage"];
    
    //设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    [QRFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    return QRFilter.outputImage;
}

//对图像进行清晰化处理
+ (UIImage *)getImageWithCIImage:(CIImage *)image size:(CGSize)size{
    
    if (image) {
        CGRect extent = CGRectIntegral(image.extent);
        CGFloat scaleWidth = size.width/CGRectGetWidth(extent);
        CGFloat scaleHeight = size.height/CGRectGetHeight(extent);
        size_t width = CGRectGetWidth(extent) * scaleWidth;
        size_t height = CGRectGetHeight(extent) * scaleHeight;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
        CGContextRef contentRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imageRef = [context createCGImage:image fromRect:extent];
        CGContextSetInterpolationQuality(contentRef, kCGInterpolationNone);
        CGContextScaleCTM(contentRef, scaleWidth, scaleHeight);
        CGContextDrawImage(contentRef, extent, imageRef);
        CGImageRef imageRefResized = CGBitmapContextCreateImage(contentRef);
        CGContextRelease(contentRef);
        CGImageRelease(imageRef);
        return [UIImage imageWithCGImage:imageRefResized];
    }
    
    return nil;
}


//处理颜色log二维码图片
+ (UIImage *)getColorOrLogoQRImage:(UIImage *)image foreColor:(UIColor *)foreColor logo:(UIImage *)logo logoRadius:(CGFloat)radius{
    UIImage *colorQRImage = [self getColorQRImage:image foreColor:foreColor];
    UIImage *logoQRImage = [self getLogoQRImage:colorQRImage logo:logo logoRadius:radius];
    return logoQRImage;
}


#pragma mark - -----填充颜色私有方法
//填充颜色
void ProviderReleaseData(void *info, const void *data, size_t size) {
    free((void *)data);
}

+ (UIImage *)getColorQRImage:(UIImage *)image foreColor:(UIColor *)foreColor{
    if (foreColor) {
        const int imageWidth = image.size.width;
        const int imageHeight = image.size.height;
        size_t bytesPerRow = imageWidth * 4;
        uint32_t * rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
        CGContextDrawImage(context, (CGRect){(CGPointZero), (image.size)}, image.CGImage);
        
        //遍历像素
        int pixelNumber = imageHeight * imageWidth;
        [self fillForeAndBackColor:rgbImageBuf pixelNum:pixelNumber foreColor:foreColor];
        
        CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow, ProviderReleaseData);
        CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider, NULL, true, kCGRenderingIntentDefault);
        
        UIImage * resultImage = [UIImage imageWithCGImage: imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        return resultImage;
    }
    return image;
}



// 遍历所有像素点，填充前景色和背景色（前景色为nil时设置为黑色，背景色nil时设置为透明）
+ (void)fillForeAndBackColor:(uint32_t *)rgbImageBuf pixelNum:(int)pixelNum foreColor:(UIColor *)foreColor{
    
    if (!foreColor) {
        return;
    }
    
    //前景色
    CGFloat foreR = 0.0, foreG = 0.0, foreB = 0.0, foreA = 0.0;
    [foreColor getRed:&foreR green:&foreG blue:&foreB alpha:&foreA];
    NSUInteger fR = foreR*255;
    NSUInteger fG = foreG*255;
    NSUInteger fB = foreB*255;
    
    uint32_t * pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++) {
        uint8_t * ptr = (uint8_t *)pCurPtr;
        if ((*pCurPtr & 0xffffff00) < 0x99999900) {
            ptr[3] = fR;
            ptr[2] = fG;
            ptr[1] = fB;
        }else {
            ptr[0] = 0;
            
        }
    }
}

#pragma mark - -----填充logo的私有方法
//填充logo
+ (UIImage *)getLogoQRImage:(UIImage *)image logo:(UIImage *)logo logoRadius:(CGFloat)radius{
    if (!logo) {
        return image;
    }
    
    CGFloat width = image.size.width;
    
    CGFloat logoWidth = width/5.0;
    logoWidth = MIN(100, logoWidth);
    
    logo = [UIImage imageChangeSizeWithImage:logo size:CGSizeMake(logoWidth, logoWidth)];
    
    logo = [UIImage getRoundedRectImage:logo size:CGSizeMake(logoWidth, logoWidth) radius:radius];
    
    CGFloat magin = 10.f;
    UIImage *whiteBackImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(logoWidth+magin, logoWidth+magin)];
    whiteBackImage = [UIImage getRoundedRectImage:whiteBackImage size:CGSizeMake(logoWidth+magin, logoWidth+magin) radius:radius];
    
    CGFloat logoX = (image.size.width - logo.size.width)/2.0;
    CGFloat logoY = (image.size.width - logo.size.width)/2.0;
    
    CGFloat whiteX = (image.size.width - logo.size.width - magin)/2.0;
    CGFloat whiteY = (image.size.width - logo.size.width - magin)/2.0;
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect: (CGRect){ 0, 0, (image.size) }];
    [whiteBackImage drawInRect:(CGRect){ whiteX, whiteY, (whiteBackImage.size)}];
    [logo drawInRect: (CGRect){ logoX, logoY, (logo.size)}];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

//根据颜色和大小获取一张图片
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//改变图片大小（会拉伸）
+ (instancetype)imageChangeSizeWithImage:(UIImage *)image size:(CGSize)size{
    
    CGFloat destW = size.width;
    CGFloat destH = size.height;
    
    CGFloat sourceW = size.width;
    CGFloat sourceH = size.height;
    
    CGImageRef imageRef = image.CGImage;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,destW,destH, CGImageGetBitsPerComponent(imageRef), 4*destW, CGImageGetColorSpace(imageRef),(kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap,CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    return result;
}


//获取圆角的图片
+ (instancetype)getRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(CGFloat)r{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    JYAddRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

static void JYAddRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight){
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0){
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


#pragma mark - -----线性渐变二维码私有方法
+ (UIImage *)getLineGradientQRWithImage:(UIImage *)image size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:maskLayer];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    NSMutableArray *CGColorArray = [NSMutableArray array];
    for (UIColor *color in colors) {
        [CGColorArray addObject:(__bridge id)color.CGColor];
    }
    
    gradientLayer.colors = CGColorArray;
    [imageView.layer addSublayer: gradientLayer];
    gradientLayer.frame = imageView.bounds;
    
    UIImage *maskImage = [self getLineGradientQRCodeImageMask:image];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    maskLayer.frame = imageView.bounds;
    gradientLayer.mask = maskLayer;
    
    UIImage *QRImage = [self getImageWithView:imageView withSize:imageView.frame.size];
    return QRImage;
}

+ (UIImage *)getLineGradientQRCodeImageMask:(UIImage *)image{
    if (image) {
        int bitsPerComponent = 8;
        int bytesPerPixel = 4;
        int width = image.size.width;
        int height = image.size.height;
        unsigned char * imageData = (unsigned char *)malloc(width * height * bytesPerPixel);
        
        // 将原始黑白二维码图片绘制到像素格式为ARGB的图片上，绘制后的像素数据在imageData中。
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef imageContext = CGBitmapContextCreate(imageData, width, height, bitsPerComponent, bytesPerPixel * width, colorSpace, kCGImageAlphaPremultipliedFirst);
        UIGraphicsPushContext(imageContext);
        CGContextTranslateCTM(imageContext, 0, height);
        CGContextScaleCTM(imageContext, 1, -1);
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        CGColorSpaceRelease(colorSpace);
        
        // 根据每个像素R通道的值修改Alpha通道的值，当Red大于100，则将Alpha置为0，反之置为255
        for (int row = 0; row < height; ++row) {
            for (int col = 0; col < width; ++col) {
                int offset = row * width * bytesPerPixel + col * bytesPerPixel;
                unsigned char r = imageData[offset + 1];
                unsigned char alpha = r > 100 ? 0 : 255;
                imageData[offset] = alpha;
            }
        }
        
        CGImageRef cgMaskImage = CGBitmapContextCreateImage(imageContext);
        UIImage *maskImage = [UIImage imageWithCGImage:cgMaskImage];
        CFRelease(cgMaskImage);
        UIGraphicsPopContext();
        CFRelease(imageContext);
        
        free(imageData);
        return maskImage;
    }
    
    return nil;
}


//根据View获取一张图片
+ (UIImage *)getImageWithView:(UIView *)view withSize:(CGSize)size{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - -----圆形渐变二维码私有方法

+ (UIImage *)getRoundGradientQRWithImage:(UIImage *)image size:(CGFloat)size gradientColor:(NSArray<UIColor *>*)colors{
    
    CGRect rect = CGRectMake(0, 0, size, size);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = imageView.bounds;
    [imageView.layer addSublayer:maskLayer];
    
    //创建CGContextRef
    UIGraphicsBeginImageContext(imageView.bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    //绘制Path
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    
    //绘制渐变
    [self drawRoundGradient:gc path:path colors:colors];
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.contents = (__bridge id)img.CGImage;
    [imageView.layer addSublayer: gradientLayer];
    gradientLayer.frame = imageView.bounds;
    
    UIImage *maskImage = [self getLineGradientQRCodeImageMask:image];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    maskLayer.frame = imageView.bounds;
    gradientLayer.mask = maskLayer;
    
    UIImage *QRImage = [self getImageWithView:imageView withSize:imageView.frame.size];
    return QRImage;
}

+ (void)drawRoundGradient:(CGContextRef)context path:(CGPathRef)path colors:(NSArray *)roundColors{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (roundColors.count < 1) {
        roundColors = @[[UIColor blackColor]];
    }
    
    NSInteger totalCount = roundColors.count;
    CGFloat loactions[totalCount];
    NSMutableArray *colors = [NSMutableArray array];
    
    for (NSInteger i = 0; i < roundColors.count; i++) {
        loactions[i] = 1.0/totalCount*(i+1);
        UIColor *color = [roundColors objectAtIndex:i];
        [colors addObject:(__bridge id)color.CGColor];
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, loactions);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

#pragma mark - -----条形码私有方法
//获取条形码CIImage
+ (CIImage *)getBarCIImageWithString:(NSString *)string{
    // iOS 8.0以上的系统才支持条形码的生成，iOS8.0以下使用第三方控件生成
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //注意生成条形码的编码方式
        NSData *data = [string dataUsingEncoding: NSASCIIStringEncoding];
        CIFilter *barFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
        [barFilter setValue:data forKey:@"inputMessage"];
        // 设置生成的条形码的上，下，左，右的margins的值
        [barFilter setValue:@(0) forKey:@"inputQuietSpace"];
        
        return barFilter.outputImage;
    }
    return nil;
}

@end
