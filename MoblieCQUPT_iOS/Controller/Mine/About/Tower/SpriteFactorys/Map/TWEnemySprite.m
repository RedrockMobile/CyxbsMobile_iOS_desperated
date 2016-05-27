#import "TWEnemySprite.h"

@implementation TWEnemySprite

-(id) copyWithZone:(NSZone *)zone
{
	TWEnemySprite *copy = [[[self class] allocWithZone:zone] initWithEmeny:self];
	return copy;
}

-(TWEnemySprite*) initWithEmeny:(TWEnemySprite *)copyform
{
    if ((self = [super init]))
    {
        self.enemyID = copyform.enemyID;
        self.name = copyform.name;
        self.HP = copyform.HP;
        self.Attack = copyform.Attack;
        self.Defense = copyform.Defense;
        self.Coin = copyform.Coin;
        self.Experience = copyform.Experience;
    }
    return self;
}

- (id)initWithTexture:(SKTexture *)texture withType:(int)type {
    self = [super initWithTexture:texture];
    if (self) {
        NSString *name;
        int HP,Attack,Defense,Coin,Experience;
        
        switch (type)
        {
            case 0:
                name = @"骷髅兵1";
                HP = 110;
                Attack = 25;
                Defense = 5;
                Coin = 5;
                Experience = 4;
                break;
            case 1:
                name = @"骷髅兵2";
                HP = 150;
                Attack = 40;
                Defense = 20;
                Coin = 8;
                Experience = 6;
                break;
            case 2:
                name = @"骷髅队长";
                HP = 400;
                Attack = 90;
                Defense = 50;
                Coin = 15;
                Experience = 12;
                break;
            case 3:
                name = @"冥队长";
                HP = 3500;
                Attack = 1280;
                Defense = 1000;
                Coin = 112;
                Experience = 100;
                break;
            case 4:
                name = @"小蝙蝠";
                HP = 100;
                Attack = 20;
                Defense = 5;
                Coin = 3;
                Experience = 3;
                break;
            case 5:
                name = @"大蝙蝠";
                HP = 150;
                Attack = 65;
                Defense = 30;
                Coin = 10;
                Experience = 8;
                break;
            case 6:
                name = @"红蝙蝠";
                HP = 550;
                Attack = 160;
                Defense = 90;
                Coin = 25;
                Experience = 20;
                break;
            case 7:
                name = @"boss";
                HP = 50000;
                Attack = 2800;
                Defense = 2700;
                Coin = 1000;
                Experience = 1000;
                break;
            case 8:
                name = @"绿球怪";
                HP = 50;
                Attack = 20;
                Defense = 1;
                Coin = 1;
                Experience = 1;
                break;
            case 9:
                name = @"红球怪";
                HP = 70;
                Attack = 15;
                Defense = 2;
                Coin = 2;
                Experience = 2;
                break;
            case 10:
                name = @"黑球怪";
                HP = 200;
                Attack = 35;
                Defense = 10;
                Coin = 5;
                Experience = 5;
                break;
            case 11:
                name = @"怪王";
                HP = 700;
                Attack = 250;
                Defense = 125;
                Coin = 32;
                Experience = 30;
                break;
            case 12:
                name = @"初级法师";
                HP = 125;
                Attack = 50;
                Defense = 25;
                Coin = 10;
                Experience = 7;
                break;
            case 13:
                name = @"高级法师";
                HP = 100;
                Attack = 200;
                Defense = 110;
                Coin = 30;
                Experience = 25;
                break;
            case 14:
                name = @"麻衣法师";
                HP = 250;
                Attack = 120;
                Defense = 70;
                Coin = 20;
                Experience = 17;
                break;
            case 15:
                name = @"红衣法师";
                HP = 500;
                Attack = 400;
                Defense = 260;
                Coin = 47;
                Experience = 45;
                break;
            case 16:
                name = @"兽面人";
                HP = 300;
                Attack = 75;
                Defense = 45;
                Coin = 13;
                Experience = 10;
                break;
            case 17:
                name = @"兽面武士";
                HP = 900;
                Attack = 450;
                Defense = 330;
                Coin = 50;
                Experience = 50;
                break;
            case 18:
                name = @"石头怪人";
                HP = 500;
                Attack = 115;
                Defense = 65;
                Coin = 15;
                Experience = 15;
                break;
            case 19:
                name = @"影子战士";
                HP = 3100;
                Attack = 1150;
                Defense = 1050;
                Coin = 92;
                Experience = 80;
                break;
            case 20:
                name = @"初级卫兵";
                HP = 450;
                Attack = 140;
                Defense = 85;
                Coin = 22;
                Experience = 19;
                break;
            case 21:
                name = @"冥卫兵";
                HP = 1250;
                Attack = 500;
                Defense = 400;
                Coin = 55;
                Experience = 55;
                break;
            case 22:
                name = @"高级卫兵";
                HP = 1500;
                Attack = 570;
                Defense = 480;
                Coin = 60;
                Experience = 60;
                break;
            case 23:
                name = @"双手剑客";
                HP = 1200;
                Attack = 620;
                Defense = 520;
                Coin = 65;
                Experience = 75;
                break;
            case 24:
                name = @"冥灵魔王";
                HP = 30000;
                Attack = 1700;
                Defense = 1500;
                Coin = 250;
                Experience = 220;
                break;
            case 44:
                name = @"黑衣魔王";
                HP = 20000;
                Attack = 1333;
                Defense = 1333;
                Coin = 130;
                Experience = 130;
                break;
            case 52:
                name = @"红衣魔王";
                HP = 15000;
                Attack = 1200;
                Defense = 1000;
                Coin = 100;
                Experience = 100;
                break;
            case 56:
                name = @"冥战士";
                HP = 2000;
                Attack = 680;
                Defense = 590;
                Coin = 70;
                Experience = 65;
                break;
            case 57:
                name = @"金卫士";
                HP = 850;
                Attack = 350;
                Defense = 200;
                Coin = 45;
                Experience = 40;
                break;
            case 58:
                name = @"金队长";
                HP = 900;
                Attack = 750;
                Defense = 650;
                Coin = 77;
                Experience = 70;
                break;
            case 59:
                name = @"灵武士";
                HP = 1600;
                Attack = 1306;
                Defense = 1200;
                Coin = 117;
                Experience = 100;
                break;
            case 53:
                name = @"白衣武士";
                HP = 1300;
                Attack = 300;
                Defense = 150;
                Coin = 40;
                Experience = 35;
                break;
            case 54:
                name = @"灵法师";
                HP = 2000;
                Attack = 1110;
                Defense = 980;
                Coin = 100;
                Experience = 90;
                break;
            default:
                break;
        }
        
        self.enemyID = type;
        self.name = name;
        self.HP = HP;
        self.Attack = Attack;
        self.Defense = Defense;
        self.Coin = Coin;
        self.Experience = Experience;
    }
    return self;
}

+(id)initWithType:(int)typeID
{
    TWEnemySprite *enemy = [[TWEnemySprite alloc] initWithTexture:nil withType:typeID];
    
    return enemy;
}

@end
