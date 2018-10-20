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
  阿里 腾讯 华为 百度 万达 三星
  光大银行 工商银行 民生银行 招商证券
  ABB 诺基亚 德勤 思科 戴尔 戴姆勒
  日立 通用电气
  方正 
  中交 中信 中治
  中国电信 中国电力 中国石油
  中国科学院 中国移动
  中国航空 中国联合网络通信
  中国邮政 中国铁路
  中铁 中青旅
}

units.each_with_index do |item, idx|
  name = item[:name]
  dataset = units.where(name: name)

  # step1: filter
  group0 = name
  group = group0.sub(%r{#{pats.join('|')}}, '') 
  puts "==#{idx}: #{group0} --> #{group}"

  # step2
  group0 = group
  hit = commons.find{|i| name.include?(i) }
  if hit
    group = hit 
    puts "==#{idx}: #{group0} --> #{group}"
  end

  dataset.update(group: group)
end

puts "==end"
