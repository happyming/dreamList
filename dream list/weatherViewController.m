//
//  ViewController.m
//  testweather
//
//  Created by 光明 徐 on 14/12/27.
//  Copyright (c) 2014年 Guangming Xu. All rights reserved.
//

#import "weatherViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>



@interface weatherViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UILabel *labelLoading;

@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation weatherViewController


- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 开场ui动画设置
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_summer"]];
    //[self.loading startAnimating];
    self.locationManager.delegate = self;
    [self.loading startAnimating];
    
    //添加手势老更新天气信息
    UITapGestureRecognizer *singlePoint = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSinglePoind)];
    [self.view addGestureRecognizer:singlePoint];
    
    // 设置定位精确度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)handleSinglePoind
{
    [self.locationManager startUpdatingLocation];
    NSLog(@"in gesture");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if ([locations lastObject]) {
        CLLocation *location  = (CLLocation*)[locations lastObject];
        if (location.horizontalAccuracy) {
            NSLog(@"this in locationManager");
            [self.locationManager stopUpdatingLocation];
            [self getWeatherBylocation:location];
        }
    }
}

static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";

- (void)getWeatherBylocation:(CLLocation *)location
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    NSString *url = @"http://api.openweathermap.org/data/2.5/weather";
    NSDictionary *params = @{@"lat":[NSNumber numberWithDouble:location.coordinate.latitude],
                             @"lon":[NSNumber numberWithDouble:location.coordinate.longitude],
                             @"cnt":[NSNumber numberWithInt:0]};
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *resoult = (NSDictionary *)responseObject;
        //NSLog(@"json : %@",responseObject);
        [self updateUI:resoult];
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"网络连接失败");
            self.labelLoading.text = @"网络连接失败";
    }];
}


- (void)updateUI:(NSDictionary*)info
{
    self.labelLoading.text = @"";
    self.loading.hidden = true;
    [self.loading stopAnimating];
    
    if (info) {
        if (info[@"main"]) {
            if (info[@"main"][@"temp"]) {
                double temperature = [info[@"main"][@"temp"] doubleValue];
                self.temperature.text = [NSString stringWithFormat:@"温度: %.1f℃", temperature - 273.15];
                self.place.text = [NSString stringWithFormat:@"%@", info[@"name"]];
                //self.place.text = @"上海";
                [self updateWeatherIcon:info[@"weather"]];
                return;
            }
        }
    }
    
    self.labelLoading.text = @"天气信息不可用";
}

- (void)updateWeatherIcon:(NSArray *)weathers
{
    NSDictionary *weather = weathers[0];
    if (weather) {
        NSInteger condition = [weather[@"id"] integerValue];
        
        BOOL isNight = false;
        if ([weather[@"icon"] rangeOfString:@"n"].length ) {
            isNight = true;
        }
        
        if (condition < 300)
        {
            if (isNight) {
                self.iconImage.image = [UIImage imageNamed:@"tstorm1_night"];
            }
            else
            {
                self.iconImage.image = [UIImage imageNamed:@"tstorm1"];
            }
        }
        else if (condition < 500) {
            self.iconImage.image = [UIImage imageNamed:@"light_rain"];
        }
        
        else if (condition < 600) {
            self.iconImage.image = [UIImage imageNamed:@"shower3"];
        }
        else if (condition < 700) {
            self.iconImage.image = [UIImage imageNamed: @"snow4"];

        }
        
        else if (condition < 771) {
            if (isNight) {
                self.iconImage.image = [UIImage imageNamed: @"fog_night"];
            }
            else {
                self.iconImage.image = [UIImage imageNamed: @"fog"];
            }
        }
        
        // Tornado / Squalls
        else if (condition < 800) {
            self.iconImage.image = [UIImage imageNamed: @"tstorm3"];
        }
        // Sky is clear
        else if (condition == 800)
        {
            if (isNight) {
                 self.iconImage.image = [UIImage imageNamed: @"sunny_night"];
            }
            else {
                self.iconImage.image = [UIImage imageNamed: @"sunny"];
            }
        }
        
        // few / scattered / broken clouds
        else if (condition < 804) {
            if (isNight) {
                self.iconImage.image = [UIImage imageNamed: @"cloudy2_night"];
            }
            else {
                self.iconImage.image = [UIImage imageNamed: @"cloudy2"];
            }
        }
        // overcast clouds
        else if (condition == 804) {
            self.iconImage.image = [UIImage imageNamed: @"overcast"];
        }
        // Extreme
        else if ((condition >= 900 && condition < 903) || (condition > 904 && condition < 1000)) {
            self.iconImage.image = [UIImage imageNamed: @"tstorm3"];
        }
        // Cold
        else if (condition == 903) {
            self.iconImage.image = [UIImage imageNamed: @"snow5"];
        }
        else if (condition == 904) {
            self.iconImage.image = [UIImage imageNamed: @"sunny"];
        }
        // Weather condition is not available
        else {
            self.iconImage.image = [UIImage imageNamed: @"dunno"];
        }
    }
}

//获取定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    self.labelLoading.text = @"获取定位失败";
    self.temperature.text = @"";
    self.place.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
