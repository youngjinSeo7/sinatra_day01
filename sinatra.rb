require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'json'


get '/menu' do
    menu =["양자강","순남시래기","GS"]
    lunch = menu.sample(2)
    "점심에는" + lunch[0] + "을 먹고" + "저녁에는" + lunch[1] + "을 드세요."

end
# 점심에는 ? 을 먹고 저녁에는 ? 을 드세요.
# 조건: .samole함수는 1번만 사용가능

get '/lotto' do
    array = (1..45).to_a
    lotto = array.sample(6)
    "이번주 추천 로또 숫자는" + lotto.sort.to_s + "입니다." 
end

get '/check_lotto' do
    url = "http://m.nlotto.co.kr/common.do?method=getLottoNumber&drwNo=809"
    lotto = HTTParty.get(url)
    result = JSON.parse(lotto)
    numbers = []
    bonus = result["bnusNo"]
    result.each do |k, v|
        if k.include?("drwtNo") 
            numbers << v
        end
    end
    
    my_numbers = (1..45).to_a
    my_lotto = my_numbers.sample(6)
    
    count = 0 
    numbers.each do |num|
        count += 1 if my_lotto.include?(num)
    end
         puts "당첨 개수는" + count.to_s
    end
   



get '/html' do
    "<html>
        <head>
            <title>html test</title>
        </head>
        <body>
            <h1>안녕하세요?</h1>
        </body>
    <html>"
end


get '/kospi' do

    response = HTTParty.get("http://finance.daum.net/quote/kospi.daum?nil_stock=refresh")
    kospi = Nokogiri::HTML(response)

    result = kospi.css("#hyenCost > b")

    "현재 코스피 지수는 " + result.text + "포인트입니다."
    
end

get '/html_file' do
    @name = params[:name]
    erb :my_first_html
end

