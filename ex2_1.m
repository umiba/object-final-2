net = resnet101; % ネットワークの指定
f = 'pool5'; % レイヤー指定

food = strcat('curry',num2str(50)); % 保存したmatファイル名の指定 クラスと画像枚数

load(strcat(food,'_list.mat'));
PosList = list;
load(strcat('bgimg_list.mat'));
NegList = list;
% それぞれ画像リストを呼び出し、ポジティブ画像用リストPosList
% ネガティブ画像用リストNegListに保存

Training={PosList{:} NegList{1:1000}};
% Trainingにポジティブ画像クラスはすべてを、ネガティブ画像は先頭1000枚をを並べて格納

%-- 再ランキング用の画像の特徴を抽出するとき --

% load('curry300_list.mat');
% Training = {list{:}};

%--

database = []; % 特徴点保存用配列
for i=1:length(Training)
    img = imread(Training{i}); % 画像の読み込み
    reimg = imresize(img,net.Layers(1).InputSize(1:2)); % ネットワークの入力サイズに合わせて画像をリサイズ
    dcnnf = activations(net,reimg,f); % 指定したレイヤーで特徴抽出
    dcnnf = squeeze(dcnnf); % ベクトル化
    dcnnf = dcnnf/norm(dcnnf); % 正規化
    database = [database; dcnnf.']; % databaseに保存
end

save(strcat(food,'_bgimg_dcnn_2.mat'),'database','Training'); % 取得したdcnn特徴をmatファイルに保存
%save('curry300_dcnn.mat', 'database', 'Training'); % 再ランキング用の場合