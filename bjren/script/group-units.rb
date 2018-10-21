#!/usr/bin/env dbcli runsqlet
# self is Dba::ScriptRunner (lib/dba/script_runner.rb)
# conn is current Dba::ConnectionBuilder
sdb = conn.sequel_db

units = sdb.from(:units)
pats = %w(
  有限公司
  有限责任公司
)
commons = %w{
  阿里 腾讯 华为 百度 万达 小米
  三星 亚马逊 戴尔 思科
  ABB 诺基亚 德勤 戴姆勒
  日立 通用电气 宝马 苹果 英特尔 西门子 霍尼韦尔
  光大银行 工商银行 民生银行 北京农村商业
  招商证券
  中信 中粮 中治
  中国电信 中国移动 中国联合网络通信
  中国电力 中国石油
  中国科学院 中国航空
  中国邮政 中国铁路 首钢
  中铁 中青旅
  方正 同方 联想 神州数码 央视 高德
  新东方 文思海辉 用友 同仁堂 金山
}

units.each_with_index do |item, idx|
  name = item[:name]
  dataset = units.where(name: name)

  # step1: remove pattern words
  group0 = name
  group = group0.sub(%r{#{pats.join('|')}}, '') 
  puts "==#{idx}: #{group0} --> #{group}"

  # step2: common big corp
  group0 = group
  hit = commons.find{|i| name.include?(i) }
  if hit
    group = hit 
    puts "==#{idx}: #{group0} --> #{group}"
  end

  dataset.update(group: group)
end

puts "==end"
