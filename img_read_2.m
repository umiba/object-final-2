i=0; list={}; % ファイルパスを保存するセル配列を生成
n=300; %n = 50 or 300 学習用画像50枚か再ランキング用画像300枚かを表す。
food = 'curry'; % 画像クラス名指定、今回はcurryのみ
DIR0=strcat('imgdir2/',food, num2str(n),'/'); % imgdir2に使用する画像を保存しているためそのディレクトリをDIR0に格納
%DIR0 = 'bgimg/'; % ランダム画像bgimgを読み込む際
W=dir(DIR0); % DIR0内のファイル名を取得
for j=1:size(W)
    if (strfind(W(j).name,'.jpg')) % jpgのみ取得
      fn=strcat(DIR0,W(j).name);
      i=i+1;
      fprintf('[%d] %s\n',i,fn); % 保存枚数、名前を出力
	  list={list{:} fn}; % listにファイル名を保存していく
    end
end


save(strcat(food, num2str(n), '_list.mat'),'list') % クラス名、画像枚数と合わせてlistを保存
%save(strcat('bgimg_list.mat'),'list') % bgimgを保存する際