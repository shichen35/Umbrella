//
//  WeatherData.h
//  Umbrella
//
//  Created by Chen Shi on 9/15/17.
//  Copyright © 2017 Chen Shi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float fahrenheit;
    float celsius;
} UTemperature;

typedef enum {
    ClimaconCloud                   = '!',
    ClimaconCloudSun                = '"',
    ClimaconCloudMoon               = '#',
    
    ClimaconRain                    = '$',
    ClimaconRainSun                 = '%',
    ClimaconRainMoon                = '&',
    
    ClimaconRainAlt                 = '\'',
    ClimaconRainSunAlt              = '(',
    ClimaconRainMoonAlt             = ')',
    
    ClimaconDownpour                = '*',
    ClimaconDownpourSun             = '+',
    ClimaconDownpourMoon            = ',',
    
    ClimaconDrizzle                 = '-',
    ClimaconDrizzleSun              = '.',
    ClimaconDrizzleMoon             = '/',
    
    ClimaconSleet                   = '0',
    ClimaconSleetSun                = '1',
    ClimaconSleetMoon               = '2',
    
    ClimaconHail                    = '3',
    ClimaconHailSun                 = '4',
    ClimaconHailMoon                = '5',
    
    ClimaconFlurries                = '6',
    ClimaconFlurriesSun             = '7',
    ClimaconFlurriesMoon            = '8',
    
    ClimaconSnow                    = '9',
    ClimaconSnowSun                 = ':',
    ClimaconSnowMoon                = ';',
    
    ClimaconFog                     = '<',
    ClimaconFogSun                  = '=',
    ClimaconFogMoon                 = '>',
    
    ClimaconHaze                    = '?',
    ClimaconHazeSun                 = '@',
    ClimaconHazeMoon                = 'A',
    
    ClimaconWind                    = 'B',
    ClimaconWindCloud               = 'C',
    ClimaconWindCloudSun            = 'D',
    ClimaconWindCloudMoon           = 'E',
    
    ClimaconLightning               = 'F',
    ClimaconLightningSun            = 'G',
    ClimaconLightningMoon           = 'H',
    
    ClimaconSun                     = 'I',
    ClimaconSunset                  = 'J',
    ClimaconSunrise                 = 'K',
    ClimaconSunLow                  = 'L',
    ClimaconSunLower                = 'M',
    
    ClimaconMoon                    = 'N',
    ClimaconMoonNew                 = 'O',
    ClimaconMoonWaxingCrescent      = 'P',
    ClimaconMoonWaxingQuarter       = 'Q',
    ClimaconMoonWaxingGibbous       = 'R',
    ClimaconMoonFull                = 'S',
    ClimaconMoonWaningGibbous       = 'T',
    ClimaconMoonWaningQuarter       = 'U',
    ClimaconMoonWaningCrescent      = 'V',
    
    ClimaconSnowflake               = 'W',
    ClimaconTornado                 = 'X',
    
    ClimaconThermometer             = 'Y',
    ClimaconThermometerLow          = 'Z',
    ClimaconThermometerMediumLoew   = '[',
    ClimaconThermometerMediumHigh   = '\\',
    ClimaconThermometerHigh         = ']',
    ClimaconThermometerFull         = '^',
    ClimaconCelsius                 = '_',
    ClimaconFahrenheit              = '\'',
    ClimaconCompass                 = 'a',
    ClimaconCompassNorth            = 'b',
    ClimaconCompassEast             = 'c',
    ClimaconCompassSouth            = 'd',
    ClimaconCompassWest             = 'e',
    
    ClimaconUmbrella                = 'f',
    ClimaconSunglasses              = 'g',
    
    ClimaconCloudRefresh            = 'h',
    ClimaconCloudUp                 = 'i',
    ClimaconCloudDown               = 'j'
} Climacons;

static inline UTemperature UTemperatureMake(float fahrenheit, float celsius) {
    return (UTemperature){fahrenheit, celsius};
}

@interface WeatherData : NSObject

//  Display location
@property (copy, nonatomic) NSString *location;

//  Description of the day's conditions
@property (copy, nonatomic) NSString *conditionDescription;

//  Day's current temperature
@property (assign, nonatomic) UTemperature currentTemperature;

@property (copy, nonatomic) NSArray *forecast10Days;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
