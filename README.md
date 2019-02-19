# Kawaii Dance Music Daisuki

## これは何か？
Ruby on Railsで作成した、SoundCloud上の曲を紹介するサイトです。  
私はカワイイダンスミュージックが大好きなので、  
Kawaii Dance Music Daisuki Ojisan's Playlist と名付けました。  
https://kawaii-music.herokuapp.com/  
Twitter投稿機能があり、Botとしても運用しています。  
[@kawaii_dance](https://twitter.com/kawaii_dance)

## 機能
### ユーザー向け画面
- 保存している曲をランダムに表示
- Ajaxでページ読み込み
- ジャンル別に曲を表示

### 管理画面
- タイトル、アーティスト名、url、紹介文を保存
- ジャンル、カテゴリー設定
- csv取り込み

### Twitter投稿
- rake taskによる実行
- ジャンル、カテゴリーからランダムに1つテーマを選び、その中の曲を投稿
- テーマは曲数に応じて選択される確率に重み付け
- Twitter投稿されていない曲を優先して投稿

## こだわったところ
### サイトデザイン
その名に恥じぬよう、カワイイデザインを意識しました。  
全体的なテーマは「ゆめかわ」です。  
Bootstrap等のフレームワークは使用せず、Sassで制作しました。

#### 背景
パステルカラーをグラデーション&ゆっくりアニメーションさせることで、  
背景色が徐々に変わるようにしました。  
朝焼けの光が移ろうようなエモさを表現しました。  
また、白い光の透過画像を重ね、キラキラ感を演出しました。

#### フォント
Google Fontsの"M PLUS Rounded"を使用しました。  
太い丸ゴシックでかわいさを出しました。

#### 曲紹介の要素
角丸、ドロップシャドウ、透過で柔らかさを表現しました。  
SoundCloudのiframe埋め込みにも角丸をつけています。

#### レスポンシブデザイン
Flexboxによる配置、screenサイズによる分岐を設定し、  
レスポンシブデザインにしました。

### 管理画面
#### 曲の絞り込み
紹介文、ジャンル、カテゴリが未設定の曲に絞り込んで表示する機能を実装し、  
曲紹介が未作成の曲を探しやすくしました。

#### Ajaxによる更新
曲編集画面ではAjaxを使い、曲紹介の編集がスムーズにできるようにしました。

#### ページネーション
kaminariによるページネーションを実装しました。

### Twitter投稿
#### テーマの選択
まずGenre、Categoryのどちらかをランダムに選択し、  
その中から1つレコードを選択するよう実装しました。  
テーマを選択するキーとなるidを選択する処理では、  
テーマに所属するTrack数が多いほど確率が高くなるようにしました。  
(Tracks#pick_theme 参照)

#### 曲の選択
Twitter投稿されていない曲が先に選択されるように実装しました。  
(Tracks#tweet_tracks 参照)
