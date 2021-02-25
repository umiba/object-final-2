food = 'curry'; % 対象のクラスを指定、ここではcurryのみ
n=300; % 画像枚数の指定, n=50 or 300
% urlは'url_curry_50.txt'の形式であらかじめ保存してある 後ろの50で枚数を指定
list = textread(strcat('url_', food,'_', num2str(n), '.txt'),'%s');

mkdir(strcat('imgdir2/', food, num2str(n))); % ディレクトリの生成

for i=1:n
    fname=strcat('imgdir2','/', food, num2str(n),'/',num2str(i,'%04d'),'.jpg') % ファイル名を作成
    websave(fname,list{i});
end