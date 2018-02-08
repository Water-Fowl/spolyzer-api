class Init < ActiveRecord::Migration[5.1]
  def change
    create_table :users, force: :cascade do |t|
      t.string :uid, null: false, default: ''
      t.string :provider, default: "email", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.string :name
      t.string :image
      t.string :email
      t.text :access_token
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
      t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
      t.timestamps
    end

    create_table :analysis_results, force: :cascade do |t|
      t.integer :user_id, null: false, index: true
      t.timestamps
    end

    create_table :games, force: :cascade do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :game_users, force: :cascade do |t|
      t.integer :user_id, null: false, index: true
      t.integer :game_id, null: false, index: true
    end

    create_table :shot_types, force: :cascade do |t|
      t.integer :sport_id, null: false, index: true
      t.string :name_ja, null: false
      t.string :name_en, null: false
    end

    create_table :scores, force: :cascade do |t|
      t.integer :game_id, null: false, index: true
      t.boolean :is_missed, default: false, null: false
      t.boolean :is_net_in, default: false, null: false
      t.timestamps null: false
    end

    create_table :positions, force: :cascade do |t|
      t.integer :score_id, null: false, index: true
      t.integer :dropped_at
      t.integer :side
      t.timestamps null: false
    end

    create_table :sports, force: :cascade do |t|
      t.string :name_ja, null: false
      t.string :name_en, null: false
    end

    create_table :sport_users, force: :cascade do |t|
      t.integer :user_id, null: false, index: true
      t.integer :sport_id, null: false, index: true
    end

    create_table :teams, force: :cascade do |t|
      t.string :name, null: false
    end

    create_table :team_users, force: :cascade do |t|
      t.integer :user_id, null: false, index: true
      t.integer :team_id, null: false, index: true
    end
  end
end
