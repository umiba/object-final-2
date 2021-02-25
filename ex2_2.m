n = 50; % 先頭n枚を使用するのを指定、50 or 25

load('curry50_bgimg_dcnn_2.mat'); % 保存した学習用特徴を呼び出し
train_pos = database(1:n,:); % 先頭n枚をポジティブ画像
train_neg = database(51:1050,:); % ポジティブ画像は50枚で読み込んだので51枚目から1050枚目までをネガティブ画像として格納
train = [train_pos; train_neg]; % 一つの配列に格納
train_label=[ones(n, 1); ones(1000, 1)*(-1)]; % ラベルの生成

train_list = Training; % 学習画像のパス一覧

load('curry300_dcnn.mat'); % 再ランキング用の画像呼び出し
eval = database; % 全てをevalに再格納
eval_list = Training; % 評価画像の一覧

model = fitcsvm(train, train_label, 'KernelFunction', 'linear'); % 線形SVMで学習
[label, scores] = predict(model, eval); % 分類

% 降順でソートして、ソートした値とインデックスを取得する
[sorted_score,sorted_idx] = sort(scores(:,2),'descend');

 FID = fopen(strcat('ex2_',num2str(n),'.txt'),'w'); % 保存ファイル名の指定
for i=1:numel(sorted_idx)
    fprintf(FID, '%s %f\n',eval_list{sorted_idx(i)},sorted_score(i)); % ソートされたインデックスとスコアを出力
end

fclose(FID);

