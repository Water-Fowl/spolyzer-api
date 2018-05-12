# README

## 動作

```
git clone https://github.com/Water-Fowl/api.git
cp yamadからもらった.env path/to/project
cd path/to/project
bundle install --path vendor/bundle
bundle exec rails db:create db:migrate db:seed
```

```
bundle exec rails s
```

## 仕様

### `api/v1`

#### `games/:game_id/aggregated_scores`

*GET #index*

ある試合における`Score`の集計された値を返す
```
side(integer) : {
  position(integer):{
    shot_type_id(integer): {
      miss(0): count(integer),
      not_miss(1): count(integer)
    }
  }
}
```

#### `shot_types/:shot_type_id/aggregated_scores`
*GET #index*

複合分析によって集計された値を返す。
```
side(integer) : {
  position(integer):{
    shot_type_id(integer): count(integer)
  }
}
```
#### `user/search?name=hoge`
*GET #index*

`User`の名前から、`User`のリソースを返す。
#### `games`
*GET #index*

ログインしている`User`に紐づく`Game`を全て返す。

*POST #create*

`Game`と`Score`と`GameUnit`、必要であれば`Unit`と`UserUnit`を作成する。
作成された`Game`の値を返す。

#### `shot_types?sport_id=1`
*GET #index*

`sport_id`に該当するSportsに紐づいたshot_typesを返す。

#### `sports/:id`
*GET #index*

`Sport`を全て返す。

*GET #show*

idに該当する`Sport`を返す。

#### `users/:id`
*GET #show*

idに該当する`User`を返す。

*PATCH #update*

ログインしている`User`の情報を更新する。
更新された`User`を返す。
