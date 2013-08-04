//
//  UserInfo.h
//  TXWB-TEST
//
//  Created by xue on 13-7-6.
//  Copyright (c) 2013年 xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (assign, nonatomic) NSInteger birth_year;
@property (assign, nonatomic) NSInteger birth_month;
@property (assign, nonatomic) NSInteger birth_day;//-生日

@property (assign, nonatomic) NSInteger fansnum;//听众数
@property (assign, nonatomic) NSInteger favnum;//收藏数
@property (assign, nonatomic) NSInteger idolnum;//收听的人数

@property (copy, nonatomic) NSString *head;//头像url
@property (copy, nonatomic) NSString *name;//用户帐户名
@property (copy, nonatomic) NSString *nick;//用户昵称


@property (copy, nonatomic) NSString *homecity_code;//家乡所在城市id
@property (copy, nonatomic) NSString *homecountry_code;//家乡所在国家id
@property (copy, nonatomic) NSString *homepage;//个人主页
@property (copy, nonatomic) NSString *homeprovince_code;//家乡所在省id
@property (copy, nonatomic) NSString *hometown_code;//家乡所在镇id

@property (assign, nonatomic) NSInteger isent;//是否机构

@property (assign, nonatomic) NSInteger send_private_flag;//是否允许所有人给当前用户发私信，0-仅有偶像，1-名人+听众，2-所有人
@property (assign, nonatomic) NSInteger sex;//用户性别，1-男，2-女，0-未填写
@property (assign, nonatomic) NSDictionary *tagDic;//标签
@property (assign, nonatomic) NSInteger ismyblack;//是否在当前用户的黑名单中，0-不是，1-是
@property (assign, nonatomic) NSInteger ismyfans;//是否是当前用户的听众，0-不是，1-是
@property (assign, nonatomic) NSInteger ismyidol;//是否是当前用户的偶像，0-不是，1-是
@property (assign, nonatomic) NSInteger isrealname;//是否实名认证，1-已实名认证，2-未实名认证
@property (assign, nonatomic) NSInteger isvip;//是否认证用户，0-不是，1-是
@property (copy, nonatomic) NSString *location;//所在地
@property (assign, nonatomic) NSInteger mutual_fans_num;//互听好友数

@property (copy, nonatomic) NSString *openid;//用户唯一id，与name相对应
@property (assign, nonatomic) NSInteger province_code;//地区id
@property (assign, nonatomic) NSInteger regtime;//注册时间


@property (retain, nonatomic) NSDictionary *tweetinfoDic;//最近的一条原创微博信息
@property (retain, nonatomic) NSMutableArray *tweetinfoArr;
@property (copy, nonatomic) NSString *city_code_tweetinfo;//城市码
@property (copy, nonatomic) NSString *country_code_tweetinfo;//国家码
@property (assign, nonatomic) NSInteger emotiontype;//心情类型
@property (copy, nonatomic) NSString *emotionurl;//心情图片url
@property (copy, nonatomic) NSString *from;//来源
@property (copy, nonatomic) NSString *fromurl;//来源url
@property (copy, nonatomic) NSString *geo;//地理位置信息
@property (copy, nonatomic) NSString *id_WB;//微博唯一id
@property (copy, nonatomic) NSString *image;//图片url列表
@property (copy, nonatomic) NSString *latitude;//纬度
@property (copy, nonatomic) NSString *location_tweetinfo;//发表者所在地
@property (copy, nonatomic) NSString *longitude;//经度

//音频信息
@property (copy, nonatomic) NSDictionary *music;
/*
 author : 演唱者,
 url : 音频地址,
 title : 音频名字，歌名
 */
@property (copy, nonatomic) NSString *author;
@property (copy, nonatomic) NSString *url_Music;
@property (copy, nonatomic) NSString *title_Music;
//--音频信息

@property (copy, nonatomic) NSString *origtext;//原始内容
@property (assign, nonatomic) NSInteger province_code_tweetinfo;//省份码

