チュートリアル
・Introduction to Infrastructure as Code with Terraform
クレデンシャル情報を記載したaws_config.tfを作成

・Installing Terraform
terraformをローカルにインストールし、terraformコマンドを実行できることを確認

・Build Infrastructure
・Change Infrastructure
・Destroy Infrastructure
「example.tf」でEC2を作成、EC2のAMI・インスタンスタイプを変更、削除
作成リソース
-EC2インスタンス(hirayama-test)
※DataDogの作成は省略

・Resource Dependencies
作成リソース
-ElasticIP(test-ip)
-S３バケット(hirayama-test)
-EC2インスタンス(hirayama-test-instance,hirayama-test-instance2)

・Provision
 「example.tf」でlocal-execを設定し、EC2インスタンス作成時にグローバルIPアドレスがip_address.txtに記述されることを確認
※key_pairの作成例題の実行がうまくいかず引き続き確認。

・Input Variables
変数を定義した「variables.tf」「terraform.tfvars」を作成

・Output Variables
「example.tf」でEIPのoutputを実装。IPアドレスが出力されることを確認。terraform output ipでIPアドレスが表示されることを確認。

・Modules
ECS構築課題のsecurity_groupをModulesを使用して実装
作成リソース
・hirayama-test-sg
・hirayama-test2-sg

・Remote State Storage
terraform cloudのアカウントを取得、ワークスペースを作り、ワークスペースにリモートで接続を試みているが、繋がっておらず引き続き調査。
