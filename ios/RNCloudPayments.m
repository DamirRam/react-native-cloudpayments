#import "RNCloudPayments.h"
#import "SDK/Card.h"
#import "NSString+URLEncoding.h"

#define POST_BACK_URL @"https://demo.cloudpayments.ru/WebFormPost/GetWebViewData"

typedef void (^RCTPromiseResolveBlock)(id result);
typedef void (^RCTPromiseRejectBlock)(NSString *code, NSString *message, NSError *error);

@property (nonatomic) RCTPromiseResolveBlock resolveWebView;
@property (nonatomic) RCTPromiseRejectBlock rejectWebView;

@end

@implementation RNCloudPayments

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(isValidNumber: (NSString *)cardNumber
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    if([Card isCardNumberValid: cardNumber]) {
        resolve(@YES);
    } else {
        resolve(@NO);
    }
};

RCT_EXPORT_METHOD(isValidExpired: (NSString *)cardExp
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    if([Card isExpiredValid: cardExp]) {
        resolve(@YES);
    } else {
        resolve(@NO);
    }
};

RCT_EXPORT_METHOD(getType: (NSString *)cardNumber
                  cardExp: (NSString *)cardExp
                  cardCvv: (NSString *)cardCvv
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    CardType cardType = [Card cardTypeFromCardNumber: cardNumber];
    NSString *cardTypeString = [Card cardTypeToString: cardType];
    
    resolve(cardTypeString);
}

RCT_EXPORT_METHOD(createCryptogram: (NSString *)cardNumber
                  cardExp: (NSString *)cardExp
                  cardCvv: (NSString *)cardCvv
                  publicId: (NSString *)publicId
                  resolve: (RCTPromiseResolveBlock)resolve
                  reject: (RCTPromiseRejectBlock)reject)
{
    Card *_card = [[Card alloc] init];
    
    NSString *cryptogram = [_card makeCardCryptogramPacket: cardNumber andExpDate:cardExp andCVV:cardCvv andMerchantPublicID:publicId];
    
    resolve(cryptogram);
}

@end
