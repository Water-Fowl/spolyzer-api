curl -X POST "http://localhost:3000/api/v1/games" -H "Content-Type: application/json" -d '{"players":{"left_user_id_1":1,"right_user_id_1":1,"left_user_id_2":1,"right_user_id_2":1},"score_game":{"left_team_id":3,"right_team_id":5,"game_time":"20171013T123030+0900","serve_user_id":3,"match_point":7,"deuce":true,"last_score_of_left":7,"last_score_of_right":5}, "scores":{"action":[1,2,3,4,5,6,7,8,9,10,11,12],"position":[0,4,2,5,6,7,5,6,6,4,3,4],"time_to_drop_shuttle":[10,33,45,100,135,145,200,333,444,555,600,700],"score_users":[3,19,3,3,3,19,19,19,3,19,3,3],"conceded_users":[19,3,19,19,19,3,3,3,19,3,19,19], "sides":[1,2,3,4,5,6,7,8,9,10,11,12]}}'
