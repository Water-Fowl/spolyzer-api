class ScoreGame < ApplicationRecord
    has_many :score
    has_many :score_game_to_users
    has_many :users, through: :score_game_to_users


    def get_scores
        scores = Score.where(score_game_id: self.id)
        score_left = scores.where(side: 0).count
        score_right = scores.where(side: 1).count
        return score_left, score_right
    end
   

    def is_win_user(user)
        score_game_to_users = ScoreGameToUser.where(score_game_id: self.id)
        users = self.get_users
        score_left, score_right = self.get_scores
        if score_left > score_right then
            win_score_game_to_users = score_game_to_users.where(court: 0)
        elsif score_left < score_right
            win_score_game_to_users = score_game_to_users.where(court: 1)
        else
            return false
        end
        
        win_user = win_score_game_to_users.where(user_id: user.id)
        if win_user.size > 0 then
            return true
        else
            return false
        end
    end

    def get_users(win = true)
        score_left, score_right = self.get_scores
        score_game_to_users = ScoreGameToUser.where(score_game_id: self.id)
        if score_left > score_right then
            win_score_game_to_users = score_game_to_users.where(court: 0)
            lose_score_game_to_users = score_game_to_users.where(court: 1)
        elsif score_left < score_right
            win_score_game_to_users = score_game_to_users.where(court: 1)
            lose_score_game_to_users = score_game_to_users.where(court: 0)
        else
            return None
        end
        #userのidのみを取得し、where文で取り出す。
        if win
            win_users = get_users_by_score_game_to_users(win_score_game_to_users)
            return win_users
        else
            lose_users = get_users_by_score_game_to_users(lose_score_game_to_users)
            return lose_users
        end
    end

    def get_users_by_score_game_to_users(score_game_to_users)
        user_id_list = []
        for score_game_to_user in score_game_to_users
            user_id_list.push(score_game_to_user.user_id)
        end
        users = User.where(id: user_id_list)
        return users
    end

end