@property (assign, nonatomic) NSInteger self_tweetinfo;//是否自已发的的微博，0-不是，1-是
@property (assign, nonatomic) NSInteger status;//微博状态，0-正常，1-系统删除，2-审核中，3-用户删除，4-根删除
@property (copy, nonatomic) NSString *text;//微博内容
@property (assign, nonatomic) NSInteger timestamp;//服务器时间戳，不能用于翻页
@property (assign, nonatomic) NSInteger type;//1-原创发表 2-转载 3-私信 4-回复 5-空回 6-提及 7-评论
@property (assign, nonatomic) NSInteger tweetnum;//发表微博数
@property (copy, nonatomic) NSString *verifyinfo;//认证信息
@property (assign, nonatomic) NSInteger exp;//经验值
@property (assign, nonatomic) NSInteger level;//微博等级
@property (assign, nonatomic) NSInteger seqid;//序列号
/////////////////////////////////////////////
/////////////////////////////////////////////
@property (retain, nonatomic) NSDictionary *videoDic;//视频信息
/*
 picurl : 缩略图,
 player : 播放器地址,
 realurl : 视频原地址,
 shorturl : 视频的短url,
 title : 视频标题
 */
@property (copy, nonatomic) NSString *picurl;//缩略图
@property (copy, nonatomic) NSString *player;//播放器地址
@property (copy, nonatomic) NSString *realurl;//视频原地址
@property (copy, nonatomic) NSString *shorturl;//视频的段url
@property (copy, nonatomic) NSString *title;//视频标题



//////////////////////
@property (assign, nonatomic) NSInteger industry_code;
@property (assign, nonatomic) NSString *city_code;
@property (copy, nonatomic) NSString *https_head;
@property (copy, nonatomic) NSString *introduction;
//////////////////////

///////////////////////////////////////////////////////
////////          微博信息特有属性         ///////////////
///////////////////////////////////////////////////////
@property (assign, nonatomic) NSInteger hasnext;//0-表示还有微博可拉取，1-已拉取完毕
/**
 {
 errcode : 返回错误码,
 msg : 错误信息,
 ret : 返回值，0-成功，非0-失败,
 data :
 {
 timestamp : 服务器时间戳，不能用于翻页,
 hasnext : 0-表示还有微博可拉取，1-已拉取完毕,
 info :
 {
 text : 微博内容,
 origtext : 原始内容,
 count : 微博被转次数,
 mcount : 点评次数,
 from : 来源,
 fromurl : 来源url,
 id : 微博唯一id,
 image : 图片url列表,
 video :
 {
 picurl : 缩略图,
 player : 播放器地址,
 realurl : 视频原地址,
 shorturl : 视频的短url,
 title : 视频标题
 },
 music :
 {
 author : 演唱者,
 url : 音频地址,
 title : 音频名字，歌名
 },
 name : 发表人帐户名,
 openid : 用户唯一id，与name相对应,
 nick : 发表人昵称,
 self : 是否自已发的的微博，0-不是，1-是,
 timestamp : 发表时间,
 type : 微博类型，1-原创发表，2-转载，3-私信，4-回复，5-空回，6-提及，7-评论,
 head : 发表者头像url,
 location : 发表者所在地,
 country_code : 国家码（其他时间线一样）,
 province_code : 省份码（其他时间线一样）,
 city_code : 城市码（其他时间线一样）,
 isvip : 是否微博认证用户，0-不是，1-是,
 geo : 发表者地理信息,
 status : 微博状态，0-正常，1-系统删除，2-审核中，3-用户删除，4-根删除,
 emotionurl : 心情图片url,
 emotiontype : 心情类型,
 source : 当type=2时，source即为源tweet
 },
 user :
 {
 name : nick 当页数据涉及到的用户的帐号与昵称映射
 }
 },
 seqid : 序列号
 }
 */

+ (UserInfo *)shareUserInfo;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
