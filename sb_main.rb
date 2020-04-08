require 'sinatra'
require 'sinatra/reloader'

enable :sessions

class App < Sinatra::Base
    get '/' do
        @title = '暗号復号ツール!'
        @subtitle = '使ってね！'
        erb :index
    end
    post '/cip' do
        @title = '暗号復号ツール!'
        @subtitle = '使ってね！'
        @before1 = params[:sts1].to_s
        keyword = params[:sts1].to_s
        code = [] #暗号化した文字列を収納するための配列を定義
        j = 1
        keyword.chars.each do |char|
            if (65 <= char.ord && char.ord <= 90) then
                # a ~ m の場合，m=0, l, k... aまで+1し，2倍+1して鏡合わせ
                num1 = char.ord # スライスした集合？
                num2 = 77 - num1
                num5 = 2 * num2 + 1 + num1
            end  
            if (97 <= char.ord && char.ord <= 122) then
                # a ~ m の場合，m=0, l, k... aまで+1し，2倍+1して鏡合わせ
                num1 = char.ord # スライスした集合？
                num2 = 109 - num1
                num3 = 2 * num2 + 1 + num1
                # 以上で鏡写し完了
                num4 = num3 - 96 # a を 1 に，文字をずらして割り当て
                # num5を出力する．以下1, 2, 3, 1, 2... とずらす処理
                if (num4 == 26) then # zの時はcにする． てか == が使えるって，一文字ずつ処理されてるの？←ここは、例外の処理
                    num5 = 99                                                                #後は、法則に応じて一文字ずつ処理してる

                elsif (num4 % 3 == 0) then # c, f, i...
                    num4 = num4 - 1 # -> (num4 + 2) % 26 ?
                    num6 = (num4 + 3) % 26
                    num5 = num6 + 97
                    # cのときnum4 == 3, num5 == 118つまりv？
                    # num5 = num4 + 3 + 96 ?

                elsif (num4 % 3 == 1) then # a, d, g...(2つ飛ばし)
                    num5 = num4 + 97 # a->b(98)に． +1 されてる？←あってるよー
                                    
                else # b, e, h...(2つ(ry)
                    num5 = num4 + 98 # b->d(100)に． +2？←あってるよー 
                end
            elsif(48 <= char.ord && char.ord <= 58)then
                num1 = char.ord - 48
                num2 = (num1 + j) % 10
                num5 = num2 + 48
                if(j >= 3)then
                    j = 1
                        
                else
                    j = j + 1
                end
            end    
            code << num5.chr
        end
        @result1 = code.join("")
        erb :index
    end    
    post '/dec' do
        @title = '暗号復号ツール!'
        @subtitle = '使ってね！'
        @before2 = params[:sts2].to_s
        keyword = params[:sts2].to_s
        code = [] #暗号化した文字列を収納するための配列を定義
        j = 1
        keyword.chars.each do |char|
            if (65 <= char.ord && char.ord <= 90) then
                # a ~ m の場合，m=0, l, k... aまで+1し，2倍+1して鏡合わせ
                num1 = char.ord # スライスした集合？
                num2 = 77 - num1
                num5 = 2 * num2 + 1 + num1
            end  
            if (97 <= char.ord && char.ord<=122)then
                num = char.ord

                if(num == 97)then
                    num3 =120

                elsif((num+1)%3==0)then
                    num1 = num - 97
                    num2 = (num1 - 1) % 26
                    num3 = num2 + 97

                elsif((num+2)%3==0)then
                    num1 = num - 97
                    num2 = (num1 - 2) % 26
                    num3 = num2 + 97

                else
                    num1 = num - 97
                    num2 = (num1 - 3) % 26
                    num3 = num2 + 97
                end

                num4 = 109 - num3
                num5 = 2 * num4 + 1 + num3
                
            elsif(48 <= char.ord && char.ord <= 58)
                num1 = char.ord - 48
                num2 = (num1 - j) % 10
                num5 = num2 + 48
                if(j >= 3)then
                    j = 1
                    
                else
                    j = j + 1
                end 
            end
            code << num5.chr
        end
        @result2 = code.join("")
        erb :index
    end
end
App.run!